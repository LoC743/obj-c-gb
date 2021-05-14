//
//  MainViewController.m
//  AirTickets
//
//  Created by Alexey on 14.05.2021.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "DataManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.redColor;
    
    [[DataManager sharedInstance] loadData];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)loadDataComplete {
    self.view.backgroundColor = UIColor.greenColor;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        ViewController *vc = [ViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    });
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}


@end
