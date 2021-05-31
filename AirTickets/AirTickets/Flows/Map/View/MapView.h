//
//  MapView.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapView : UIView

@property (nonatomic, strong) MKMapView *mapKitView;

@end

NS_ASSUME_NONNULL_END
