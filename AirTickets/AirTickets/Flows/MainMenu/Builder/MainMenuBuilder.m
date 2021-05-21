//
//  MainMenuBuilder.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuBuilder.h"

@implementation MainMenuBuilder

+ (UIViewController<MainMenuViewInput>*)build {
    MainMenuRouter *router = [MainMenuRouter new];
    MainMenuPresenter *presenter = [[MainMenuPresenter alloc] initWithRouter:router];
    
    MainMenuViewController *viewController = [[MainMenuViewController alloc] initWithPresenter:presenter];
    presenter.viewInput = viewController;
    router.viewController = viewController;
    
    return viewController;
}

@end
