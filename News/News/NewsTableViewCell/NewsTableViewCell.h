//
//  NewsTableViewCell.h
//  News
//
//  Created by Алексей Морозов on 22.05.2021.
//

#import <UIKit/UIKit.h>
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell

+ (NSString *)reusableCellIdentifier;

- (void)configureWithArticle:(News *)article;

@end

NS_ASSUME_NONNULL_END
