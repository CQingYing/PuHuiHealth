//
//  detailViewController.h
//  PuHui
//
//  Created by administrator on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "ShoppingCartController.h"
#import "SetModel.h"
#import "UIImageView+WebCache.h"
#import "SettleShoppingController.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "RequestServer.h"
#import "MBProgressHUD.h"

@interface detailViewController : UIViewController

-(id)initWithData:(SetModel *)model;

@end
