//
//  HKSearchViewController.h
//  PuHui
//
//  Created by administrator on 15/8/11.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (copy, nonatomic) NSString *search;
@end
