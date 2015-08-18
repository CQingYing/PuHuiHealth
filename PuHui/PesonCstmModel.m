//
//  PesonCstmModel.m
//  PuHui
//
//  Created by rp.wang on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PesonCstmModel.h"
#import "MJExtension.h"
#import "PersonModel.h"
#import "SubSelectors.h"

@implementation PesonCstmModel


-(NSMutableArray *)getPerCstmModel {
    // Do any additional setup after loading the view.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PersonageCustomization" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);
    NSArray *infor=data[@"PageItems"];
    for (NSDictionary *dic in infor) {
        PersonModel *perModel=[PersonModel objectWithKeyValues:dic];
        [self.arrysMuta addObject:perModel];
    }
    return self.arrysMuta;
}

@end
