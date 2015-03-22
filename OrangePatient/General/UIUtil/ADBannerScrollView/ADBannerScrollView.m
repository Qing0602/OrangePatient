//
//  ADBannerScrollView.m
//  OrangePatient
//
//  Created by ZhangQing on 3/17/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "ADBannerScrollView.h"
@interface ADBannerScrollView()<UIScrollViewDelegate,CustomPageControlDelegate>
{
    NSTimer *timer;
    NSInteger page;
}

@end

@implementation ADBannerScrollView


- (instancetype)initWithFrame:(CGRect)frame
               placeholdImage:(UIImage *)image
                       models:(NSArray *)models
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewWidth = frame.size.width;
        CGFloat viewHeight = frame.size.height;
        
        _adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, _viewWidth, viewHeight)];
        _adScrollView.delegate = self;
        [_adScrollView setContentSize:CGSizeMake(_viewWidth*models.count, viewHeight)];
        _adScrollView.pagingEnabled = YES;
        _adScrollView.bounces = NO;
        _adScrollView.showsHorizontalScrollIndicator = NO;
        _adScrollView.showsVerticalScrollIndicator = NO;
        
        
        for (int i = 0; i < models.count; i++) {
            ADBannerModel *model = models[i];
            ADBannerImageView *adImageview = [[ADBannerImageView alloc] initWithPlaceholderImage:image];
            adImageview.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.f green:arc4random() % 256 / 256.f blue:arc4random() % 256 / 256.f alpha:1.f];
            [adImageview setFrame:CGRectMake(_viewWidth*i, 0.f, _viewWidth, viewHeight)];
            adImageview.model = model;
            [self.adScrollView addSubview:adImageview];
        }
        
        [_adScrollView setContentSize:CGSizeMake(_viewWidth*models.count, viewHeight)];
        [self addSubview:_adScrollView];
        
        self.pageControl = [[CustomPageControl alloc] initWithFrame:CGRectMake(0.f, viewHeight-20.f, _viewWidth, 20.f)];
        self.pageControl.controlDelegate = self;
        [self.pageControl setNumberOfPages:models.count];
        [self addSubview:self.pageControl];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:Banner_AutoScroll_Timeiterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        
    }
    
    return self;
}

- (void)autoScroll
{
    if (page == 4) {
        page = 0;
    }else page++;
    [self adScrolledByPage];
}

- (void)adScrolledByPage
{
    [self.pageControl setCurrentPage:page];
    [self.adScrollView setContentOffset:CGPointMake(_viewWidth*page, 0.f)];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    page = scrollView.contentOffset.x/_viewWidth;
    [self adScrolledByPage];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:Banner_AutoScroll_Timeiterval]];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer setFireDate:[NSDate dateWithTimeIntervalSince1970:99999999999]];
}
#pragma mark - ADBannerImageViewDelegate
- (void)imageViewTapped:(ADBannerModel *)model
{
    if ([self.itemDelegate respondsToSelector:@selector(itemTapped:)]) {
        [self.itemDelegate itemTapped:model];
    }
}

#pragma mark - PageControlDelegate
- (void)pageControlItemTapped:(NSInteger)indexNumber
{
    [self.adScrollView setContentOffset:CGPointMake(_viewWidth*indexNumber, 0.f)];
}
@end

@implementation ADBannerImageView

- (instancetype)initWithPlaceholderImage:(UIImage *)anImage
{
    self = [super initWithPlaceholderImage:anImage];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapImage
{
    if (self.model && [self.bannerDeleage respondsToSelector:@selector(imageViewTapped:)]) {
        [self.bannerDeleage imageViewTapped:self.model];
    }
}
@end
