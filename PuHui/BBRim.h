//
//  BBRim.h
//  PuHui
//
//  Created by rp.wang on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//^^^^^^^^^^^^^工具类信息^^^^^^^^^^^^^^^^
/*
 作用：设置（可以批量）UIView的边框属性（包含边框颜色，宽度，弧度，masksToBounds）
 公司：西安蓝鳍软件
 开发者：朱贝贝
 开发日期：2015-06-26
 */

#import <UIKit/UIKit.h>

@interface BBRim : UIView
//设置一个UIView边框的弧度和宽度(默认masksToBounds为YES)
-(void)bb_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid;
//##（重要）设置一个UIView边框的弧度，宽度和颜色(默认masksToBounds为YES)
-(void)bb_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color;
//##（重要）批量设置多个UIView边框的弧度，宽度和颜色(默认masksToBounds为YES)
-(void)bb_rimWithViews:(NSArray*) views radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color;
//设置一个UIView边框的弧度,宽度和颜色,masksToBounds
-(void)bb_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color masksToBounds:(BOOL) isBool;
//批量设置多个UIView边框的弧度,宽度和颜色,masksToBounds
-(void)bb_rimWithViews:(NSArray*) views radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color masksToBounds:(BOOL) isBool;
@end
