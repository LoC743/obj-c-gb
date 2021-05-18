//
//  MainMenuRouter.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MainMenuRouterInput <NSObject>

-(void)moveToFromWhere;
-(void)moveToWhere;

@end

@interface MainMenuRouter : NSObject <MainMenuRouterInput>

@property (weak, nonatomic) UIViewController *viewController;

@end

NS_ASSUME_NONNULL_END
