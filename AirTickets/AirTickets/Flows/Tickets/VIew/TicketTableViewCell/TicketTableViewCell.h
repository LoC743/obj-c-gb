//
//  TicketTableViewCell.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <UIKit/UIKit.h>
#import "AirTickets-Swift.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;

@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, strong) FavouriteTicket *favouriteTicket;
@property (nonatomic, strong) FavouriteMapPrice *favouriteMapPrice;

@end

NS_ASSUME_NONNULL_END
