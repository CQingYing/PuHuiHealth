//
//  HealthStoreController.h
//  PuHui
//
//  Created by rp.wang on 15/7/2.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "HealthStoreHeader.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "RequestServer.h"
#import "SetModel.h"
#import "UIImageView+WebCache.h"


@interface HealthStoreController : UIViewController<UITableViewDelegate,UITableViewDataSource,HealthStoreHeaderDelegate>

@property(strong, nonatomic)HealthStoreHeader *header;
@property(nonatomic)float headhigh;

@end
