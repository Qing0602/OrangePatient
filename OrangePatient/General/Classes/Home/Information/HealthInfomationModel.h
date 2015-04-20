//
//  HealthInfomationModel.h
//  OrangePatient
//
//  Created by ZhangQing on 15/3/25.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "BaseNSObject.h"

@interface HealthInfomationModel : BaseNSObject
//图片
@property (nonatomic, strong)NSURL *bigImageUrl;
@property (nonatomic, strong)NSURL *mediumImageUrl;
@property (nonatomic, strong)NSURL *smallImageUrl;
//id
@property (nonatomic)NSUInteger infoID;
//title
@property (nonatomic, strong)NSString *infoTitle;
//content
@property (nonatomic, strong)NSString *infoContent;
//link
@property (nonatomic, strong)NSURL *infoLink;
//clicked
@property (nonatomic)NSInteger clickedNum;
//comment
@property (nonatomic)NSInteger commentNum;
//like
@property (nonatomic)NSInteger likeNum;
@property (nonatomic)long infoPublishTime;
//more
//@property (nonatomic)NSInteger more;
//message
//@property (nonatomic, strong)NSString *message;

+ (HealthInfomationModel *)convertModelByDic:(NSDictionary *)dic;
@end
