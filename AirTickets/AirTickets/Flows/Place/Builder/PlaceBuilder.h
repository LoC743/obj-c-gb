//
//  PlaceBuilder.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>
#import "PlaceViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceBuilder : NSObject

+ (UIViewController<PlaceViewInput>*)buildWithMenuDelegate:(NSObject<MainMenuDelegate>*)mainMenuDelegate andPlaceType:(PlaceType)placeType;

@end

NS_ASSUME_NONNULL_END
