//
//  MyOrderCell.h
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import <UIKit/UIKit.h>

@interface MyOrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImg;
@property (strong, nonatomic) IBOutlet UILabel *mealTypeLab;
@property (strong, nonatomic) IBOutlet UILabel *objLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *allPriLab;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *codeLab;
@property (strong, nonatomic) IBOutlet UIView *conVi;

@end
