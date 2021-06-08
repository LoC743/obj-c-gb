//
//  MapPresenter.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "MapPresenter.h"
#import "MapPrice.h"

@implementation MapPresenter

- (instancetype)initWithRouter:(NSObject<MapRouterInput> *)router withInteractor:(NSObject<MapInteractorInput> *)interactor {
    self = [super init];
    if (self) {
        self.router = router;
        self.interactor = interactor;
    }
    return self;
}

- (void)dataLoadedSuccessfully {
    self.viewInput.locationService = [LocationService new];
}

- (void)updateCurrentLocation:(NSNotification *)notification {
    CLLocation *currentLocation = notification.object;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
    [self.viewInput.mapView.mapKitView setRegion: region animated: YES];
    
    if (currentLocation) {
        self.viewInput.origin = [self.interactor loadCityForLocation:currentLocation];
        if (self.viewInput.origin) {
            [self.interactor loadMapPricesForOrigin:self.viewInput.origin withCompletion:^(NSArray * _Nonnull prices) {
                self.viewInput.prices = prices;
                [self setPrices:prices];
            }];
        }
    }
}

- (void)setPrices:(NSArray *)prices {
    self.viewInput.prices = prices;
    [self.viewInput.mapView.mapKitView removeAnnotations: self.viewInput.mapView.mapKitView.annotations];
 
    for (MapPrice *price in prices) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
            annotation.subtitle = [NSString stringWithFormat:@"%ld %@.", price.value, NSLocalizedString(@"rubles", "")];
            annotation.coordinate = price.destination.coordinate;
            [self.viewInput.mapView.mapKitView addAnnotation: annotation];
        });
    }
}

@end
