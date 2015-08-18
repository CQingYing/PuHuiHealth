//
//  TableViewCell.m
//  PuHui
//
//  Created by rp.wang on 15/7/7.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝
#import "TableViewCell.h"
#import "BBRim.h"
@interface TableViewCell()
@property (strong, nonatomic) IBOutlet UIView *conView;

@end
@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
//    BBRim *rim=[[BBRim alloc]init];
//    [rim bb_rimWithView:self.conView radius:8 width:1 color:[UIColor grayColor]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
