//
//  InformationOperation.h
//  OrangePatient
//
//  Created by singlew on 15/4/15.
//  Copyright (c) 2015年 Orange. All rights reserved.
//

#import "CustomOperation.h"

typedef enum{
    kGetRecent,
    kGetRecentDetail,
    kGetAD,
}InforType;

@interface InformationOperation : CustomOperation
-(InformationOperation *) initGetRecent : (NSUInteger) offset withLimit : (NSUInteger) limit;
-(InformationOperation *) initGetRecentDetail : (NSInteger) recentID;
-(InformationOperation *) initGetAD;
@end
