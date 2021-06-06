//
//  TicketsBuilder.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "TicketsBuilder.h"

@implementation TicketsBuilder

+ (UIViewController<TicketsViewInput>*)buildWithTickets:(NSArray *)tickets {
    TicketsInteractor *interactor = [TicketsInteractor new];
    TicketsRouter *router = [TicketsRouter new];
    TicketsPresenter *presenter = [[TicketsPresenter alloc] initWithRouter:router withInteractor:interactor];
    
    TicketsTableViewController *viewController = [[TicketsTableViewController alloc] initWithPresenter:presenter];
    viewController.tickets = tickets;
    presenter.viewInput = viewController;
    router.viewController = viewController;
    
    return viewController;
}

+ (UIViewController<TicketsViewInput>*)buildFavoutives {
    TicketsInteractor *interactor = [TicketsInteractor new];
    TicketsRouter *router = [TicketsRouter new];
    TicketsPresenter *presenter = [[TicketsPresenter alloc] initWithRouter:router withInteractor:interactor];
    
    TicketsTableViewController *viewController = [[TicketsTableViewController alloc] initWithPresenter:presenter];
    [viewController setupFavouriteTickets];
    presenter.viewInput = viewController;
    router.viewController = viewController;
    
    return viewController;
}

@end
