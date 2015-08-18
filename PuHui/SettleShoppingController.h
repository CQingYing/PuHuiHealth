//
//  SettleShoppingController.h
//  PuHui
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "SettleShoppingCell.h"
#import "ShoppingCartController.h"
#import "SetModel.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "RequestServer.h"

@interface SettleShoppingController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    int costMoney;
}
@property(strong, nonatomic) NSArray *dataArray;
@property(strong, nonatomic) UILabel *cost;
@property(strong, nonatomic) UITextField *numberText;
@property(strong, nonatomic) UITextField *phoneText;
@property(strong, nonatomic) UITextField *nameText;
@property (assign,nonatomic) int isCarts;

-(void)getData:(NSMutableArray *)mutableArray andCostMoney:(int)money;
-(id)initwithArray:(NSArray *)_array;
@end
