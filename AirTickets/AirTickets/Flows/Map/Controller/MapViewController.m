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

@end
