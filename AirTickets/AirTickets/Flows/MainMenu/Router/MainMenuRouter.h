//
//  MainMenuRouter.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlaceType.h"
#import "DataManager.h"


NS_ASSUME_NONNULL_BEGIN

@protocol MainMenuDelegate <NSObject>

- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;

@end

@protocol MainMenuRouterInput <NSObject>

- (void)moveToDepartureWithMenuDelegate:(NSObject<MainMenuDelegate>*)delegate;
- (void)moveToArrivalWithMenuDelegate:(NSObject<MainMenuDelegate>*)delegate;

@end

@interface MainMenuRouter : NSObject <MainMenuRouterInput>

@property (weak, nonatomic) UIViewController *viewController;

@end

NS_ASSUME_NONNULL_END
