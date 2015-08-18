//
//  PersonModelController.m
//  PuHui
//
//  Created by rp.wang on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonModelController.h"
#import "MJExtension.h"
#import "PersonModel.h"
#import "SubSelectors.h"
#import "PesonCstmModel.h"

@interface PersonModelController ()
@property (strong, nonatomic)  NSMutableArray *arrysMuta;
@end

@implementation PersonModelController
//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PersonageCustomization" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);
    NSArray *infor=data[@"PageItems"];
    for (NSDictionary *dic in infor) {
        PersonModel *perModel=[PersonModel objectWithKeyValues:dic];
        [self.arrysMuta addObject:perModel];
    }

    PersonModel *perModelSING=self.arrysMuta[0];
    NSString *str= perModelSING.Selectors.Dselector;
    NSLog(@"!!!!!!!!!!!!!!!!!!!!%@",str);
    
    
    PersonModel *perModelSINGs=self.arrysMuta[3];
    NSString *strs= perModelSINGs.Selectors.Dselector;
    NSLog(@"!!!!!!!!!!!!!!!!!!!!%@",strs);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
