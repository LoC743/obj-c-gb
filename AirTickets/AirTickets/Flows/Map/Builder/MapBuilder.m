//
//  MapBuilder.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "MapBuilder.h"

@implementation MapBuilder

+ (UIViewController<MapViewInput>*)build {
    MapInteractor *interactor = [MapInteractor new];
    MapRouter *router = [MapRouter new];
    MapPresenter *presenter = [[MapPresenter alloc] initWithRouter:router withInteractor:interactor];
    
    MapViewController *viewController = [[MapViewController alloc] initWithPresenter:presenter];
    
    presenter.viewInput = viewController;
    router.viewController = viewController;
    
    return viewController;
}

@end
