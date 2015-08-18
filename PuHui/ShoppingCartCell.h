//
//  ShoppingCartCell.h
//  PuHui
//
//  Created by administrator on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetModel.h"

@protocol ShoppingCartDelegate <NSObject>

@optional
-(void)selecteClicked:(id)sender WithModel:(SetModel *)_model;
-(void)rightPlus:(id)sender Percost:(int)percost Name:(NSString *)name Number:(int)number;
-(void)leftReduction:(id)sender Percost:(int)percost Name:(NSString *)name Number:(int)number;

@end

@interface ShoppingCartCell : UITableViewCell
{
    id<ShoppingCartDelegate>_delegate;
    int cost;
}
@property(nonatomic, strong) SetModel *model;
@property(strong, nonatomic) IBOutlet UIButton *didSelected;
@property(strong, nonatomic) IBOutlet UILabel *numberLabel;
@property(strong, nonatomic) IBOutlet UILabel *costLabel;
@property(strong, nonatomic) IBOutlet UIImageView *img;
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(strong, nonatomic) IBOutlet UILabel *peopleLabel;
@property(strong, nonatomic) IBOutlet UILabel *priceLabel;
@property(strong, nonatomic) IBOutlet UIButton *leftButton;

-(void)setDelegate:(id)delegate;
@end
