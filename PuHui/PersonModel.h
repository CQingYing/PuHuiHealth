//
//  PersonModel.h
//  PuHui
//
//  Created by rp.wang on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubSelectors.h"
@interface PersonModel : NSObject
@property (strong, nonatomic)  NSString *Title;
@property (strong, nonatomic)  NSString *TypeTxt;
@property (strong, nonatomic)  SubSelectors *Selectors;


@end
