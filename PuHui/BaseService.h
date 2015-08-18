//
//  BaseService.h
//  KakaSeal
//
//  Created by ji junjie on 15/5/5.
//  Copyright (c) 2015年 蓝鳍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface BaseService : NSObject

@property (strong,nonatomic) MBProgressHUD *HUD;

- (void)handleNetworkError:(NSError *)error;

- (void)displayLoadingIndicator;
- (void)dismissLoadingIndicator;

- (void)showAlert:(NSString *)str;
@end
