//
//  MainNavigationController.m
//  PuHui
//
//  Created by rp.wang on 15/7/2.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝 王超

#import "MainNavigationController.h"
#import "PersonController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置所有navigationBar的颜色
    UINavigationBar *navBar=[UINavigationBar appearance];
    navBar.tintColor = navbarLeftItemColor;
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home"] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
        rightItem.tintColor = [UIColor orangeColor];
        viewController.navigationItem.rightBarButtonItem = rightItem;
        self.navigationBarHidden = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 

#pragma mark 点击rightItem
-(void)rightClick
{
    [self popToRootViewControllerAnimated:YES];
}

@end
