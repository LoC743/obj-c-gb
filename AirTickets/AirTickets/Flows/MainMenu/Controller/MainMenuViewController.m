//
//  MainMenuViewController.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuViewController.h"
#import "MainMenuView.h"
#import "Colors.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.backgroundColor = UIColorFromRGB(orangeSodaColor);
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(orangeCrayolaColor);
    self.navigationController.navigationBar.layer.cornerRadius = 15.0;
    self.title = @"Поиск";
}

@end
