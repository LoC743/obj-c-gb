//
//  MapInteractor.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "MapInteractor.h"

@implementation MapInteractor

- (City *)loadCityForLocation:(CLLocation *)currentLocation {
    return [DataManager.sharedInstance cityForLocation:currentLocation];
}

- (void)loadMapPricesForOrigin:(City *)origin withCompletion:(void (^)(NSArray *prices))completion {
    [APIManager.sharedInstance mapPricesFor:origin withCompletion:completion];
}

@end
