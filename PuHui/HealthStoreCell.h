//
//  HealthStoreCell.h
//  PuHui
//
//  Created by administrator on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetModel.h"

@interface HealthStoreCell : UITableViewCell
@property(strong, nonatomic) SetModel *setmodel;
@property(strong, nonatomic) IBOutlet UIImageView *img;
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(strong, nonatomic) IBOutlet UILabel *priceLabel;
@property(strong, nonatomic) IBOutlet UILabel *costLabel;
@property(strong, nonatomic) IBOutlet UILabel *peopleLabel;
@property(strong, nonatomic) IBOutlet UILabel *sellLabel;

@end
