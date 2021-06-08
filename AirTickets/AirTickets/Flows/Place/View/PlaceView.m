//
//  PlaceView.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "PlaceView.h"
#import "Colors.h"

@implementation PlaceView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    self.backgroundColor = UIColor.whiteColor;
    
    [self configureTableView];
    [self configureSearchBar];
    [self configureSegmanetedControl];
}

- (void)configureTableView {
    CGRect frame = UIScreen.mainScreen.bounds;
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self addSubview: self.tableView];
}

- (void)configureSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 70, 310, 44)];
    self.tableView.tableHeaderView = self.searchBar;
}

- (void)configureSegmanetedControl {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"cities", ""), NSLocalizedString(@"airports", "")]];
    self.segmentedControl.selectedSegmentIndex = 0;
}


@end
