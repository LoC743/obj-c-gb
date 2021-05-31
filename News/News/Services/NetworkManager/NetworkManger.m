//
//  NetworkManger.m
//  News
//
//  Created by Alexey on 21.05.2021.
//

#import "NetworkManger.h"

#define API_TOKEN @"64f74de38a794152af35e07d6c90cc4f"
#define API_URL_ADDRESS @"https://newsapi.org/v2/top-headlines"

@implementation NetworkManger

+ (instancetype)shared {
    static NetworkManger *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NetworkManger new];
    });
    return instance;
}

- (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
        }
    }] resume] ;
}

- (void)newsForCountry:(NSString *)country withCompletion:(void (^)(NSArray * _Nonnull))completion {
    [self load:[NSString stringWithFormat:@"%@?country=%@&apiKey=%@", API_URL_ADDRESS, country, API_TOKEN] withCompletion:^(id  _Nullable result) {
        NSDictionary *json = result;
        NSArray *articles = [json valueForKey:@"articles"];
        NSMutableArray *newsArray = [NSMutableArray new];
        if (articles) {
            for (NSDictionary *article in articles) {
                News *news = [[News alloc] initWithDictionary:article];
                [newsArray addObject:news];
            }
            if (newsArray) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(newsArray);
                });
            }
        }
    }];
}

@end
