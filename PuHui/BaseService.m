//
//  BaseService.m
//  KakaSeal
//
//  Created by ji junjie on 15/5/5.
//  Copyright (c) 2015年 蓝鳍. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService


-(MBProgressHUD *)HUD
{
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc] initWithWindow:TheAppDelegate.window];
    }
    return _HUD;
}

- (void)handleNetworkError:(NSError *)error
{
    NSLog(@"%s: %@", __func__, error.localizedDescription);
}

- (void)displayLoadingIndicator
{
    //显示加载提示
    [TheAppDelegate.window addSubview:self.HUD];
    self.HUD.labelText = @"加载中...";
    [self.HUD show:YES];
}

- (void)dismissLoadingIndicator
{
    //取消加载提示
    if (self.HUD) {
        [self.HUD hide:YES];
        self.HUD = nil;
    }
}

- (void)showAlert:(NSString *)str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
@end
