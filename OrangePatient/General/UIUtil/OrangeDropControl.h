//
//  OrangeDropControl.h
//  OrangePatient
//
//  Created by ZhangQing on 15/5/8.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseUIView.h"
@class OrangeDropControl;
@protocol OrangeDropControlDatasouce <NSObject>
@required
-(NSArray *)arrarOfDropControl : (OrangeDropControl *)dropControl;
@end


@protocol OrangeDropControlDelegate <NSObject>
-(void)valueChanged:(OrangeDropControl *)dropControl withChooseTitle:(NSString *)title;
@end

@interface OrangeDropControl : BaseUIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UITableView *dropControlTableview;
@property (nonatomic, strong) NSArray *tableviewData;
@property (nonatomic, assign) id<OrangeDropControlDatasouce> datasouce;
@property (nonatomic, assign) id<OrangeDropControlDelegate> delegate;
-(NSString *)currentTitle;
-(void)setCurrentTitle:(NSString *)title;

@end
