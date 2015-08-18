//
//  TestResultCell.h
//  PuHui
//
//  Created by rp.wang on 15/7/24.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestResultCell : UITableViewCell

//priceLab,realPriceLab nameLab
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *realPriceLab;
@property (strong, nonatomic) IBOutlet UIImageView *isCheckBox;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *labA;
@property (strong, nonatomic) IBOutlet UILabel *labB;
@property (strong, nonatomic) IBOutlet UILabel *isSele;

@end
