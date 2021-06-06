//
//  TicketsPresenter.m
//  AirTickets
//
//  Created by Alexey on 25.05.2021.
//

#import "TicketsPresenter.h"
#import "CoreDataStorage.h"
#import "Ticket.h"

@implementation TicketsPresenter

- (instancetype)initWithRouter:(NSObject<TicketsRouterInput> *)router withInteractor:(NSObject<TicketsInteractorInput> *)interactor {
    self = [super init];
    if (self) {
        self.router = router;
        self.interactor = interactor;
    }
    return self;
}

- (void)viewDidTapCellWithActions:(NSArray *)alertActions {
    [self.router showAlertWithActions:alertActions];
}

- (nonnull NSArray *)getFavourites {
    return [CoreDataStorage.sharedInstance favourites];
}

- (nonnull NSArray *)getFavouritesMapPrice {
    return [CoreDataStorage.sharedInstance favouritesMapPrice];
}


@end
