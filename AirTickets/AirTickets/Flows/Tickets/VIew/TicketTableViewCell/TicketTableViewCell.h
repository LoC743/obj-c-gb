//
//  TicketTableViewCell.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;

@property (nonatomic, strong) Ticket *ticket;

@end

NS_ASSUME_NONNULL_END
