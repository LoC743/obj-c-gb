//
//  PlaceInteractor.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlaceInteractorInput <NSObject>

- (NSArray *)loadCities;
- (NSArray *)loadAirports;

@end

@interface PlaceInteractor : NSObject <PlaceInteractorInput>

@end

NS_ASSUME_NONNULL_END
