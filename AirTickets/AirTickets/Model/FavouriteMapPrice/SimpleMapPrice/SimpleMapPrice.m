//
//  SimpleMapPrice.m
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//

#import "SimpleMapPrice.h"

@implementation SimpleMapPrice

- (instancetype)initWithDestination:(NSString *)destination withPrice:(NSString *)price {
    self = [super init];
    if (self) {
        self.destination = destination;
        self.price = price;
    }
    return self;
}

@end
