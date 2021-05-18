//
//  PlaceBuilder.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "PlaceBuilder.h"

@implementation PlaceBuilder

+ (UIViewController<PlaceViewInput>*)buildWithMenuDelegate:(NSObject<MainMenuDelegate>*)mainMenuDelegate andPlaceType:(PlaceType)placeType {
    PlaceInteractor *interactor = [PlaceInteractor new];
    PlaceRouter *router = [PlaceRouter new];
    PlacePresenter *presenter = [[PlacePresenter alloc] initWithRouter:router withInteractor:interactor];
    presenter.delegate = mainMenuDelegate;
    
    PlaceViewController *viewController = [[PlaceViewController alloc] initWithPresenter:presenter andPlaceType:placeType];
    
    presenter.viewInput = viewController;
    router.viewController = viewController;
    
    return viewController;
}


@end
