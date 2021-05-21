//
//  MainMenuRouter.m
//  AirTickets
//
//  Created by Alexey on 18.05.2021.
//

#import "MainMenuRouter.h"
#import "PlaceBuilder.h"

@implementation MainMenuRouter

- (void)moveToDepartureWithMenuDelegate:(NSObject<MainMenuDelegate>*)delegate {
    PlaceViewController *placeViewController = (PlaceViewController *)[PlaceBuilder buildWithMenuDelegate:delegate andPlaceType:PlaceTypeDeparture];
    
    [self.viewController.navigationController pushViewController:placeViewController animated:YES];
}

- (void)moveToArrivalWithMenuDelegate:(NSObject<MainMenuDelegate>*)delegate {
    PlaceViewController *placeViewController = (PlaceViewController *)[PlaceBuilder buildWithMenuDelegate:delegate andPlaceType:PlaceTypeArrival];
    
    [self.viewController.navigationController pushViewController:placeViewController animated:YES];
}

@end
