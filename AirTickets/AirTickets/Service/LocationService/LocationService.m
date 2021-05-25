//
//  LocationService.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "LocationService.h"

@interface LocationService () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) CLLocation *nearestCities;

@end

@implementation LocationService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [CLLocationManager new];
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
    }
    return self;
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        manager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    } else if (manager.authorizationStatus != kCLAuthorizationStatusNotDetermined) {
        NSLog(@"[Warning]: location status is not determined!");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    if (!self.currentLocation) {
        self.currentLocation = [locations firstObject];
        [self.locationManager stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServiceDidUpdateCurrentLocation object:self.currentLocation];
    }
}
@end
