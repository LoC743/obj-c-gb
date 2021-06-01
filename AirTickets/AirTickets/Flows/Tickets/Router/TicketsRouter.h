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

- (void)showAlertWithAction:(UIAlertAction *)action;

@end

@interface TicketsRouter : NSObject <TicketsRouterInput>

@property (weak, nonatomic) UIViewController *viewController;

- (void)showAlertWithAction:(UIAlertAction *)action;

@end

NS_ASSUME_NONNULL_END
