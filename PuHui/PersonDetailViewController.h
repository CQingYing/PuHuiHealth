//
//  PersonDetailViewController.h
//  PuHui
//
//  Created by administrator on 15/8/14.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *data;

- (instancetype)initWithData:(NSMutableArray *)mydata;

@end
