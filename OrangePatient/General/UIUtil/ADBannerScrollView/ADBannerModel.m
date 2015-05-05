//
//  ADBannerModel.m
//  OrangePatient
//
//  Created by ZhangQing on 3/17/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "ADBannerModel.h"

@implementation ADBannerModel
+ (ADBannerModel *)convertModelByDic:(NSDictionary *)dic{
    ADBannerModel *model = [[ADBannerModel alloc] init];
    model.title = dic[@"title"];
    NSDictionary *pictures = dic[@"pictures"];
    if (pictures) {
        model.imageUrl = [NSURL URLWithString:pictures[@"big"]];
    }
    model.content = dic[@"content"];
    model.link = dic[@"url"];
    return model;
}
@end
