//
//  TicketsPresenter.h
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import <Foundation/Foundation.h>
#import "TicketsRouter.h"
#import "TicketsInteractor.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TicketsViewInput <NSObject>

@end

@protocol TicketsViewOutput <NSObject>

- (void)viewDidTapCellWithTicket:(Ticket *)ticket;

- (NSArray *)getFavourites;

@end

@interface TicketsPresenter : NSObject <TicketsViewOutput>

@property (strong, nonatomic) NSObject<TicketsInteractorInput> *interactor;
@property (strong, nonatomic) NSObject<TicketsRouterInput> *router;
@property (weak, nonatomic) UIViewController<TicketsViewInput> *viewInput;

- (instancetype)initWithRouter:(NSObject<TicketsRouterInput>*)router withInteractor:(NSObject<TicketsInteractorInput>*)interactor;

@end

NS_ASSUME_NONNULL_END
