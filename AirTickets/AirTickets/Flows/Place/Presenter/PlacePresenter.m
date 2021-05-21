//
//  PlacePresenter.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "PlacePresenter.h"
#import "DataManager.h"

@implementation PlacePresenter

@synthesize delegate;

- (instancetype)initWithRouter:(NSObject<PlaceRouterInput>*)router withInteractor:(NSObject<PlaceInteractorInput>*)interactor {
    self = [super init];
    if (self) {
        self.router = router;
        self.interactor = interactor;
    }
    return self;
}

- (void) changeSource {
    switch (self.viewInput.placeView.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.viewInput.currentArray = [self.interactor loadCities];
            break;
        case 1:
            self.viewInput.currentArray = [self.interactor loadAirports];
            break;
        default:
            break;
    }
    [self.viewInput.placeView.tableView reloadData];
}

- (void)selectPlace:(nonnull id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType {
    [delegate selectPlace:place withType:placeType andDataType:dataType];
}

@end
