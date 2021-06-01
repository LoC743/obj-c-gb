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

- (void)viewDidTapCellWithTicket:(Ticket *)ticket {
    UIAlertAction *favouriteAction;
    
    if ([CoreDataStorage.sharedInstance isFavourite:ticket]) {
        favouriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [CoreDataStorage.sharedInstance removeFromFavourite:ticket];
        }];
    } else {
        favouriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataStorage sharedInstance] addToFavourite:ticket];
        }];
    }
    
    [self.router showAlertWithAction:favouriteAction];
}

- (nonnull NSArray *)getFavourites {
    return [CoreDataStorage.sharedInstance favourites];
}


@end
