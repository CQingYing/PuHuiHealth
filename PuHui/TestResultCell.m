//
//  TestResultCell.m
//  PuHui
//
//  Created by rp.wang on 15/7/24.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "TestResultCell.h"
#import "BBRim.h"

@implementation TestResultCell

- (void)awakeFromNib {
    // Initialization code
    self.priceLab.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
    self.realPriceLab.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
    self.labA.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
    self.labB.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
//    UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taps)];
//    self.isCheckBox.userInteractionEnabled=YES;
//    [self.isCheckBox addGestureRecognizer:ges];
}

-(void)taps{
    if([self.isSele.text isEqualToString:@"未选中"]){
    self.isCheckBox.image=[UIImage imageNamed:@"personcheckbox"];
    self.isSele.text=@"选中";
        return;
    }
    if([self.isSele.text isEqualToString:@"选中"]){
        self.isCheckBox.image=[UIImage imageNamed:@"personnotcheckbox"];
        self.isSele.text=@"未选中";
        return;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
