//
//  MapInteractor.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MapInteractorInput <NSObject>

- (City *)loadCityForLocation:(CLLocation *)currentLocation;

- (void)loadMapPricesForOrigin:(City *)origin withCompletion:(void (^)(NSArray *prices))completion;

@end

@interface MapInteractor : NSObject <MapInteractorInput>

- (City *)loadCityForLocation:(CLLocation *)currentLocation;

- (void)loadMapPricesForOrigin:(City *)origin withCompletion:(void (^)(NSArray *prices))completion;

@end

NS_ASSUME_NONNULL_END
