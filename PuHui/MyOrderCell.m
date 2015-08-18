//
//  MyOrderCell.m
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "MyOrderCell.h"
#import "BBRim.h"
@implementation MyOrderCell

- (void)awakeFromNib {
    // Initialization code
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.mainView radius:6 width:0.6 color:[UIColor colorWithRed:203.0/255.0 green:203.0/255.0  blue:203.0/255.0  alpha:1]];
    self.conVi.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
