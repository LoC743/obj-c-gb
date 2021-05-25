//
//  MapPresenter.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "MapPresenter.h"

@implementation MapPresenter


- (instancetype)initWithRouter:(NSObject<MapRouterInput> *)router withInteractor:(NSObject<MapInteractorInput> *)interactor {
    self = [super init];
    if (self) {
        self.router = router;
        self.interactor = interactor;
    }
    return self;
}

@end
