//
//  TicketsBuilder.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "TicketsBuilder.h"

@implementation TicketsBuilder

+ (UIViewController<TicketsViewInput>*)buildWithTickets:(NSArray *)tickets {
    TicketsPresenter *presenter = [TicketsPresenter new];
    
    TicketsTableViewController *viewController = [[TicketsTableViewController alloc] initWithPresenter:presenter];
    viewController.tickets = tickets;
    presenter.viewInput = viewController;
    
    return viewController;
}

@end
