//
//  RecommendHistoryCell.m
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "RecommendHistoryCell.h"
#import "InternalReconmmendControlller.h"

@implementation RecommendHistoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)buttonClick {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil  message:@"推荐成功，发送短信" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];
}
@end
