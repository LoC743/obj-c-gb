//
//  CoreDataStorage.h
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AirTickets-Swift.h"
#import "SimpleMapPrice.h"
#import "DataManager.h"
#import "Ticket.h"
#import "MapPrice.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataStorage : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavourite:(Ticket *)ticket;

- (NSArray *)favourites;

- (void)addToFavourite:(Ticket *)ticket;

- (void)removeFromFavourite:(Ticket *)ticket;

- (BOOL)isFavouriteMapPrice:(SimpleMapPrice *)ticket;

- (NSArray *)favouritesMapPrice;

- (void)addToFavouriteMapPrice:(SimpleMapPrice *)ticket;

- (void)removeFromFavouriteMapPrice:(SimpleMapPrice *)ticket;

@end

NS_ASSUME_NONNULL_END
