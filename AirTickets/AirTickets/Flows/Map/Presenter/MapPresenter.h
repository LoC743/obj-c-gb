//
//  MapPresenter.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#import "MapInteractor.h"
#import "MapRouter.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MapViewInput <NSObject>

@end

@protocol MapViewOutput <NSObject>

@end

@interface MapPresenter : NSObject <MapViewOutput>

@property (strong, nonatomic) NSObject<MapInteractorInput> *interactor;
@property (strong, nonatomic) NSObject<MapRouterInput> *router;
@property (weak, nonatomic) UIViewController<MapViewInput> *viewInput;

- (instancetype)initWithRouter:(NSObject<MapRouterInput>*)router withInteractor:(NSObject<MapInteractorInput>*)interactor;

@end

NS_ASSUME_NONNULL_END
