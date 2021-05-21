//
//  NetworkManger.h
//  News
//
//  Created by Alexey on 21.05.2021.
//

#import <Foundation/Foundation.h>
#include "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManger : NSObject

+(instancetype) shared;

-(void)newsForCountry:(NSString*)country withCompletion:(void (^)(NSArray* news))completion;


@end

NS_ASSUME_NONNULL_END
