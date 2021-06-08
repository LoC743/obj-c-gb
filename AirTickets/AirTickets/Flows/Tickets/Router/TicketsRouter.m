//
//  TicketsRouter.m
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//

#import "TicketsRouter.h"

@implementation TicketsRouter

- (void)showAlertWithActions:(NSArray *)actions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"ticketAction", "") message:NSLocalizedString(@"ticketActionMessage", "") preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"close", "") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
    }
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

@end
