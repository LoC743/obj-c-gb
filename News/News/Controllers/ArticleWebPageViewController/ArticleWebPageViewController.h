//
//  ArticleWebPageViewController.h
//  News
//
//  Created by Алексей Морозов on 22.05.2021.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleWebPageViewController : UIViewController <WKNavigationDelegate>

- (instancetype)initWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
