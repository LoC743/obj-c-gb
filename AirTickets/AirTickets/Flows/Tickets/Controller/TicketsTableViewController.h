//
//  TicketsViewController.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <UIKit/UIKit.h>
#import "TicketsPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketsTableViewController : UITableViewController <TicketsViewInput>

@property (strong, nonatomic) NSArray *tickets;

@property (strong, nonatomic) NSObject<TicketsViewOutput> *presenter;

- (instancetype)initWithPresenter:(NSObject<TicketsViewOutput>*)presenter;

@end

NS_ASSUME_NONNULL_END
