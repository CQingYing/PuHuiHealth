//
//  MainTabBarController.m
//  PuHui
//
//  Created by rp.wang on 15/7/2.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "MainTabBarController.h"
#import "HomePageController.h"
#import "PersonalCenterLoginController.h"
#import "PersonController.h"
#import "HealthStoreController.h"
#import "MainNavigationController.h"
#import "HealthKnowlegeController.h"

@interface MainTabBarController ()
@property (strong, nonatomic)  MainNavigationController *nav4;
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ccLoginTap) name:@"ccLogin" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ccLoginTap) name:@"mdfLogin" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ccLoginTap) name:@"unreadLogin" object:nil];
    //设置tabbar的背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    backView.backgroundColor = [UIColor blackColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    self.delegate=self;
    //字体颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.9];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    

    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    MainNavigationController *nav1 = [homeStoryboard instantiateInitialViewController];
    HomePageController *home = [nav1 viewControllers].firstObject;
    home.title=@"首页";
    [home.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [home.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    home.tabBarItem.image=[UIImage imageNamed:@"mainhome_wri"];
    home.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainhome"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //HealthKnowlegeController
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"HealthKnowlegeController" bundle:nil];
    HealthKnowlegeController *Consult=[sb instantiateInitialViewController];
    MainNavigationController *nav2 = [[MainNavigationController alloc] initWithRootViewController:Consult];
    Consult.title=@"健康知识";
    [Consult.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [Consult.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    Consult.tabBarItem.image=[UIImage imageNamed:@"mainhealth_wri"];
    Consult.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainDraftsZ"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    HealthStoreController *Store=[[HealthStoreController
                               alloc]init];
    MainNavigationController *nav3 = [[MainNavigationController alloc] initWithRootViewController:Store];
    Store.title=@"健康商城";
    [Store.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [Store.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    Store.tabBarItem.image=[UIImage imageNamed:@"ablum_wri"];
    Store.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainablum"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //新：个人中心(登陆/主界面）
    UIStoryboard  *sbLogin=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
    PersonalCenterLoginController *vcLogin=[sbLogin instantiateInitialViewController];
    
    UIStoryboard  *sbCenter=[UIStoryboard storyboardWithName:@"PersonController" bundle:nil];
    PersonController *vcCenter=[sbCenter instantiateInitialViewController];
    
    int  index=0;
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *strPhone=[user objectForKey:@"userIdz"];
    if (strPhone==nil||[strPhone isEqualToString:@""]) {
        index=1;
    }
    else{
        index=2;
    }
    
    
    if (index==1) {
       self.nav4 = [[MainNavigationController alloc] initWithRootViewController:vcLogin];
        vcLogin.navigationItem.title=@"登录";
        vcLogin.tabBarItem.title=@"个人中心";
    [vcLogin.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [vcLogin.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    vcLogin.tabBarItem.image=[UIImage imageNamed:@"mainperson_wri"];
    vcLogin.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainperson"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (index==2) {
       self.nav4 = [[MainNavigationController alloc] initWithRootViewController:vcCenter];
        
        vcCenter.title=@"个人中心";
        [vcCenter.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        [vcCenter.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
        vcCenter.tabBarItem.image=[UIImage imageNamed:@"mainperson_wri"];
        vcCenter.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainperson"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }

    self.viewControllers=@[nav1,nav2,nav3,self.nav4];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    
    
    int num = [tabBarController.viewControllers indexOfObject:viewController];
    if (num==3) {
        UIStoryboard  *sbLogin=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
        PersonalCenterLoginController *vcLogin=[sbLogin instantiateInitialViewController];
        UIStoryboard  *sbCenter=[UIStoryboard storyboardWithName:@"PersonController" bundle:nil];
        PersonController *vcCenter=[sbCenter instantiateInitialViewController];
        int  index=0;
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *strPhone=[user objectForKey:@"userIdz"];
        if (strPhone==nil||[strPhone isEqualToString:@""]) {
            index=1;
        }
        else{
            index=2;
        }
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.9];
        NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
        selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
        if (index==2) {
            self.nav4 = [[MainNavigationController alloc] initWithRootViewController:vcCenter];
            vcCenter.title=@"个人中心";
            [vcCenter.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
            [vcCenter.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
            vcCenter.tabBarItem.image=[UIImage imageNamed:@"mainperson_wri"];
            vcCenter.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainperson"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            NSArray *cons = [tabBarController viewControllers];
            NSMutableArray *newControllers = [[NSMutableArray alloc]init];
            [newControllers addObject:[cons objectAtIndex:0]];
            [newControllers addObject:[cons objectAtIndex:1]];
            [newControllers addObject:[cons objectAtIndex:2]];
            [newControllers addObject:self.nav4];
            [tabBarController setViewControllers:newControllers];
        }
        if (index==1) {
            self.nav4 = [[MainNavigationController alloc] initWithRootViewController:vcLogin];
            vcLogin.navigationItem.title=@"登录";
            vcLogin.tabBarItem.title=@"个人中心";
            [vcLogin.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
            [vcLogin.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
            vcLogin.tabBarItem.image=[UIImage imageNamed:@"mainperson_wri"];
            vcLogin.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainperson"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            NSArray *cons = [tabBarController viewControllers];
            NSMutableArray *newControllers = [[NSMutableArray alloc]init];
            [newControllers addObject:[cons objectAtIndex:0]];
            [newControllers addObject:[cons objectAtIndex:1]];
            [newControllers addObject:[cons objectAtIndex:2]];
            [newControllers addObject:self.nav4];
            [tabBarController setViewControllers:newControllers];
        }
    }
    NSLog(@"num:%d",num);
}
-(void)ccLoginTap{
    
    UIStoryboard  *sbLogin=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
    PersonalCenterLoginController *vcLogin=[sbLogin instantiateInitialViewController];
    UIStoryboard  *sbCenter=[UIStoryboard storyboardWithName:@"PersonController" bundle:nil];
    PersonController *vcCenter=[sbCenter instantiateInitialViewController];
    int  index=0;
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *strPhone=[user objectForKey:@"userIdz"];
    NSLog(@"#########################%@",strPhone);
    if (strPhone==nil||[strPhone isEqualToString:@""]) {
        index=1;
    }
    else{
        index=2;
    }
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.9];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    if (index==2) {
        self.nav4 = [[MainNavigationController alloc] initWithRootViewController:vcCenter];
        vcCenter.title=@"个人中心";
        [vcCenter.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        [vcCenter.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
        vcCenter.tabBarItem.image=[UIImage imageNamed:@"mainperson_wri"];
        vcCenter.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainperson"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSArray *cons = [self viewControllers];
        NSMutableArray *newControllers = [[NSMutableArray alloc]init];
        [newControllers addObject:[cons objectAtIndex:0]];
        [newControllers addObject:[cons objectAtIndex:1]];
        [newControllers addObject:[cons objectAtIndex:2]];
        [newControllers addObject:self.nav4];
        [self setViewControllers:newControllers];
    }
    if (index==1) {
        self.nav4 = [[MainNavigationController alloc] initWithRootViewController:vcLogin];
        vcLogin.navigationItem.title=@"登录";
        vcLogin.tabBarItem.title=@"个人中心";
        [vcLogin.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        [vcLogin.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
        vcLogin.tabBarItem.image=[UIImage imageNamed:@"mainperson_wri"];
        vcLogin.tabBarItem.selectedImage=[[UIImage imageNamed:@"mainperson"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSArray *cons = [self viewControllers];
        NSMutableArray *newControllers = [[NSMutableArray alloc]init];
        [newControllers addObject:[cons objectAtIndex:0]];
        [newControllers addObject:[cons objectAtIndex:1]];
        [newControllers addObject:[cons objectAtIndex:2]];
        [newControllers addObject:self.nav4];
        [self setViewControllers:newControllers];
    }
}
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title;
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] =[UIColor colorWithRed:1 green:1 blue:1 alpha:0.9];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
