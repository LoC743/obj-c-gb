//
//  PlaceViewController.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <UIKit/UIKit.h>
#import "PlacePresenter.h"
#import "PlaceView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PlaceViewControllerDelegate <NSObject>

-(void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;

@end


@interface PlaceViewController : UIViewController<PlaceViewInput, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) NSObject<PlaceViewOutput> *presenter;

@property (nonatomic, strong) NSArray *currentArray;

- (PlaceView *)placeView;

- (instancetype)initWithPresenter:(NSObject<PlaceViewOutput>*)presenter andPlaceType:(PlaceType)placeType;

@end

NS_ASSUME_NONNULL_END
