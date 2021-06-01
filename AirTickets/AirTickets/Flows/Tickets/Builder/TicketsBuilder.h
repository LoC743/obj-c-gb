//
//  TicketsBuilder.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#import "TicketsTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketsBuilder : NSObject

+ (UIViewController<TicketsViewInput>*)buildWithTickets:(NSArray *)tickets;

+ (UIViewController<TicketsViewInput>*)buildFavoutives;

@end

NS_ASSUME_NONNULL_END
