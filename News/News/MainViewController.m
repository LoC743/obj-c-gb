//
//  MainViewController.m
//  News
//
//  Created by Alexey on 21.05.2021.
//

#import "MainViewController.h"
#import "NetworkManger.h"

@interface MainViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *newsArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadNews];
}

- (void) configureView {
    CGRect frame = self.view.bounds;
    self.tableView = [[UITableView alloc] initWithFrame:frame];;
    
    [self.view addSubview:self.tableView];
}

- (void)loadNews {
    [NetworkManger.shared newsForCountry:@"ru" withCompletion:^(NSArray * _Nonnull news) {
        self.newsArray = news;
        [self.tableView reloadData];
    }];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

@end
