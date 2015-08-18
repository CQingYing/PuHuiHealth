//
//  AlreadyAcceptCell.m
//  PuHui
//
//  Created by rp.wang on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "AlreadyAcceptCell.h"
#import "BBRim.h"
@implementation AlreadyAcceptCell
@synthesize unread;

- (void)awakeFromNib {
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.acceptHiew radius:8 width:1 color:[UIColor clearColor]];
    self.unread.layer.cornerRadius = self.unread.frame.size.width/2;
    self.unread.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
