//
//  MapView.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "MapView.h"

@implementation MapView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI {
    CGRect frame = CGRectMake(
                              0,
                              0,
                              UIScreen.mainScreen.bounds.size.width,
                              UIScreen.mainScreen.bounds.size.height
    );
    self.mapKitView = [[MKMapView alloc] initWithFrame: frame];
    self.mapKitView.showsUserLocation = YES;
    
    [self addSubview: self.mapKitView];
}

@end
