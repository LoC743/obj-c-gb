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
    [self configureSegmanetedControl];
}

- (void) configureTableView {
    CGRect frame = UIScreen.mainScreen.bounds;
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self addSubview: self.tableView];
}

- (void)configureSegmanetedControl {
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Города", @"Аэропорты"]];
    self.segmentedControl.selectedSegmentIndex = 0;
}


@end
