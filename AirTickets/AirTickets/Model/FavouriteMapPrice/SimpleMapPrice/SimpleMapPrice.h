//
//  SimpleMapPrice.h
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleMapPrice : NSObject

@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *destination;

- (instancetype)initWithDestination:(NSString *)destination withPrice:(NSString *)price;

@end

NS_ASSUME_NONNULL_END
