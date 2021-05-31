//
//  ArticleWebPageViewController.m
//  News
//
//  Created by Алексей Морозов on 22.05.2021.
//

#import "ArticleWebPageViewController.h"

@interface ArticleWebPageViewController ()

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ArticleWebPageViewController

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
    [self configureActivityIndicator];
}

- (void)configureActivityIndicator {
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    [self.activityIndicatorView startAnimating];
    
    self.navigationItem.titleView = self.activityIndicatorView;
}

- (void)configureView {
    UIWindow *window = UIApplication.sharedApplication.windows.firstObject;
    CGFloat topPadding = window.safeAreaInsets.top;
    CGRect frame = CGRectMake(
                              0.0,
                              self.navigationController.navigationBar.frame.size.height +
                              topPadding,
                              UIScreen.mainScreen.bounds.size.width,
                              UIScreen.mainScreen.bounds.size.height
    );
    
    self.webView = [[WKWebView alloc] initWithFrame:frame];
    self.webView.navigationDelegate = self;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:urlRequest];
    
    [self.view addSubview:self.webView];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.activityIndicatorView.hidden = YES;
}

@end
