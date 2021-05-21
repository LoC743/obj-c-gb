//
//  PlaceViewController.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "PlaceViewController.h"

#define ReuseIdentifier @"CellIdentifier"

@interface PlaceViewController ()

@property (nonatomic) PlaceType placeType;

@end

@implementation PlaceViewController

- (instancetype)initWithPresenter:(NSObject<PlaceViewOutput>*)presenter andPlaceType:(PlaceType)placeType {
    self = [super init];
    if (self) {
        self.presenter = presenter;
        self.placeType = placeType;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view = [PlaceView new];
}

- (PlaceView *)placeView {
    return (PlaceView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self placeView].tableView.delegate = self;
    [self placeView].tableView.dataSource = self;
    
    [[self placeView].segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = [self placeView].segmentedControl;
    
    [self changeSource];
    
    if (self.placeType == PlaceTypeDeparture) {
        self.title = @"Откуда";
    } else {
        self.title = @"Куда";
    }
}

- (void) changeSource {
    [self.presenter changeSource];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if ([self placeView].segmentedControl.selectedSegmentIndex == 0) {
        City *city = [_currentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = city.name;
        cell.detailTextLabel.text = city.code;
    }
    else if ([self placeView].segmentedControl.selectedSegmentIndex == 1) {
        Airport *airport = [_currentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = airport.name;
        cell.detailTextLabel.text = airport.code;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currentArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataSourceType dataType = ((int) [self placeView].segmentedControl.selectedSegmentIndex) + 1;
    [self.presenter selectPlace:self.currentArray[indexPath.row] withType:self.placeType andDataType:dataType];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
