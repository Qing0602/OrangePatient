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
@property (nonatomic, strong)NSURL *imageUrl;
//title
@property (nonatomic, strong)NSString *infoTitle;
//content
@property (nonatomic, strong)NSString *infoContent;
//link
@property (nonatomic, strong)NSURL *infoLink;
@end
