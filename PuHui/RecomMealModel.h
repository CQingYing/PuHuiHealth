//
//  RecomMealModel.h
//  PuHui
//
//  Created by xalanqi on 15/7/27.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecomMealModel : NSObject
/**id*/
@property (assign,nonatomic)   int package_id;
/**折扣价格*/
@property (assign,nonatomic)   int cost;
/**套餐名称*/
@property (strong, nonatomic)  NSString * name;
/**销售价*/
@property  (assign,nonatomic)  int  retail;
@end
