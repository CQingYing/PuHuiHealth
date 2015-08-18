//
//  AlreadyAcceptCell.h
//  PuHui
//
//  Created by rp.wang on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlreadyAcceptCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *acceptHiew;
@property (strong, nonatomic) IBOutlet UIImageView *accepticoniI;
@property (strong, nonatomic) IBOutlet UILabel *detail;
@property (strong, nonatomic) IBOutlet UILabel *timer;
@property (weak, nonatomic) IBOutlet UIView *unread;
@property (strong, nonatomic) IBOutlet UILabel *personName;
@end
