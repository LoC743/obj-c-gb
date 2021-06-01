//
//  TicketsViewController.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "TicketsTableViewController.h"
#import "TicketTableViewCell.h"

@interface TicketsTableViewController ()

@property BOOL isFavorites;

@end

@implementation TicketsTableViewController

- (instancetype)initWithPresenter:(NSObject<TicketsViewOutput> *)presenter {
    self = [super init];
    if (self) {
        self.presenter = presenter;
        self.title = @"Билеты";
    }
    return self;
}

- (void)setupFavouriteTickets {
    self.title = @"Избранное";
    
    self.isFavorites = YES;
    self.tickets = [NSArray new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketTableViewCell.reuseIdentifier];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    if (self.isFavorites) {
        self.tickets = [self.presenter getFavourites];
        [self.tableView reloadData];
    }
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
    
    if (self.isFavorites) { return; }
    [self.presenter viewDidTapCellWithTicket: self.tickets[indexPath.row]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketTableViewCell.reuseIdentifier forIndexPath:indexPath];
    if (self.isFavorites) {
        cell.favouriteTicket = self.tickets[indexPath.row];
    } else {
        cell.ticket = self.tickets[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

@end
