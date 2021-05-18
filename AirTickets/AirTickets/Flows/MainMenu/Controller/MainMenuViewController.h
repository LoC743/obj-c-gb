//
//  MainMenuViewController.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <UIKit/UIKit.h>
#import "MainMenuPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainMenuViewController : UIViewController <MainMenuViewInput>

@property (strong, nonatomic) NSObject<MainMenuViewOutput> *presenter;

- (instancetype)initWithPresenter:(NSObject<MainMenuViewOutput>*)presenter;

@end

NS_ASSUME_NONNULL_END
