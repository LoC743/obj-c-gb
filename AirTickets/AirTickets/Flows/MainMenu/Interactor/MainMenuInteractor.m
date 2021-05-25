//
//  MainMenuInteractor.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "MainMenuInteractor.h"

@implementation MainMenuInteractor

- (void) loadTicketsWithRequest:(SearchRequest)request WithCompletion:(void (^)(NSArray *tickets))completion  {
    [APIManager.sharedInstance ticketsWithRequest:request withCompletion:completion];
}

- (void)dataLoadedSuccessfullyWithCompletion:(void (^)(City *city))completion {
    [APIManager.sharedInstance cityForCurrentIP: completion];
}

@end
