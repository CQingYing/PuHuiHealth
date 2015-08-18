//
//  HKTableViewController.h
//  PuHui
//
//  Created by administrator on 15/8/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSString *categoryId;
@property (strong, nonatomic) NSString *NavTitle;
@end
