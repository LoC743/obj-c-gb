//
//  MainViewController.m
//  News
//
//  Created by Alexey on 21.05.2021.
//

#import "MainViewController.h"
#import "NetworkManger.h"
#import "NewsTableViewCell.h"
#import "ArticleWebPageViewController.h"

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
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsTableViewCell.reusableCellIdentifier];
    
    if (!cell) {
        cell = [NewsTableViewCell new];
    }
    
    [cell configureWithArticle:self.newsArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    News *article = self.newsArray[indexPath.row];
    NSURL *articleURL = [NSURL URLWithString:article.url];
    
    ArticleWebPageViewController *vc = [[ArticleWebPageViewController alloc] initWithURL:articleURL];

    [self.navigationController pushViewController:vc animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
