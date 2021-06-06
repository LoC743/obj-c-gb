//
//  MapPresenter.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#import "CoreDataStorage.h"
#import "LocationService.h"
#import "MapInteractor.h"
#import "MapRouter.h"
#import "MapView.h"
#import "City.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MapViewInput <NSObject>

- (MapView *)mapView;

@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) City *origin;
@property (nonatomic, strong) NSArray *prices;

@end

@protocol MapViewOutput <NSObject>

- (void)dataLoadedSuccessfully;

- (void)updateCurrentLocation:(NSNotification *)notification;

- (void)setPrices:(NSArray *)prices;

@end

@interface MapPresenter : NSObject <MapViewOutput>

@property (strong, nonatomic) NSObject<MapInteractorInput> *interactor;
@property (strong, nonatomic) NSObject<MapRouterInput> *router;
@property (weak, nonatomic) UIViewController<MapViewInput> *viewInput;

- (instancetype)initWithRouter:(NSObject<MapRouterInput>*)router withInteractor:(NSObject<MapInteractorInput>*)interactor;

@end

NS_ASSUME_NONNULL_END
