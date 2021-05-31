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
@property (nonatomic, strong) NSArray *searchArray;

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
    
    self.placeView.tableView.delegate = self;
    self.placeView.tableView.dataSource = self;
    
    self.placeView.searchBar.delegate = self;
    
    [self.placeView.segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = [self placeView].segmentedControl;
    
    [self changeSource];
    
    if (self.placeType == PlaceTypeDeparture) {
        self.title = @"Откуда";
    } else {
        self.title = @"Куда";
    }
}

- (void)setCurrentArray:(NSArray *)currentArray {
    _currentArray = currentArray;
    self.searchArray = currentArray;
}

- (void)setSearchArray:(NSArray *)searchArray {
    _searchArray = searchArray;
    [self.placeView.tableView reloadData];
}

- (void) changeSource {
    [self.presenter changeSource];
}

#pragma mark - UITableView

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (self.placeView.segmentedControl.selectedSegmentIndex == 0) {
        City *city = [self.searchArray objectAtIndex:indexPath.row];
        cell.textLabel.text = city.name;
        cell.detailTextLabel.text = city.code;
    }
    else if (self.placeView.segmentedControl.selectedSegmentIndex == 1) {
        Airport *airport = [self.searchArray objectAtIndex:indexPath.row];
        cell.textLabel.text = airport.name;
        cell.detailTextLabel.text = airport.code;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataSourceType dataType = ((int) [self placeView].segmentedControl.selectedSegmentIndex) + 1;
    [self.presenter selectPlace:self.searchArray[indexPath.row] withType:self.placeType andDataType:dataType];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SearchBar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchBar.showsCancelButton = YES;
    
    if ([searchText length] > 0) {
        NSString *lowercasedSearchText = searchText.lowercaseString;
        NSMutableArray *tempArray = [NSMutableArray new];
        
        if (self.placeView.segmentedControl.selectedSegmentIndex == 0) {
            for (City *city in self.currentArray) {
                if ([city.name.lowercaseString containsString: lowercasedSearchText]) {
                    [tempArray addObject:city];
                }
            }
        } else if (self.placeView.segmentedControl.selectedSegmentIndex == 1) {
            for (Airport *airport in self.currentArray) {
                if ([airport.name.lowercaseString containsString: lowercasedSearchText]) {
                    [tempArray addObject:airport];
                }
            }
        }
        self.searchArray = tempArray;
    }
    else {
        self.searchArray = self.currentArray;
    }
    
    [self.placeView.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    self.searchArray = self.currentArray;
    searchBar.showsCancelButton = NO;
    [self.view endEditing:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
