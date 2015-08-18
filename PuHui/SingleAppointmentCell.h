//
//  SingleAppointmentCell.h
//  PuHui
//
//  Created by administrator on 15/8/4.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleAppointmentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *setname;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *cost;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@end
