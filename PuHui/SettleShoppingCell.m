//
//  SettleShoppingCell.m
//  PuHui
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "SettleShoppingCell.h"

@interface SettleShoppingCell ()
@property(strong, nonatomic) IBOutlet UIView* backView;

@end

@implementation SettleShoppingCell
@synthesize imageView,nameLabel,peopleLabel,priceLabel,costLabel;

- (void)awakeFromNib {
    // Initialization code
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    self.peopleLabel.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
