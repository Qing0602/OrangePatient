//
//  UIActionSheet+Love.h
//  iLove
//
//  Created by mtf on 12-11-15.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (blocks)<UIActionSheetDelegate>

-(void)showInView:(UIView *)view
     clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock;

-(void)showFromToolbar:(UIToolbar *)view
          clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock;

-(void)showFromTabBar:(UITabBar *)view
         clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock;

-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
       clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock;

-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
                clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock;

@end
