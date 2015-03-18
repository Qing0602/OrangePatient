//
//  CustomPageControl.m
//  WeyorApp
//
//  Created by ZhangQing on 13-3-27.
//  Copyright (c) 2013年 ZhangQing. All rights reserved.
//

/*************************
 //currentpage页数统一为0-3
 ************************/
#define Btn_Spacing 12.f
#define Btn_Width 8.f
#define Btn_Height 8.f
#define Left_Padding (self.frame.size.width-Btn_Spacing*(number-1)-Btn_Width*number)/2
#import "CustomPageControl.h"

@implementation CustomPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)setNumberOfPages : (NSInteger) number
{
    _numberOfPages = number;
    
    [self removeAllSubviews];
    
    for (int i = 0; i < number; i++) {
        controlBtn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
        [controlBtn[i] setFrame:CGRectMake(Left_Padding+(Btn_Width+Btn_Spacing)*i,( self.frame.size.height-Btn_Height)/2, Btn_Width, Btn_Height)];
        controlBtn[i].alpha = 0.5;
        //[controlBtn[i] setImageEdgeInsets:UIEdgeInsetsMake((Btn_Height-3)/2, 0, (Btn_Height-3)/2, 0)];
        
        //controlBtn[i].alpha = 0.45;
        //controlBtn[i].tag = i+1;
        [controlBtn[i] handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender){
            //设置当前页
            _currentPage = i;
            //刷新
            [self setNeedsDisplay];
            //pagecontrol点击事件
            if ([self.controlDelegate respondsToSelector:@selector(pageControlItemTapped:)]) {
                [self.controlDelegate pageControlItemTapped:_currentPage];
            }
        }];
       
        [self addSubview:controlBtn[i]];
    }
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    [self setNeedsDisplay];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    for (int i = 0; i < _numberOfPages ; i++) {
//        UIButton *btn = (UIButton *)[self viewWithTag:i+1];
        if (i == _currentPage) {
            controlBtn[i].backgroundColor = [UIColor whiteColor];
            //[controlBtn[i] setImage:[UIImage imageNamed:@"icon_im_point_whtie@2x.png"] forState:UIControlStateNormal];
        }else
        {
            //[controlBtn[i] setImage:[UIImage imageNamed:@"icon_im_point_gray@2x.png"] forState:UIControlStateNormal];
            controlBtn[i].backgroundColor = [UIColor grayColor];
        }
    }
}

-(NSInteger)getCurrentPage
{
    return _currentPage;
}
@end
