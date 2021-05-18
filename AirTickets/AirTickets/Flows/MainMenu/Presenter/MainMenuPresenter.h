//
//  MainMenuPresenter.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainMenuRouter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainMenuViewInput <NSObject>

@end

@protocol MainMenuViewOutput <NSObject>

- (void)viewDidMoveToFromWhere;
- (void)viewDidMoveToWhere;

@end

@interface MainMenuPresenter : NSObject <MainMenuViewOutput>

@property (strong, nonatomic) NSObject<MainMenuRouterInput> *router;
@property (weak, nonatomic) UIViewController<MainMenuViewInput> *viewInput;

- (instancetype)initWithRouter:(NSObject<MainMenuRouterInput>*)router;

@end

NS_ASSUME_NONNULL_END
