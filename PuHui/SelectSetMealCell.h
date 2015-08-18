//
//  SelectSetMealCell.h
//  PuHui
//
//  Created by rp.wang on 15/7/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectSetMealCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cellImg;
@property (strong, nonatomic) IBOutlet UILabel *mealType;
@property (strong, nonatomic) IBOutlet UILabel *inPrice;
@property (strong, nonatomic) IBOutlet UILabel *allPrice;
@property (strong, nonatomic) IBOutlet UILabel *adjusObj;
@property (strong, nonatomic) IBOutlet UILabel *purchaseCount;
@property (strong, nonatomic) IBOutlet UILabel *mealInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *mealSimLabel;
@property (strong, nonatomic) IBOutlet UILabel *picInfoLabel;
@property (strong, nonatomic) IBOutlet UILabel *pagID;

@end
