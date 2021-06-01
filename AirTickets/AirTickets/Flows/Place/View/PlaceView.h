//
//  PlaceView.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaceView : UIView

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

NS_ASSUME_NONNULL_END
