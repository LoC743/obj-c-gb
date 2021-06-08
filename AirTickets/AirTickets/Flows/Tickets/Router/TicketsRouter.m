//
//  TicketsRouter.m
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//

#import "TicketsRouter.h"

@implementation TicketsRouter

- (void)showAlertWithActions:(NSArray *)actions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
    }
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

@end
