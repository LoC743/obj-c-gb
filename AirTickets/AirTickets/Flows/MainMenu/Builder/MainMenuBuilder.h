//
//  MainMenuBuilder.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainMenuPresenter.h"
#import "MainMenuRouter.h"
#import "MainMenuViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainMenuBuilder : NSObject

+ (UIViewController<MainMenuViewInput>*)build;

@end

NS_ASSUME_NONNULL_END
