//
//  ReportListCell.m
//  PuHui
//
//  Created by rp.wang on 15/7/17.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "ReportListCell.h"
#import "BBRim.h"

@implementation ReportListCell

- (void)awakeFromNib {
    // Initialization code
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.cellView radius:8 width:1 color:[UIColor colorWithRed:123.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:0.4]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
