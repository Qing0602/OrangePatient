//
//  ADBannerScrollView.h
//  OrangePatient
//
//  Created by ZhangQing on 3/17/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPageControl.h"
@class ADBannerImageView;

#import "ADBannerModel.h"

@protocol ADBannerImageViewDelegate <NSObject>

@optional
- (void)imageViewTapped:(ADBannerModel *)model;

@end

@protocol ADBannerScrollViewDelegate <NSObject>

- (void)itemTapped:(ADBannerModel *)model;

@end

@interface ADBannerScrollView : UIView<ADBannerImageViewDelegate>
//scrollview
@property (nonatomic, strong)UIScrollView *adScrollView;
@property (nonatomic, strong)CustomPageControl *pageControl;
//models
@property (nonatomic, strong)NSArray *adModels;
//delegate
@property (nonatomic, assign)id<ADBannerScrollViewDelegate> itemDelegate;
@property (nonatomic)CGFloat viewWidth;
- (instancetype)initWithFrame:(CGRect)frame
                        placeholdImage:(UIImage *)image
                         models:(NSArray *)models;

@end



#import "EGOImageView.h"

@interface ADBannerImageView : EGOImageView

@property (nonatomic, strong)ADBannerModel *model;
@property (nonatomic, assign)id<ADBannerImageViewDelegate> bannerDeleage;

@end