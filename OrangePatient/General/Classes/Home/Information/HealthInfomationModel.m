//
//  HealthInfomationModel.m
//  OrangePatient
//
//  Created by ZhangQing on 15/3/25.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "HealthInfomationModel.h"

@implementation HealthInfomationModel
+ (HealthInfomationModel *)convertModelByDic:(NSDictionary *)dic{
    HealthInfomationModel *tempModel = [[HealthInfomationModel alloc] init];
    tempModel.infoID = [dic[@"id"] integerValue];
    tempModel.infoTitle = dic[@"title"];
    NSDictionary *pictures = dic[@"pictures"];
    if (pictures) {
        tempModel.bigImageUrl = [NSURL URLWithString:pictures[@"big"]];
        tempModel.mediumImageUrl = [NSURL URLWithString:pictures[@"medium"]];
        tempModel.smallImageUrl = [NSURL URLWithString:pictures[@"small"]];
    }
    tempModel.infoContent = dic[@"content"];
    tempModel.clickedNum = [dic[@"clicked"] integerValue];
    tempModel.commentNum = [dic[@"comment"] integerValue];
    tempModel.likeNum = [dic[@"like"] integerValue];
    tempModel.infoPublishTime = [dic[@"publish_time"] longLongValue];
    return tempModel;
}
@end
