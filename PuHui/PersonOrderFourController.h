//
//  PersonOrderFourController.h
//  PuHui
//
//  Created by rp.wang on 15/7/24.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonOrderFourController : UIViewController
@property (assign,nonatomic) int isMen;
//*1:18-30 2:31-50 3:50-*/
@property (assign,nonatomic) int ageRang;
//*0:无  1:有*/
@property (assign,nonatomic) int isSex;
//
@property (strong, nonatomic)  NSMutableArray *mutaArrs;
@end
