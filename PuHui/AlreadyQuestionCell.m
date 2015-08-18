//
//  AlreadyQuestionCell.m
//  PuHui
//
//  Created by rp.wang on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "AlreadyQuestionCell.h"
#import "BBRim.h"
@implementation AlreadyQuestionCell

- (void)awakeFromNib {
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.mainView radius:8 width:1 color:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
