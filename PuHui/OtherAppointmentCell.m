//
//  OtherAppointmentCell.m
//  PuHui
//
//  Created by administrator on 15/8/4.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "OtherAppointmentCell.h"

@interface OtherAppointmentCell ()
@property(strong, nonatomic) IBOutlet UIView *background;
@end

@implementation OtherAppointmentCell

- (void)awakeFromNib {
    // Initialization code
    self.background.layer.cornerRadius = 5;
    self.background.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
