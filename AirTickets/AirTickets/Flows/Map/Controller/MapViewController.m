//
//  MapViewController.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "MapViewController.h"
#import "LocationService.h"

@interface MapViewController ()


@end

@implementation MapViewController

- (instancetype)initWithPresenter:(NSObject<MapViewOutput> *)presenter {
    self = [super init];
    if (self) {
        self.presenter = presenter;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view = [MapView new];
}

- (MapView *)mapView {
    return (MapView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mapView].mapKitView.delegate = self;
    
    [DataManager.sharedInstance loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
}

- (void)dataLoadedSuccessfully {
    [self.presenter dataLoadedSuccessfully];
}

- (void)updateCurrentLocation:(NSNotification *)notification {
    [self.presenter updateCurrentLocation:notification];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (NSString *)annotationReuseIdentifier {
    return @"MarkerIdentifier";
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MapViewController.annotationReuseIdentifier];
    
    if (!annotationView) {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MapViewController.annotationReuseIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        SimpleMapPrice *price = [[SimpleMapPrice alloc] initWithDestination:annotation.title withPrice:annotation.subtitle];
        if ([CoreDataStorage.sharedInstance isFavouriteMapPrice:price]) {
            [button setImage:[UIImage systemImageNamed:@"star.fill"] forState:normal];
        } else {
            [button setImage:[UIImage systemImageNamed:@"star"] forState:normal];
        }
        annotationView.rightCalloutAccessoryView = button;
    }
    
    annotationView.annotation = annotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с меткой" message:@"Что необходимо сделать с выбранной меткой?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    SimpleMapPrice *price = [[SimpleMapPrice alloc] initWithDestination:view.annotation.title withPrice:view.annotation.subtitle];
    if ([CoreDataStorage.sharedInstance isFavouriteMapPrice:price]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [CoreDataStorage.sharedInstance removeFromFavouriteMapPrice:price];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [button setImage:[UIImage systemImageNamed:@"star"] forState:normal];
            view.rightCalloutAccessoryView = button;
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [CoreDataStorage.sharedInstance addToFavouriteMapPrice:price];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [button setImage:[UIImage systemImageNamed:@"star.fill"] forState:normal];
            view.rightCalloutAccessoryView = button;
            
        }];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
