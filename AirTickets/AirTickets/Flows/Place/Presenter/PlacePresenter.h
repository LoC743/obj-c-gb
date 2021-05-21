//
//  PlacePresenter.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>
#import "PlaceInteractor.h"
#import "PlaceRouter.h"
#import "PlaceView.h"
#import "MainMenuPresenter.h"
#import "DataManager.h"


NS_ASSUME_NONNULL_BEGIN

@protocol PlaceViewInput <NSObject>

@property (nonatomic, strong) NSArray *currentArray;

- (PlaceView *)placeView;

@end

@protocol PlaceViewOutput <NSObject>

@property (weak, nonatomic) NSObject<MainMenuDelegate> *delegate;

- (void) changeSource;

- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;

@end

@interface PlacePresenter : NSObject <PlaceViewOutput>

@property (strong, nonatomic) NSObject<PlaceInteractorInput> *interactor;
@property (strong, nonatomic) NSObject<PlaceRouterInput> *router;
@property (weak, nonatomic) UIViewController<PlaceViewInput> *viewInput;

- (instancetype)initWithRouter:(NSObject<PlaceRouterInput>*)router withInteractor:(NSObject<PlaceInteractorInput>*)interactor;

@end

NS_ASSUME_NONNULL_END
