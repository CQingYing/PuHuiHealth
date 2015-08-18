//
//  AppDelegate.m
//  PuHui
//
//  Created by rp.wang on 15/7/2.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PersonController.h"
#import "MBProgressHUD.h"

@interface AppDelegate ()

// Reachability *hostReach;
@property (strong, nonatomic)  MainTabBarController *main;
@property (strong, nonatomic)  PersonController *personCon;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    // 设置根控制器
    self.main = [[MainTabBarController alloc]init];
    self.window.rootViewController = self.main;
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ardLogin) name:@"AlreadLogin" object:nil];
    return YES;
}
-(void)ardLogin{
    
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

//支付宝集成
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
       
//        NSLog(@"result = %@",resultDic);
//        NSLog(@"!!!!!%@",resultDic[@"resultStatus"]);
//        if([resultDic[@"resultStatus"] isEqualToString:@"9000"]){
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:url delegate:self cancelButtonTitle:@"1" otherButtonTitles:@"2",nil];
//       
//        }
    }];
    
    return YES;
}

@end