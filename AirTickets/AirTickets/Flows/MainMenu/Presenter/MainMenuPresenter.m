//
//  MainMenuPresenter.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuPresenter.h"

@implementation MainMenuPresenter

- (instancetype)initWithRouter:(NSObject<MainMenuRouterInput>*)router withInteractor:(NSObject<MainMenuInteractorInput> *)interactor {
    self = [super init];
    if (self) {
        self.router = router;
        self.interactor = interactor;
    }
    return self;
}

- (void)viewDidMoveToDeparture {
    [self.router moveToDepartureWithMenuDelegate:self];
}

- (void)viewDidMoveToArrival{
    [self.router moveToArrivalWithMenuDelegate:self];
}

- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType {
    [self setPlace:place withDataType:dataType andPlaceType:placeType forButton: (placeType == PlaceTypeDeparture) ? self.viewInput.mainMenuView.departureButton : self.viewInput.mainMenuView.arrivalButton ];
}

- (void)setPlace:(id)place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:(UIButton *)button {
    
    NSString *title;
    NSString *iata;
    
    if (dataType == DataSourceTypeCity) {
        City *city = (City *)place;
        title = city.name;
        iata = city.code;
    }
    else if (dataType == DataSourceTypeAirport) {
        Airport *airport = (Airport *)place;
        title = airport.name;
        iata = airport.cityCode;
    }
    
    SearchRequest __searchRequest = self.viewInput.searchRequest;
    if (placeType == PlaceTypeDeparture) {
        __searchRequest.origin = iata;
    } else {
        __searchRequest.destionation = iata;
    }
    self.viewInput.searchRequest = __searchRequest;
    
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)viewDidMoveToTickets {
    [self.interactor loadTicketsWithRequest:self.viewInput.searchRequest WithCompletion:^(NSArray * _Nonnull tickets) {
        if (tickets.count > 0) {
            [self.router moveToTicketsVCWithTickets: tickets];
        } else {
            [self.router showAlertWithTitle:@"Увы!" withMessage:@"По данному направлению билетов не найдено"];
        }
    }];
}

- (void)dataLoadedSuccessfully {
    [self.interactor dataLoadedSuccessfullyWithCompletion:^(City * _Nonnull city) {
        [self setPlace:city withDataType:DataSourceTypeCity andPlaceType:PlaceTypeDeparture forButton:self.viewInput.mainMenuView.departureButton];
    }];
}

@end
