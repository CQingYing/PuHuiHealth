//
//  SetModel.h
//  PuHui
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetModel : NSObject

//marry = 0; //"package_id" = 132;

/**适用对象*/
@property (copy, nonatomic)  NSString  * age_type;
/**购买数量*/
@property (assign,nonatomic)   int buy_count;
/**折扣价格*/
@property (assign,nonatomic)   int cost;
/**适用性别 1: 男2：女*/
@property (assign,nonatomic)   int gender;
//**套餐详情图片*/
@property (copy, nonatomic)  NSString  * info_pic;
/**套餐名称*/
@property (copy, nonatomic)  NSString * name;
/**套餐项目*/
@property (copy, nonatomic)  NSString * pack_info;
/**套餐列表图片*/
@property (copy, nonatomic)  NSString * pic;
/**销售价*/
@property  (assign,nonatomic)   int retail;
/**套餐简介*/
@property  (copy, nonatomic)  NSString * serv_info;
/**套餐类型*/
@property (strong, nonatomic)  NSString * type ;
/**套餐id*/
@property (strong, nonatomic)  NSString * package_id ;


@end
