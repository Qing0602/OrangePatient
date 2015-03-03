//
//  UIImage+Love.h
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import <UIKit/UIKit.h>
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface UIImage (Base)
+(UIImage *) scaleImage: (UIImage *)image scaleFactor:(float)scaleFloat;
+ (UIImage *)changeImage:(UIImage*) img Width:(float)width Height:(float)height;

- (UIImage*)imageByScalingAndCroppingForSizeEx:(CGSize)targetSize;
@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface UIImage (mask)
// 画水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface UIImage (add)
// 从底下拼接一张图
- (UIImage *) addImage:(UIImage*) aImage;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define DEFAULT_LEFT_WIDTH SCREEN_WIDTH-60
#define DEFAULT_RIGHT_WIDTH SCREEN_WIDTH-60
#define DEFAULT_ALPHA 0.5
#define DEFAULT_DIM_ALPHA 0.4
@interface UIImage (RNBlurredSideViewController)
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
@end