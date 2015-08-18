//
//  HeadSectionView.h
//  PuHui
//
//  Created by rp.wang on 15/8/4.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadSectionView : UIView

@property (strong, nonatomic)  UILabel *footBo;
@property (strong, nonatomic)  UIView *subViewa;
@property (strong, nonatomic)  UILabel *headCode;
@property (strong, nonatomic)  UILabel *headTrade;
@property (assign,nonatomic)   CGFloat  xWid;
@property (assign,nonatomic)   CGFloat yHei;
@property (strong, nonatomic)  UILabel *footTime;
@property (strong, nonatomic)  UILabel *footCount;
@property (strong, nonatomic)  UILabel *footTotal;

-(UIView *)objHeadViewX:(CGFloat)x viewY:(CGFloat)y codeTxt:(NSString *)codTxt tradeTxt:(NSString *)trdTxt;
-(UIView *)objFootViewX:(CGFloat)x viewY:(CGFloat)y timeTxt:(NSString *)timeTxt countTxt:(NSString *)countTxt  totalTxt:(NSString *) totalTxt;
@end
