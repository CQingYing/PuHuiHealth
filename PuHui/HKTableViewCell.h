//
//  HKTableViewCell.h
//  PuHui
//
//  Created by administrator on 15/8/12.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *HKTitle;
@property (strong, nonatomic) IBOutlet UILabel *HKIntroduce;
@property (strong, nonatomic) IBOutlet UILabel *HKTime;
@property (strong, nonatomic) IBOutlet UILabel *HKClass;

@end
