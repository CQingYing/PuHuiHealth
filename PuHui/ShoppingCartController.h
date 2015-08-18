//
//  ShoppingCartController.h
//  PuHui
//
//  Created by administrator on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartCell.h"
#import "Masonry.h"
#import "MainTabBarController.h"
#import "SettleShoppingController.h"

@interface ShoppingCartController : UIViewController<UITableViewDataSource,UITableViewDelegate,ShoppingCartDelegate,UIAlertViewDelegate>

@property(strong, nonatomic) NSMutableArray *mutableArray;

@end
