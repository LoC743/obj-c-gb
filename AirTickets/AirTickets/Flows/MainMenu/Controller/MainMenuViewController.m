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
    
    [[self mainMenuView].departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [[self mainMenuView].arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)placeButtonDidTap:(UIButton *)sender {
    if ([sender isEqual:[self mainMenuView].departureButton]) {
        [self.presenter viewDidMoveToDeparture];
    } else {
        [self.presenter viewDidMoveToArrival];
    }
}


@end
