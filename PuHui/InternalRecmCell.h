//
//  InternalRecmCell.h
//  PuHui
//
//  Created by xalanqi on 15/7/27.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InternalRecmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mealName;
@property (weak, nonatomic) IBOutlet UILabel *mealID;
@property (weak, nonatomic) IBOutlet UILabel *mealDetail;
@property (weak, nonatomic) IBOutlet UILabel *mealCost;

@end
