//
//  TableViewCell.h
//  PuHui
//
//  Created by rp.wang on 15/7/7.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftLcon;
@property (strong, nonatomic) IBOutlet UILabel *centerLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightIcon;
@property (strong, nonatomic) IBOutlet UIView *tVCell;

@end
