//
//  HealthStoreHeader.h
//  PuHui
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "SetModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@protocol HealthStoreHeaderDelegate <NSObject>

-(void)ClickedChooseButtonWithTag:(long)tag;   //点击套餐类型（全部套餐等）后执行该方法，代理此方法执行筛选
-(void)ClickedManOrWomanWithTag:(long)tag;     //点击性别类型后执行该方法，代理此方法执行筛选
-(void)ClickedImageViewWithModel:(SetModel *)sm;

@end

@interface HealthStoreHeader : UIView<UIScrollViewDelegate>
{
    id<HealthStoreHeaderDelegate>_delegate;
}
@property(nonatomic)float height;
@property(nonatomic)int sexTag;
@property(strong, nonatomic) UILabel *chooseLabel;
@property(assign, nonatomic) int currentPage;
@property(strong, nonatomic) UIView *chooseView;

-(void)setDelegate:(id)delegate;
-(void)chooseButtonClicked;
@end
