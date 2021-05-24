//
//  NewsTableViewCell.m
//  News
//
//  Created by Алексей Морозов on 22.05.2021.
//

#import "NewsTableViewCell.h"

#define sideInset 10.0

@interface NewsTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *articleImageView;

@property (nonatomic, strong) NSLayoutConstraint *imageViewHeight;
@property (nonatomic, strong) NSLayoutConstraint *imageViewHeightZero;

@end


@implementation NewsTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureView];
    }
    return self;
}

+ (NSString *)reusableCellIdentifier {
    return @"newsReusableIdentifier";
}

- (void)configureView {
    [self configureTitle];
    [self configureDate];
    [self configureDescription];
    [self configureImageView];
}

- (void)configureTitle {
    self.titleLabel = [UILabel new];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview: self.titleLabel];
    
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:sideInset].active = YES;
    [self.titleLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:sideInset].active = YES;
    [self.titleLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-sideInset].active = YES;
    
    self.titleLabel.text = @"Title";
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:17.0 weight:bold];
}

- (void)configureDate {
    self.dateLabel = [UILabel new];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview: self.dateLabel];
    
    [self.dateLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:sideInset].active = YES;
    [self.dateLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:sideInset].active = YES;
    [self.dateLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-sideInset].active = YES;
    
    self.dateLabel.text = @"Date";
    self.dateLabel.numberOfLines = 1;
    self.dateLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightLight];
}

- (void)configureDescription {
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview: self.descriptionLabel];
    
    [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.dateLabel.bottomAnchor constant:sideInset].active = YES;
    [self.descriptionLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:sideInset].active = YES;
    [self.descriptionLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-sideInset].active = YES;
    
    self.descriptionLabel.text = @"Description";
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.font = [UIFont systemFontOfSize:15.0 weight:normal];
    [self.descriptionLabel sizeToFit];
}

- (void)configureImageView {
    self.articleImageView = [UIImageView new];
    self.articleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview: self.articleImageView];
    
    [self.articleImageView.topAnchor constraintEqualToAnchor:self.descriptionLabel.bottomAnchor constant:sideInset].active = YES;
    [self.articleImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:sideInset].active = YES;
    [self.articleImageView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-sideInset].active = YES;
    [self.articleImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-sideInset].active = YES;
    
    self.imageViewHeight = [self.articleImageView.heightAnchor constraintEqualToConstant:200.0];
    self.imageViewHeightZero = [self.articleImageView.heightAnchor constraintEqualToConstant:0.0];
    
    self.articleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.articleImageView.layer.cornerRadius = 10.0;
    self.articleImageView.clipsToBounds = YES;
}

- (void)configureWithArticle:(News *)article {
    self.titleLabel.text = article.title;
    self.dateLabel.text = [[NewsTableViewCell dateFormatter] stringFromDate:article.date];
    self.descriptionLabel.text = article.text;

    NSURL *url = [NSURL URLWithString: article.urlImage];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    BOOL isValid = [NSURLConnection canHandleRequest:req];

    if ([article.urlImage isEqual: @""] || !isValid) {
        self.imageViewHeight.active = NO;
        self.imageViewHeightZero.active = YES;
        return;
    } else {
        self.imageViewHeightZero.active = NO;
        self.imageViewHeight.active = YES;
    }
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL: url];
        if (data == nil) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.articleImageView.image = [UIImage imageWithData: data];
        });
    });
}

+ (NSDateFormatter *)dateFormatter {
  static NSDateFormatter *dateFormatter = nil;
  if (dateFormatter == nil) {
      dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat:@"dd MMM HH:mm"];
  }
  return dateFormatter;
}

@end
