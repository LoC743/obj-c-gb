//
//  TicketsRouter.h
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TicketsRouterInput <NSObject>

- (void)showAlertWithActions:(NSArray *)actions;

@end

@interface TicketsRouter : NSObject <TicketsRouterInput>

@property (weak, nonatomic) UIViewController *viewController;

- (void)showAlertWithActions:(NSArray *)actions;

@end

NS_ASSUME_NONNULL_END
