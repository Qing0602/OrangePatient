//
//  AppDelegate.h
//  OrangePatient
//
//  Created by ZhangQing on 2/26/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate>
{
    EMConnectionState _connectionState;
}
@property (strong, nonatomic) UIWindow *window;


@end

