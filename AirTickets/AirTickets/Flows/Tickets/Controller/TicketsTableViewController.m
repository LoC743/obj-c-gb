//
//  TicketsViewController.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "TicketsTableViewController.h"
#import "TicketTableViewCell.h"

@interface TicketsTableViewController ()

@end

@implementation TicketsTableViewController

- (instancetype)initWithPresenter:(NSObject<TicketsViewOutput> *)presenter {
    self = [super init];
    if (self) {
        self.presenter = presenter;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Билеты";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketTableViewCell.reuseIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tickets.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketTableViewCell.reuseIdentifier forIndexPath:indexPath];
    cell.ticket = self.tickets[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

@end
