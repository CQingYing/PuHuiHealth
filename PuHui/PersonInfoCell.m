//
//  PersonInfoCell.m
//  PuHui
//
//  Created by administrator on 15/8/7.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonInfoCell.h"

@interface PersonInfoCell ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation PersonInfoCell

- (void)awakeFromNib {
    // Initialization code
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
