//
//  SelectBranchCourtsController.h
//  PuHui
//
//  Created by rp.wang on 15/7/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBranchCourtsController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)  NSString *cityName;


@property (strong, nonatomic)  NSArray *orderAry;
@property (assign, nonatomic)  int signOrd;
@end
