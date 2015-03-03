//
//  UILabel+Love.h
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//



@interface UILabel (Love)
+ (UILabel *)getNavBarTitleLabel:(NSString *)text;
@end

//在UILabel内计算内容的大小。
@interface UILabel (ContentSize)

- (CGSize)contentSize;

@end