//
//  UIAlertView+Love.h
//  iLove
//
//  Created by mtf on 12-11-15.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (blocks)<UIAlertViewDelegate>

-(void)showWithClickedBlock:(void(^)(NSInteger buttonIndex))clickedBlock;

@end
