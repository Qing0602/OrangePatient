//
//  LoveUIUtils.h
//  iLove
//
//  Created by mtf on 12-11-9.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//
#import <UIKit/NSText.h>

#ifndef iLove_LoveUIUtils_h
#define iLove_LoveUIUtils_h

#import "UIImage+Base.h"
#import "UIColor+Base.h"
#import "UIFont+Base.h"

#import "UIView+Base.h"
#import "UIImageView+Base.h"
#import "UIButton+Base.h"
#import "UILabel+Base.h"
#import "UIControl+Base.h"

#import "UIAlertView+Base.h"
#import "UIActionSheet+Base.h"
#import "UIApplication+Base.h"
//#import "LoveTopTipView.h"
// UI TextAlignment
#define UITextAlignmentLeft   NSTextAlignmentLeft
#define UITextAlignmentCenter NSTextAlignmentCenter
#define UITextAlignmentRight  NSTextAlignmentRight


// view frame
#define kViewLeft(__view) (__view.frame.origin.x)
#define kViewWidth(__view) (__view.frame.size.width)

#define kViewTop(__view) (__view.frame.origin.y)
#define kViewHeight(__view) (__view.frame.size.height)

#define kViewRight(__view) ( kViewLeft(__view) + kViewWidth(__view) )
#define kViewFoot(__view) ( kViewTop(__view) + kViewHeight(__view) )

#endif
