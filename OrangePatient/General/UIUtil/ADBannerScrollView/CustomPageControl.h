//
//  CustomPageControl.h
//  WeyorApp
//
//  Created by ZhangQing on 13-3-27.
//  Copyright (c) 2013年 ZhangQing. All rights reserved.
//
#define CurrentPageKey @"_currentPage"

#import <UIKit/UIKit.h>
@protocol CustomPageControlDelegate <NSObject>

@required
-(void)itemTapped:(NSInteger)indexNumber;

@end

@interface CustomPageControl : UIControl
{
    NSInteger _numberOfPages;
    NSInteger _currentPage;
    UIButton *controlBtn[5];
}
@property (nonatomic , assign) id<CustomPageControlDelegate> _delegate;

-(void)setNumberOfPages : (NSInteger) number;

-(void)setCurrentPage:(NSInteger)currentPage;

-(NSInteger)getCurrentPage;

@end
