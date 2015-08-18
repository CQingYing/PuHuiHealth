//
//  FinishViewController.m
//  PuHui
//
//  Created by rp.wang on 15/7/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "FinishViewController.h"

@interface FinishViewController ()

@property (strong, nonatomic)  UIView *leftBtn;
@end

@implementation FinishViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"预约成功";
    // Do any additional setup after loading the view.
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    //self.mealLab.text=self.mealTyContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
