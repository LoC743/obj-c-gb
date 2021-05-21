//
//  News.m
//  News
//
//  Created by Alexey on 21.05.2021.
//

#import "News.h"

@implementation News

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = [dictionary valueForKey:@"title"];
        self.text = [dictionary valueForKey:@"description"];
        self.url = [dictionary valueForKey:@"url"];
        self.urlImage = [dictionary valueForKey:@"urlToImage"];
        self.date = dateFromString([dictionary valueForKey:@"publishedAt"]);
    }
    return self;
}

NSDate *dateFromString(NSString *dateString) {
    if (!dateString) { return  nil; }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *correctSrtingDate = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    correctSrtingDate = [correctSrtingDate stringByReplacingOccurrencesOfString:@"Z" withString:@" "];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter dateFromString: correctSrtingDate];
}

@end
