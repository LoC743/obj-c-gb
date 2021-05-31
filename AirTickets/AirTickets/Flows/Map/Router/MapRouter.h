//
//  MapRouter.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol MapRouterInput <NSObject>

@end

@interface MapRouter : NSObject <MapRouterInput>

@property (weak, nonatomic) UIViewController *viewController;

@end

NS_ASSUME_NONNULL_END
