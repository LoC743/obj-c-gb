//
//  MapBuilder.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#import "MapViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapBuilder : NSObject

+ (UIViewController<MapViewInput>*)build;

@end

NS_ASSUME_NONNULL_END
