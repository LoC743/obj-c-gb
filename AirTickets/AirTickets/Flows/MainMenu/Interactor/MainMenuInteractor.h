//
//  MainMenuInteractor.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MainMenuInteractorInput <NSObject>

- (void) loadTicketsWithRequest:(SearchRequest)request WithCompletion:(void (^)(NSArray *tickets))completion;

- (void)dataLoadedSuccessfullyWithCompletion:(void (^)(City *city))completion;

@end

@interface MainMenuInteractor : NSObject <MainMenuInteractorInput>

@end

NS_ASSUME_NONNULL_END
