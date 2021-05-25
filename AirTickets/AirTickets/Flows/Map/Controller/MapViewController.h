//
//  MapViewController.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <UIKit/UIKit.h>
#import "MapPresenter.h"
#import "MapView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController <MapViewInput, MKMapViewDelegate>

@property (strong, nonatomic) NSObject<MapViewOutput> *presenter;

- (instancetype)initWithPresenter:(NSObject<MapViewOutput>*)presenter;

@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) City *origin;
@property (nonatomic, strong) NSArray *prices;

@end

NS_ASSUME_NONNULL_END
