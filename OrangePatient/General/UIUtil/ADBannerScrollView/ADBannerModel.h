//
//  ADBannerModel.h
//  OrangePatient
//
//  Created by ZhangQing on 3/17/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADBannerModel : NSObject


@property (nonatomic, strong)NSURL *imageUrl;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *link;

+ (ADBannerModel *)convertModelByDic:(NSDictionary *)dic;
@end
