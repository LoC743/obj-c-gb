//
//  TicketsPresenter.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TicketsViewInput <NSObject>


@end

@protocol TicketsViewOutput <NSObject>

@end

@interface TicketsPresenter : NSObject <TicketsViewOutput>

@property (weak, nonatomic) UIViewController<TicketsViewInput> *viewInput;

@end

NS_ASSUME_NONNULL_END
