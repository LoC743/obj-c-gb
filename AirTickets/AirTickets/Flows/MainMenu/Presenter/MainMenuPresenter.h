//
//  MainMenuPresenter.h
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MainMenuRouter.h"
#import "MainMenuInteractor.h"
#import "MainMenuView.h"
#include "DataManager.h"


NS_ASSUME_NONNULL_BEGIN

@protocol MainMenuViewOutput <NSObject>

- (void)viewDidMoveToDeparture;

- (void)viewDidMoveToArrival;

- (void)dataLoadedSuccessfully;

- (void)viewDidMoveToTickets;

@end

@protocol MainMenuViewInput <NSObject>

@property (nonatomic) SearchRequest searchRequest;

- (MainMenuView *)mainMenuView;

@end

@interface MainMenuPresenter : NSObject <MainMenuViewOutput, MainMenuDelegate>

@property (strong, nonatomic) NSObject<MainMenuInteractorInput> *interactor;
@property (strong, nonatomic) NSObject<MainMenuRouterInput> *router;
@property (weak, nonatomic) UIViewController<MainMenuViewInput> *viewInput;

- (instancetype)initWithRouter:(NSObject<MainMenuRouterInput>*)router withInteractor:(NSObject<MainMenuInteractorInput>*)interactor;

@end

NS_ASSUME_NONNULL_END
