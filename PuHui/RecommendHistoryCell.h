//
//  RecommendHistoryCell.h
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import <UIKit/UIKit.h>

@interface RecommendHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameT;
@property (weak, nonatomic) IBOutlet UILabel *phoneT;
@property (weak, nonatomic) IBOutlet UILabel *sexT;
@property (weak, nonatomic) IBOutlet UILabel *mealT;
@property (weak, nonatomic) IBOutlet UILabel *keyT;
@property (weak, nonatomic) IBOutlet UILabel *timeT;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;

- (IBAction)buttonClick;

@end
