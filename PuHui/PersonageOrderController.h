//
//  PersonageOrderController.h
//  PuHui
//
//  Created by rp.wang on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import <UIKit/UIKit.h>

@interface PersonageOrderController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic)  NSArray *orderAry;
@property (assign, nonatomic)  int signOrd;
@end
