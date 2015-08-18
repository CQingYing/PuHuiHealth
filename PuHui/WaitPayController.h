//
//  WaitPayController.h
//  PuHui
//
//  Created by administrator on 15/8/7.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitPayController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)  NSString *name;
@property (strong, nonatomic)  NSString *phone;
@property (strong, nonatomic)  NSString *idCard;
@property (strong, nonatomic)  NSString *ordersCount;
@property (strong, nonatomic)  NSString *totalAmount;
@property (strong, nonatomic)  NSString *discountAmount;
@property (strong, nonatomic)  NSArray *datas;
@property (strong, nonatomic)  NSArray *cartDatas;
@property (assign,nonatomic)   int   isCarts;
@end
