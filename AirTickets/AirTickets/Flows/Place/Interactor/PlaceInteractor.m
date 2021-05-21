//
//  PlaceInteractor.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "PlaceInteractor.h"
#import "DataManager.h"

@implementation PlaceInteractor

- (nonnull NSArray *)loadAirports {
    return [DataManager.sharedInstance airports];
}

- (nonnull NSArray *)loadCities {
    return [DataManager.sharedInstance cities];
}

@end
