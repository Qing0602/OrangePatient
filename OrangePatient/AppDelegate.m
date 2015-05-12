//
//  AppDelegate.m
//  OrangePatient
//
//  Created by ZhangQing on 2/26/15.
//  Copyright (c) 2015 Orange. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MyDeviceViewController.h"
#import "MyViewController.h"
#import "ReportViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "AppDelegate+EaseMob.h"

@interface AppDelegate ()<UIAlertViewDelegate, WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tb = [[UITabBarController alloc]init];
    [[tb tabBar] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:45/255.f green:45/255.f blue:45/255.f alpha:1.f]]];
    [[tb tabBar] setSelectionIndicatorImage:[UIImage imageWithColor:[UIColor orangeColor]andImageSize:CGSizeMake(SCREEN_WIDTH/4, [tb tabBar].frame.size.height)]];
    [[tb tabBar] setSelectedImageTintColor:[UIColor whiteColor]];
    
    ViewController *viewcontroller = [[ViewController alloc] init];
    viewcontroller.title = @"登录";
    viewcontroller.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    [viewcontroller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:93/255.f green:93/255.f blue:93/255.f alpha:1.f],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [viewcontroller.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
    
    
    
    MyDeviceViewController *deviceVC = [[MyDeviceViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:deviceVC];
    deviceVC.title = @"监测";
    deviceVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_device"];
    [deviceVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:93/255.f green:93/255.f blue:93/255.f alpha:1.f],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [deviceVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    ReportViewController *reportVC = [[ReportViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:reportVC];
    reportVC.title = @"报告";
    reportVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_report"];
    [reportVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:93/255.f green:93/255.f blue:93/255.f alpha:1.f],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [reportVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:myVC];
    myVC.title = @"我";
    myVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_mine"];
    [myVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:93/255.f green:93/255.f blue:93/255.f alpha:1.f],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [myVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    tb.viewControllers = @[nav,nav1,nav2,nav3];
    
    self.window.rootViewController = tb;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{[UIColor blackColor]:NSForegroundColorAttributeName} forState:UIControlStateNormal];
    [UINavigationBar appearance].tintColor = [UIColor orangeColor];
    [UINavigationBar appearance].backgroundColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{[UIColor orangeColor]:NSForegroundColorAttributeName}];
    [self.window makeKeyAndVisible];
    
    // 初始化环信SDK，详细内容在AppDelegate+EaseMob.m 文件中
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    //向微信注册
    [WXApi registerApp:@"wx92132536c2ae6632" withDescription:@"OrangePatient"];
    return YES;
}

- (void) sendTextContent{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"Orange Patient";
    req.bText = YES;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return  [WXApi handleOpenURL:url delegate:self];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
