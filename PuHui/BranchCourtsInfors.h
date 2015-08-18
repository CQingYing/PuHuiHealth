//
//  BranchCourtsInfors.h
//  PuHui
//
//  Created by rp.wang on 15/7/20.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BranchCourtsInfors : NSObject
/**地址*/
@property (strong, nonatomic)  NSString * addr ;
/**id*/
@property (assign, nonatomic)  int  center_id;
/**名字*/
@property (strong, nonatomic)  NSString * name;
/**电话*/
@property (strong, nonatomic)  NSString * phone;
/**图片*/
@property (strong, nonatomic)  NSString * pic ;
/**时间*/
@property (strong, nonatomic)  NSString * serv_time;
@end
