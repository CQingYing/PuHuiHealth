//
//  HKTableModel.h
//  PuHui
//
//  Created by administrator on 15/8/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKTableModel : NSObject
/**知识ID*/
@property (strong, nonatomic)  NSString * infoId;
/**知识标题*/
@property (strong, nonatomic)  NSString * infoTitle;
/**知识简介*/
@property (strong, nonatomic)  NSString * infoSummary;
/**分类ID*/
@property (strong, nonatomic)  NSString * categoryId;
/**分类名称*/
@property (strong, nonatomic)  NSString * categoryName;
/**发布时间*/
@property (strong, nonatomic)  NSString * releaseTime;

@end
