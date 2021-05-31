//
//  MainMenuBuilder.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuBuilder.h"

@implementation MainMenuBuilder

+ (UIViewController<MainMenuViewInput>*)build {
    MainMenuInteractor *interactor = [MainMenuInteractor new];
    MainMenuRouter *router = [MainMenuRouter new];
    MainMenuPresenter *presenter = [[MainMenuPresenter alloc] initWithRouter:router withInteractor:interactor];
    
    MainMenuViewController *viewController = [[MainMenuViewController alloc] initWithPresenter:presenter];
    presenter.viewInput = viewController;
    router.viewController = viewController;
    
    return viewController;
}

@end
