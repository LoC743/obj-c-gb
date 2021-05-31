//
//  MainMenuRouter.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuRouter.h"
#import "PlaceBuilder.h"
#import "TicketsBuilder.h"

@implementation MainMenuRouter

- (void)moveToDepartureWithMenuDelegate:(NSObject<MainMenuDelegate>*)delegate {
    PlaceViewController *placeViewController = (PlaceViewController *)[PlaceBuilder buildWithMenuDelegate:delegate andPlaceType:PlaceTypeDeparture];
    
    [self.viewController.navigationController pushViewController:placeViewController animated:YES];
}

- (void)moveToArrivalWithMenuDelegate:(NSObject<MainMenuDelegate>*)delegate {
    PlaceViewController *placeViewController = (PlaceViewController *)[PlaceBuilder buildWithMenuDelegate:delegate andPlaceType:PlaceTypeArrival];
    
    [self.viewController.navigationController pushViewController:placeViewController animated:YES];
}

- (void)moveToTicketsVCWithTickets:(NSArray *)tickets {
    TicketsTableViewController *vc = (TicketsTableViewController *) [TicketsBuilder buildWithTickets:tickets];
    [self.viewController.navigationController showViewController:vc sender:self];
}

- (void)showAlertWithTitle:(NSString *)title withMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle: UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

@end
