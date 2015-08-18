//
//  HomeModel.h
//  PuHui
//
//  Created by rp.wang on 15/7/28.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
//**图片*/
@property (strong, nonatomic)  NSString *pic;
//**标题*/
@property (strong, nonatomic)  NSString *title;
//**跳转URL*/
@property (strong, nonatomic)  NSString *url;

@end
