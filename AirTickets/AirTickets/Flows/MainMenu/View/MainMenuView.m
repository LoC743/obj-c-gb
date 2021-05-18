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

@implementation MainMenuView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    self.backgroundColor = UIColorFromRGB(orangeCrayolaColor);
    
    self.arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:self.arrivalButton, self.departureButton, nil];
    for (UIButton *button in buttons) {
        button.tintColor = UIColor.whiteColor;
        button.backgroundColor = UIColorFromRGB(orangeSodaColor);
        button.layer.cornerRadius = buttonCornerRadius;
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    CGFloat topPadding = window.safeAreaInsets.top;
    CGFloat topbarHeight = window.windowScene.statusBarManager.statusBarFrame.size.height;
    
    [self.departureButton setTitle:@"Откуда" forState: UIControlStateNormal];
    self.departureButton.frame = CGRectMake(30.0, topbarHeight + topPadding + 15.0 + buttonHeight, buttonWidth, buttonHeight);
    
    [self.arrivalButton setTitle:@"Куда" forState: UIControlStateNormal];
    self.arrivalButton.frame = CGRectMake(30.0, CGRectGetMaxY(self.departureButton.frame) + 20.0, buttonWidth, buttonHeight);
    
    
    [self addSubview:self.departureButton];
    [self addSubview:self.arrivalButton];
    
}

@end
