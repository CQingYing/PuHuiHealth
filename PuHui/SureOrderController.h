//
//  SureOrderController.h
//  PuHui
//
//  Created by rp.wang on 15/7/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SureOrderController : UIViewController
@property (strong, nonatomic)  NSString *adContent;
@property (strong, nonatomic)  NSString *mealTyContent;
@property (strong, nonatomic)  NSString *pagIDContent;



@property (strong, nonatomic)  NSArray *orderAry;
@property (assign, nonatomic)  int signOrd;
@end
