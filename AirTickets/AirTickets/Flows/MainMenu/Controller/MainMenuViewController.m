//
//  MainMenuViewController.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuViewController.h"
#import "MainMenuView.h"
#import "Colors.h"
#import "DataManager.h"
#import "FirstStartViewController.h"
#import "ProgressView.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (instancetype)initWithPresenter:(NSObject<MainMenuViewOutput>*)presenter {
    self = [super init];
    if (self) {
        self.presenter = presenter;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.view = [MainMenuView new];
}

- (MainMenuView *)mainMenuView {
    return (MainMenuView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DataManager.sharedInstance loadData];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationController.navigationBar.layer.cornerRadius = 15.0;
    self.title = @"Поиск";
    
    [self.mainMenuView.departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainMenuView.arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainMenuView.searchButton addTarget:self action:@selector(searchButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self presentFirstViewControllerIfNeeded];
}

- (void)presentFirstViewControllerIfNeeded {
    BOOL isFirstStart = [[NSUserDefaults standardUserDefaults] boolForKey:@"first_start"];
    if (!isFirstStart) {
        FirstStartViewController *firstStartViewController = [[FirstStartViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        firstStartViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:firstStartViewController animated:YES completion:nil];
    }
}

- (void)placeButtonDidTap:(UIButton *)sender {
    if ([sender isEqual:[self mainMenuView].departureButton]) {
        [self.presenter viewDidMoveToDeparture];
    } else {
        [self.presenter viewDidMoveToArrival];
    }
}

- (void)searchButtonDidTap:(UIButton *)sender {
    [self.presenter viewDidMoveToTickets];
}

- (void)dataLoadedSuccessfully {
    [self.presenter dataLoadedSuccessfully];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}


@end
