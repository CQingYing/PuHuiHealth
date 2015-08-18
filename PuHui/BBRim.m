//
//  BBRim.m
//  PuHui
//
//  Created by rp.wang on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//^^^^^^^^^^^^^工具类信息^^^^^^^^^^^^^^^^
/*
 作用：设置（可以批量）UIView的边框属性（包含边框颜色，宽度，弧度）
 公司：西安蓝鳍软件
 开发者：朱贝贝
 开发日期：2015-06-26
 */

#import "BBRim.h"

@implementation BBRim


-(void)bb_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid{
    view.layer.masksToBounds=YES;
    view.layer.borderWidth = wid;
    view.layer.cornerRadius = radius;
}
//方法二（重要）：设置一个UIView边框的弧度，宽度和颜色
-(void)bb_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor*)color{
    view.layer.masksToBounds=YES;
    view.layer.borderWidth = wid;
    view.layer.cornerRadius = radius;
    CGColorRef cgcolor=[color CGColor];
    view.layer.borderColor=cgcolor;
}
//方法三（重要）：批量设置多个UIView边框的弧度，宽度和颜色
-(void)bb_rimWithViews:(NSArray*) views radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color{
    for (UIView *view  in views) {
        view.layer.masksToBounds=YES;
        view.layer.borderWidth = wid;
        view.layer.cornerRadius = radius;
        CGColorRef cgcolor=[color CGColor];
        view.layer.borderColor=cgcolor;
    }
}
//方法四：设置一个UIView边框的弧度,宽度和颜色,masksToBounds
-(void)bb_rimWithView:(UIView*) view radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color masksToBounds:(BOOL) isBool{
    view.layer.masksToBounds=isBool;
    view.layer.borderWidth = wid;
    view.layer.cornerRadius = radius;
    CGColorRef cgcolor=[color CGColor];
    view.layer.borderColor=cgcolor;
}
//方法五：批量设置多个UIView边框的弧度,宽度和颜色,masksToBounds
-(void)bb_rimWithViews:(NSArray*) views radius:(CGFloat)radius width:(CGFloat)wid color:(UIColor *)color masksToBounds:(BOOL) isBool{
    for (UIView *view  in views) {
        view.layer.masksToBounds=isBool;
        view.layer.borderWidth = wid;
        view.layer.cornerRadius = radius;
        CGColorRef cgcolor=[color CGColor];
        view.layer.borderColor=cgcolor;
    }
}

@end
