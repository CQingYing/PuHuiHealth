//
//  FavoriteTableCell.m
//  PuHui
//
//  Created by administrator on 15/7/29.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "FavoriteTableCell.h"
@interface FavoriteTableCell ()
@property(strong, nonatomic) IBOutlet UIView *backView;
@end
@implementation FavoriteTableCell

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
