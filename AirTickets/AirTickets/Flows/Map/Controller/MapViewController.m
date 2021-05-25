//
//  MapViewController.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (instancetype)initWithPresenter:(NSObject<MapViewOutput> *)presenter {
    self = [super init];
    if (self) {
        self.presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.cyanColor;
}

@end
