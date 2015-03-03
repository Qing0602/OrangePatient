//
//  UIImage+Love.m
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import "UIImage+Base.h"
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation UIImage (Base)
+(UIImage *) scaleImage: (UIImage *)image scaleFactor:(float)scaleFloat
{
    CGSize size = CGSizeMake(image.size.width * scaleFloat, image.size.height * scaleFloat);
    
    UIGraphicsBeginImageContext(CGSizeMake(floor(size.width), floor(size.height)));
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGAffineTransform transform = CGAffineTransformIdentity;
    //
    //    transform = CGAffineTransformScale(transform, scaleFloat, scaleFloat);
    //    CGContextConcatCTM(context, transform);
    
    // Draw the image into the transformed context and return the image
    //    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
    
    [image drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;  
}
//等比例改变图片大小
+ (UIImage *)changeImage:(UIImage*) img Width:(float)width Height:(float)height
{
    UIImage *image = img;
    CGSize size = image.size;
    
    float scale1 = width/height;    //特定给的比值
    float scale2 = size.width/size.height;   //图片比例
    CGFloat ratio = 0;
    if (scale2>scale1)
    {
        if (size.width > size.height)
        {
            ratio = height / size.width;
        }
        else
        {
            ratio = height / size.height;
        }
    }
    else
    {
        if (size.width > size.height)
        {
            ratio = width / size.width;
        } else
        {
            ratio = width / size.height;
        }
    }
  
    return [image imageByScalingAndCroppingForSizeEx:CGSizeMake(ratio * size.width, ratio * size.height)];
}
- (UIImage*)imageByScalingAndCroppingForSizeEx:(CGSize)targetSize
{
    
    UIImage *sourceImage = self;
    
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
        
    {
        
        CGFloat widthFactor = targetWidth / width;
        
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            
            scaleFactor = widthFactor; // scale to fit height
        
        else
            
            scaleFactor = heightFactor; // scale to fit width
        
        scaledWidth  = width * scaleFactor;
        
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor > heightFactor)
            
        {
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }
        
        else
            
            if (widthFactor < heightFactor)
                
            {
                
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
                
            }
        
    }
    
    // UIGraphicsBeginImageContext(targetSize); // this will crop
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0); // 0.0 for scale means "correct scale for device's main screen".
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    
    thumbnailRect.size.width  = scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
        
        
    
    //pop the context to get back to the default
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@implementation UIImage (mask)

// 画水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect
{
	CGSize imgSize = self.size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imgSize);

    [self drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    [mask drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@implementation UIImage (add)

// 从底下拼接一张图
- (UIImage *) addImage:(UIImage*) aImage{
    
    CGSize imgSize = CGSizeMake(self.size.width, self.size.height + aImage.size.height);

    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imgSize);
    
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    [aImage drawInRect:CGRectMake(0, self.size.height, aImage.size.width, aImage.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation UIImage (RNBlurredSideViewController)

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor
{
    //image must be nonzero size
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f) return self;
    
    //boxsize must be an odd integer
    uint32_t boxSize = (uint32_t)(radius * self.scale);
    if (boxSize % 2 == 0) boxSize ++;
    
    //create image buffers
    CGImageRef imageRef = self.CGImage;
    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    size_t bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);
    
    //create temp buffer
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    
    //copy image data
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++)
    {
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        //swap buffers
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }
    
    //free buffers
    free(buffer2.data);
    free(tempBuffer);
    
    //create image context from buffer
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));
    
    //apply tint
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f)
    {
        CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:0.25].CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }
    
    //create image from context
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    return image;
}

@end