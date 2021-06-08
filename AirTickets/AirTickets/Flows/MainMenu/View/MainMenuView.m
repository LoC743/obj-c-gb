//
//  MainMenuView.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuView.h"
#import "Colors.h"

#define buttonCornerRadius 15.0
#define buttonWidth [UIScreen mainScreen].bounds.size.width - 60.0
#define buttonHeight 60.0
#define buttonsOffset 20.0

@implementation MainMenuView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    self.backgroundColor = UIColor.whiteColor;
    
    self.arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.arrivalButton, self.departureButton, self.searchButton, nil];
    for (UIButton *button in buttons) {
        button.tintColor = UIColor.whiteColor;
        button.backgroundColor = UIColorFromRGB(darkColor);
        button.layer.cornerRadius = buttonCornerRadius;
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    }
    
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    CGFloat topPadding = window.safeAreaInsets.top;
    CGFloat topbarHeight = window.windowScene.statusBarManager.statusBarFrame.size.height;
    
    [self.departureButton setTitle:NSLocalizedString(@"departureTitle", "") forState: UIControlStateNormal];
    self.departureButton.frame = CGRectMake(30.0, topbarHeight + topPadding + 15.0 + buttonHeight, buttonWidth, buttonHeight);
    
    [self.arrivalButton setTitle:NSLocalizedString(@"arrivalTitle", "") forState: UIControlStateNormal];
    self.arrivalButton.frame = CGRectMake(30.0, CGRectGetMaxY(self.departureButton.frame) + buttonsOffset, buttonWidth, buttonHeight);
    
    [self.searchButton setTitle:NSLocalizedString(@"searchButtonTitle", "") forState: UIControlStateNormal];
    self.searchButton.backgroundColor = UIColor.darkGrayColor;
    self.searchButton.frame = CGRectMake(30.0, CGRectGetMaxY(self.arrivalButton.frame) + 2*buttonsOffset, buttonWidth, buttonHeight);
    
    [self addSubview:self.departureButton];
    [self addSubview:self.arrivalButton];
    [self addSubview:self.searchButton];
    
}

@end
