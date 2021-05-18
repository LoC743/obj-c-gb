//
//  PlaceRouter.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlaceRouterInput <NSObject>


@end

@interface PlaceRouter : NSObject <PlaceRouterInput>

@property (weak, nonatomic) UIViewController *viewController;

@end

NS_ASSUME_NONNULL_END
