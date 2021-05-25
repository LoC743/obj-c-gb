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

@interface MapViewController : UIViewController <MapViewInput>

@property (strong, nonatomic) NSObject<MapViewOutput> *presenter;

- (instancetype)initWithPresenter:(NSObject<MapViewOutput>*)presenter;

@end

NS_ASSUME_NONNULL_END
