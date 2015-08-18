//
//  ShoppingCartCell.m
//  PuHui
//
//  Created by administrator on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "ShoppingCartCell.h"

@interface ShoppingCartCell ()

@property(strong, nonatomic) IBOutlet UIButton *rightButton;
@property(strong, nonatomic) IBOutlet UIView *backView;
@end


@implementation ShoppingCartCell
@synthesize numberLabel,leftButton,rightButton,priceLabel,didSelected,costLabel,model;


- (void)awakeFromNib {
    // Initialization code
    numberLabel.layer.borderWidth = 1;
    numberLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    leftButton.layer.borderWidth = 1;
    leftButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    rightButton.layer.borderWidth = 1;
    rightButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.peopleLabel.numberOfLines = 0;
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.masksToBounds = YES;
    [self.didSelected setImage:[UIImage imageNamed:@"Not selected-1"] forState:UIControlStateNormal];
    [self.didSelected setImage:[UIImage imageNamed:@"Selected-2"]forState:UIControlStateSelected];
    [self.didSelected addTarget:self action:@selector(didClickSelecte) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)leftClicked:(id)sender
{
    model.buy_count--;
    int i = [self.numberLabel.text intValue];
    self.numberLabel.text = [NSString stringWithFormat:@"%d",--i];
    if(i == 1)
    {
        leftButton.hidden = YES;
    }
    int x = model.cost;
    self.costLabel.text = [NSString stringWithFormat:@"¥%d",x*i];
    [_delegate leftReduction:self.didSelected Percost:model.cost Name:self.nameLabel.text Number:[self.numberLabel.text intValue]];
}

-(IBAction)rightClicked:(id)sender
{
    model.buy_count++;
    int i = [self.numberLabel.text intValue];
    self.numberLabel.text = [NSString stringWithFormat:@"%d",++i];
    if(i > 0)
    {
        leftButton.hidden = NO;
    }
    int x = model.cost;
    self.costLabel.text = [NSString stringWithFormat:@"¥%d",x*i];
    [_delegate rightPlus:self.didSelected Percost:model.cost Name:self.nameLabel.text Number:[self.numberLabel.text intValue]];
}

-(void)didClickSelecte
{
    if (self.didSelected.selected) {
        self.didSelected.selected = NO;
    }
    else
    {
        self.didSelected.selected = YES;
    }
    [_delegate selecteClicked:self.didSelected WithModel:model];
}

-(void)setDelegate:(id)delegate{
    _delegate = delegate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
