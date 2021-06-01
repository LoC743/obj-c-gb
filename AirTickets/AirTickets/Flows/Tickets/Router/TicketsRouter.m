//
//  TicketsRouter.m
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//

#import "TicketsRouter.h"

@implementation TicketsRouter

- (void)showAlertWithAction:(UIAlertAction *)action {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [alertController addAction:cancelAction];
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

@end
