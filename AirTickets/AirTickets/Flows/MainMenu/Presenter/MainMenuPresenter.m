//
//  MainMenuPresenter.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuPresenter.h"

@implementation MainMenuPresenter

- (instancetype)initWithRouter:(NSObject<MainMenuRouterInput>*)router  {
    self = [super init];
    if (self) {
        self.router = router;
    }
    return self;
}

- (void)viewDidMoveToFromWhere {
    [self.router moveToFromWhere];
}

- (void)viewDidMoveToWhere {
    [self.router moveToWhere];
}

@end
