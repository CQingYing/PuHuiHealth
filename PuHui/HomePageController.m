//
//  HomePageController.m
//  PuHui
//
//  Created by rp.wang on 15/7/2.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝 王超

#import "HomePageController.h"
#import "PersonageOrderController.h"
#import "MyQuestionController.h"
#import "TeamOrderController.h"
#import "BBRim.h"
#import "FriendConmendController.h"
#import "ReportCheckController.h"
#import "MBProgressHUD.h"
#import "NSString+Extension.h"
#import "PersonBaseInfoController.h"
#import "HomeModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "Reachability.h"
#import "RecommendController.h"
#import "SatisfiedViewController.h"
#import "MyOrderController.h"

@interface HomePageController ()

@property (strong, nonatomic)  UIScrollView *scroll;
@property (strong, nonatomic)  UIScrollView *mainScroll;
@property (strong, nonatomic)  UIPageControl *pagCtl;
@property (strong, nonatomic)  UIView *pagView;
@property (strong, nonatomic)  UIImageView *oneImgView;
@property (strong, nonatomic)  UIImageView *twoImgView;
@property (strong, nonatomic)  UIImageView *threeImgView;
@property (strong, nonatomic)  NSTimer *scrollTimer;
//六个按钮
@property (strong, nonatomic)  UIView *mainView;
@property (strong, nonatomic)  UIButton *postSearchBtn;
@property (strong, nonatomic)  UIButton *personOrderBtn;
@property (strong, nonatomic)  UIButton *bodySearchBtn;
@property (strong, nonatomic)  UIButton *friendRecommendBtn;
@property (strong, nonatomic)  UIButton *myQstBtn;
@property (strong, nonatomic)  UIButton *surveyBtn;
@property (assign,nonatomic)   CGFloat gap;
@property (assign,nonatomic)   CGFloat widBtn;
@property (assign,nonatomic)   CGFloat widScreen;


@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UIButton *personOrder;
@property (strong, nonatomic)  UIButton *teamOrder;

@property (strong, nonatomic)  UILabel *carLabel;
@property (strong, nonatomic)  UIImageView *leftImgView;
@property (strong, nonatomic)  UIImageView *rightImgView;

@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  NSMutableArray *arrysMuta;
@property (strong, nonatomic)  NSMutableArray *imgViewAry;
@property (assign,nonatomic)  int  nPage;
//@property (strong, nonatomic)  UIImageView *imgV;
@property (strong,nonatomic) Reachability *WIFIreach;

@property (strong, nonatomic)  UIView *notNet;
@property (strong, nonatomic)  UIImageView *notNetImg;
@property (strong, nonatomic)  UILabel *notNetLab;
@property (strong, nonatomic)  UIWindow *wins;

@end



@implementation HomePageController
//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
- (NSMutableArray *)imgViewAry
{
    if (!_imgViewAry) {
        _imgViewAry=[[NSMutableArray alloc]init];
    }
    return _imgViewAry;
}
- (UIScrollView *)mainScroll
{
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-49)];
    }
    return _mainScroll;
}
- (UIScrollView *)scroll
{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.width*185/375)];
    }
    return _scroll;
}

- (UIPageControl *)pagCtl
{
    if (!_pagCtl) {
        _pagCtl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.width*185/375-20, self.view.frame.size.width,20)];
        
        _pagCtl.numberOfPages=3;
        _pagCtl.currentPage=0;
        _pagCtl.backgroundColor=[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.5];
        _pagCtl.enabled=NO;
    }
    return _pagCtl;
}
//pagView
- (UIView *)pagView
{
    if (!_pagView) {
        _pagView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.width*185/375-20, self.view.frame.size.width,20)];
        _pagView.backgroundColor=[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.5];
    }
    return _pagView;
}
//home_selected   home_notelected
- (UIImageView *)oneImgView
{
    if (!_oneImgView) {
        _oneImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5-15, 7, 5,5)];
        _oneImgView.image=[UIImage imageNamed:@"home_selected"];
    }
    return _oneImgView;
}
- (UIImageView *)twoImgView
{
    if (!_twoImgView) {
        _twoImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5-2.5, 7, 5,5)];
        _twoImgView.image=[UIImage imageNamed:@"home_notelected"];
    }
    return _twoImgView;
}
- (UIImageView *)threeImgView
{
    if (!_threeImgView) {
        _threeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+10, 7, 5,5)];
        _threeImgView.image=[UIImage imageNamed:@"home_notelected"];
    }
    return _threeImgView;
}




- (UIView *)mainView
{
    if (!_mainView) {
        _mainView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.width*185/375, self.view.frame.size.width, self.view.frame.size.width*(0.5+0.0625*3))];
        _mainView.backgroundColor=[UIColor whiteColor];
        
    }
    return _mainView;
}
//六个按钮懒加载

- (UIButton *)postSearchBtn
{
    if (!_postSearchBtn) {
        _postSearchBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.gap, self.gap, self.widBtn, self.widBtn)];
        [_postSearchBtn setBackgroundImage:[UIImage imageNamed:@"icon_01"] forState:UIControlStateNormal];
        
        [_postSearchBtn setTitle:@"报告查看" forState:UIControlStateNormal];
        [_postSearchBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        _postSearchBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        _postSearchBtn.titleEdgeInsets=UIEdgeInsetsMake(30, 0, 0, 0);
        if (self.widScreen==414.0) {
            _postSearchBtn.titleLabel.font=[UIFont systemFontOfSize:13];
            _postSearchBtn.titleEdgeInsets=UIEdgeInsetsMake(40, 0, 0, 0);
        }
        
        if (self.widScreen==375.0) {
            _postSearchBtn.titleLabel.font=[UIFont systemFontOfSize:12];
            _postSearchBtn.titleEdgeInsets=UIEdgeInsetsMake(35, 0, 0, 0);
        }
    }
    return _postSearchBtn;
}

- (UIButton *)personOrderBtn
{
    if (!_personOrderBtn) {
        _personOrderBtn=[[UIButton alloc]initWithFrame:CGRectMake(2*self.gap+self.widBtn, self.gap, self.widBtn, self.widBtn)];
        [_personOrderBtn setBackgroundImage:[UIImage imageNamed:@"icon_02"] forState:UIControlStateNormal];
        
        [_personOrderBtn setTitle:@"个人定制" forState:UIControlStateNormal];
        [_personOrderBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        _personOrderBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        _personOrderBtn.titleEdgeInsets=UIEdgeInsetsMake(30, 0, 0, 0);
        if (self.widScreen==414.0) {
            _personOrderBtn.titleLabel.font=[UIFont systemFontOfSize:13];
            _personOrderBtn.titleEdgeInsets=UIEdgeInsetsMake(40, 0, 0, 0);
        }
        
        if (self.widScreen==375.0) {
            _personOrderBtn.titleLabel.font=[UIFont systemFontOfSize:12];
            _personOrderBtn.titleEdgeInsets=UIEdgeInsetsMake(35, 0, 0, 0);
        }
    }
    return _personOrderBtn;
}

- (UIButton *)bodySearchBtn
{
    if (!_bodySearchBtn) {
        _bodySearchBtn=[[UIButton alloc]initWithFrame:CGRectMake(3*self.gap+2*self.widBtn, self.gap, self.widBtn, self.widBtn)];
        [_bodySearchBtn setBackgroundImage:[UIImage imageNamed:@"home_order"] forState:UIControlStateNormal];
        
        [_bodySearchBtn setTitle:@"我的订单" forState:UIControlStateNormal];
        [_bodySearchBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        _bodySearchBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        _bodySearchBtn.titleEdgeInsets=UIEdgeInsetsMake(30, 0, 0, 0);
        if (self.widScreen==414.0) {
            _bodySearchBtn.titleLabel.font=[UIFont systemFontOfSize:13];
            _bodySearchBtn.titleEdgeInsets=UIEdgeInsetsMake(40, 0, 0, 0);
        }
        
        if (self.widScreen==375.0) {
            _bodySearchBtn.titleLabel.font=[UIFont systemFontOfSize:12];
            _bodySearchBtn.titleEdgeInsets=UIEdgeInsetsMake(35, 0, 0, 0);
        }
    }
    return _bodySearchBtn;
}

- (UIButton *)friendRecommendBtn
{
    if (!_friendRecommendBtn) {
        _friendRecommendBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.gap, 2*self.gap+self.widBtn, self.widBtn, self.widBtn)];
        [_friendRecommendBtn setBackgroundImage:[UIImage imageNamed:@"icon_04"] forState:UIControlStateNormal];
        
        [_friendRecommendBtn setTitle:@"好友推荐" forState:UIControlStateNormal];
        [_friendRecommendBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        _friendRecommendBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        _friendRecommendBtn.titleEdgeInsets=UIEdgeInsetsMake(30, 0, 0, 0);
        if (self.widScreen==414.0) {
            _friendRecommendBtn.titleLabel.font=[UIFont systemFontOfSize:13];
            _friendRecommendBtn.titleEdgeInsets=UIEdgeInsetsMake(40, 0, 0, 0);
        }
        
        if (self.widScreen==375.0) {
            _friendRecommendBtn.titleLabel.font=[UIFont systemFontOfSize:12];
            _friendRecommendBtn.titleEdgeInsets=UIEdgeInsetsMake(35, 0, 0, 0);
        }
    }
    return _friendRecommendBtn;
}

- (UIButton *)myQstBtn
{
    if (!_myQstBtn) {
        _myQstBtn=[[UIButton alloc]initWithFrame:CGRectMake(2*self.gap+self.widBtn, 2*self.gap+self.widBtn, self.widBtn, self.widBtn)];
        [_myQstBtn setBackgroundImage:[UIImage imageNamed:@"icon_05"] forState:UIControlStateNormal];
        
        [_myQstBtn setTitle:@"我的提问" forState:UIControlStateNormal];
        [_myQstBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        _myQstBtn.titleLabel.font=[UIFont systemFontOfSize:11];
        _myQstBtn.titleEdgeInsets=UIEdgeInsetsMake(30, 0, 0, 0);
        if (self.widScreen==414.0) {
            _myQstBtn.titleLabel.font=[UIFont systemFontOfSize:13];
            _myQstBtn.titleEdgeInsets=UIEdgeInsetsMake(40, 0, 0, 0);
        }
        
        if (self.widScreen==375.0) {
            _myQstBtn.titleLabel.font=[UIFont systemFontOfSize:12];
            _myQstBtn.titleEdgeInsets=UIEdgeInsetsMake(35, 0, 0, 0);
        }
    }
    return _myQstBtn;
}

- (UIButton *)surveyBtn
{
    if (!_surveyBtn) {
        _surveyBtn=[[UIButton alloc]initWithFrame:CGRectMake(3*self.gap+2*self.widBtn, 2*self.gap+self.widBtn, self.widBtn, self.widBtn)];
        [_surveyBtn setBackgroundImage:[UIImage imageNamed:@"icon_06"] forState:UIControlStateNormal];
        
        [_surveyBtn setTitle:@"满意度调查" forState:UIControlStateNormal];
        [_surveyBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        _surveyBtn.titleLabel.font=[UIFont systemFontOfSize:10];
        _surveyBtn.titleEdgeInsets=UIEdgeInsetsMake(30, 0, 0, 0);
        
        if (self.widScreen==414.0) {
            _surveyBtn.titleLabel.font=[UIFont systemFontOfSize:12];
            _surveyBtn.titleEdgeInsets=UIEdgeInsetsMake(40, 0, 0, 0);
        }
        
        if (self.widScreen==375.0) {
            _surveyBtn.titleLabel.font=[UIFont systemFontOfSize:11];
            _surveyBtn.titleEdgeInsets=UIEdgeInsetsMake(35, 0, 0, 0);
        }
    }
    return _surveyBtn;
}




// 底部两按钮（个人和团队预约）

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.width*185/375+self.view.frame.size.width*(0.5+0.0625*3), self.view.frame.size.width, 140)];
        _bottomView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        if(self.view.frame.size.width==414){
        
            _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.width*185/375+self.view.frame.size.width*(0.5+0.0625*3), self.view.frame.size.width, 195)];
            _bottomView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        }
        if(self.view.frame.size.width==375){
            
            _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.width*185/375+self.view.frame.size.width*(0.5+0.0625*3), self.view.frame.size.width, 172)];
            _bottomView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        }
        if(self.view.frame.size.height==568){
            _bottomView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.width*185/375+self.view.frame.size.width*(0.5+0.0625*3), self.view.frame.size.width, 140)];
            _bottomView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        }
    }
    return _bottomView;
}
- (UIButton *)personOrder
{
    if (!_personOrder) {
        _personOrder =[[UIButton alloc]initWithFrame:CGRectMake(15, 50, self.view.frame.size.width*0.5-15-10, 60)];
        
        if(self.view.frame.size.width==414){
            
             _personOrder =[[UIButton alloc]initWithFrame:CGRectMake(15, 100, self.view.frame.size.width*0.5-15-10, 80)];
        }
        if(self.view.frame.size.width==375){
            
            _personOrder =[[UIButton alloc]initWithFrame:CGRectMake(15, 90, self.view.frame.size.width*0.5-15-10, 70)];
        }
        if(self.view.frame.size.height==568){
            _personOrder =[[UIButton alloc]initWithFrame:CGRectMake(15, 70, self.view.frame.size.width*0.5-15-10, 60)];
        }
        

        
        
        [_personOrder setTitle:@"个人预约" forState:UIControlStateNormal];
        _personOrder.titleLabel.font=[UIFont systemFontOfSize:14];
        [_personOrder setTitleColor:[UIColor colorWithRed:132.0/255.0 green:186.0/255.0 blue:59.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        
        [_personOrder setBackgroundImage:[UIImage imageNamed:@"home_btnframe"] forState:UIControlStateNormal];
        [_personOrder setImage:[UIImage imageNamed:@"home_individual"] forState:UIControlStateNormal];
        [_personOrder setTitleEdgeInsets:UIEdgeInsetsMake(0, -(self.view.frame.size.width*0.5-25)/1.7, 0, 0)];
        [_personOrder setImageEdgeInsets:UIEdgeInsetsMake(0, (self.view.frame.size.width*0.5-25)/1.8, 0, 0)];
        if (self.widScreen==414.0) {
            [_personOrder setTitleEdgeInsets:UIEdgeInsetsMake(0, -(self.view.frame.size.width*0.5-25)/2, 0, 0)];
            [_personOrder setImageEdgeInsets:UIEdgeInsetsMake(0, (self.view.frame.size.width*0.5-25)/1.75, 0, 0)];
        }
    }
    return _personOrder;
}
- (UIButton *)teamOrder
{
    if (!_teamOrder) {
        _teamOrder =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+10, 50, self.view.frame.size.width*0.5-15-10, 60)];
        
        
        if(self.view.frame.size.width==414){
             _teamOrder =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+10, 100, self.view.frame.size.width*0.5-15-10, 80)];
        }
        if(self.view.frame.size.width==375){
             _teamOrder =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+10, 90, self.view.frame.size.width*0.5-15-10, 70)];
        }
        if(self.view.frame.size.height==568){
            _teamOrder =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+10, 70, self.view.frame.size.width*0.5-15-10, 60)];
        }
        
        [_teamOrder setTitle:@"团体预约" forState:UIControlStateNormal];
        _teamOrder.titleLabel.font=[UIFont systemFontOfSize:14];
        [_teamOrder setTitleColor:[UIColor colorWithRed:132.0/255.0 green:186.0/255.0 blue:59.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_teamOrder setBackgroundImage:[UIImage imageNamed:@"home_btnframe"] forState:UIControlStateNormal];
        [_teamOrder setImage:[UIImage imageNamed:@"home_group"] forState:UIControlStateNormal];
        [_teamOrder setTitleEdgeInsets:UIEdgeInsetsMake(0, -(self.view.frame.size.width*0.5-25)/1.7, 0, 0)];
        [_teamOrder setImageEdgeInsets:UIEdgeInsetsMake(0, (self.view.frame.size.width*0.5-25)/1.8, 0, 0)];
        if (self.widScreen==414.0) {
            [_teamOrder setTitleEdgeInsets:UIEdgeInsetsMake(0, -(self.view.frame.size.width*0.5-25)/2, 0, 0)];
            [_teamOrder setImageEdgeInsets:UIEdgeInsetsMake(0, (self.view.frame.size.width*0.5-25)/1.75, 0, 0)];
        }
    }
    return _teamOrder;
}
//carLabel leftImgView  rightImgView

- (UILabel *)carLabel
{
    if (!_carLabel) {
        _carLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5-40, 18, 80, 20)];
        
        
        if(self.view.frame.size.width==414){
           _carLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5-40, 58, 80, 20)];
        }
        if(self.view.frame.size.width==375){
           _carLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5-40, 48, 80, 20)];
        }
        if(self.view.frame.size.height==568){
         _carLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5-40, 28, 80, 20)];
        }
        
        _carLabel.text=@"预约直通车";
        _carLabel.font=[UIFont systemFontOfSize:12];
        _carLabel.textAlignment=NSTextAlignmentCenter;
        _carLabel.textColor=[UIColor grayColor];
    }
    return _carLabel;
}

- (UIImageView *)leftImgView
{
    if (!_leftImgView) {
        _leftImgView=[[UIImageView alloc]initWithFrame:CGRectMake(16, 28, self.view.frame.size.width*0.5-56, 1)];
        
        if(self.view.frame.size.width==414){
        _leftImgView=[[UIImageView alloc]initWithFrame:CGRectMake(16, 68, self.view.frame.size.width*0.5-56, 1)];
        }
        if(self.view.frame.size.width==375){
        _leftImgView=[[UIImageView alloc]initWithFrame:CGRectMake(16, 58, self.view.frame.size.width*0.5-56, 1)];
        }
        if(self.view.frame.size.height==568){
        _leftImgView=[[UIImageView alloc]initWithFrame:CGRectMake(16, 38, self.view.frame.size.width*0.5-56, 1)];
        }
        
        _leftImgView.image=[UIImage imageNamed:@"line1"];
    }
    return _leftImgView;
}
- (UIImageView *)rightImgView
{
    if (!_rightImgView) {
        _rightImgView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+40, 28, self.view.frame.size.width*0.5-56, 1)];
        
        
        if(self.view.frame.size.width==414){
        _rightImgView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+40, 68, self.view.frame.size.width*0.5-56, 1)];
        }
        if(self.view.frame.size.width==375){
        _rightImgView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+40, 58, self.view.frame.size.width*0.5-56, 1)];
        }
        if(self.view.frame.size.height==568){
        _rightImgView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.5+40, 38, self.view.frame.size.width*0.5-56, 1)];
        }
        _rightImgView.image=[UIImage imageNamed:@"line1"];
    }
    return _rightImgView;//251 238 185
}
// notNet;
// @property (strong, nonatomic)  UIImageView *notNetImg;
// @property (strong, nonatomic)  UILabel *notNetLab;
- (UIView *)notNet
{
    if (!_notNet) {
        _notNet=[[UIView alloc]initWithFrame:CGRectMake(8, 67, self.view.frame.size.width-16, 40)];
        _notNet.backgroundColor=[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.5];
        BBRim *rims=[[BBRim alloc]init];
        [rims bb_rimWithView:_notNet radius:3 width:1 color:[UIColor clearColor]];
    }
    return _notNet;
}

- (UIImageView *)notNetImg
{
    if (!_notNetImg) {
        _notNetImg=[[UIImageView alloc]init];
    }
    return _notNetImg;
}

- (UILabel *)notNetLab
{
    if (!_notNetLab) {
        _notNetLab=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-116)*0.5, 2, 100, 36)];
       // _notNetLab.backgroundColor=[UIColor greenColor];
        _notNetLab.text=@"请检查网络!";
        _notNetLab.textColor=[UIColor whiteColor];
        [_notNetLab setTextAlignment:NSTextAlignmentCenter];
    }
    return _notNetLab;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self showState];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**网络监听开始*/
    //初始化
    self.WIFIreach = [Reachability reachabilityForInternetConnection];
    //或者：self.WIFIreach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    //开始监听,会启动一个run loop
    [self.WIFIreach startNotifier];
    
    //接收网络环境变化的通知  消息名称（固定）为：kReachabilityChangedNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.wins= [[UIApplication sharedApplication].windows lastObject];
    [self.wins addSubview:self.notNet];
    [self.notNet addSubview:self.notNetLab];
    self.notNet.hidden=YES;
    /**网络监听结束*/
    
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    self.gap=self.view.frame.size.width*0.0625;
    self.widBtn=self.view.frame.size.width*0.25;
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    self.widScreen= size.width;
    
    [self.view addSubview:self.mainScroll];
    [self.mainScroll addSubview:self.scroll];
    [self.mainScroll addSubview:self.pagView];
    [self.mainScroll addSubview:self.bottomView];
    [self.mainScroll addSubview:self.mainView];
    [self.mainView addSubview:self.postSearchBtn];
    [self.mainView addSubview:self.myQstBtn];
    [self.mainView addSubview:self.personOrderBtn];
    [self.mainView addSubview:self.bodySearchBtn];
    [self.mainView addSubview:self.friendRecommendBtn];
    [self.mainView addSubview:self.surveyBtn];
    
    [self.bottomView addSubview:self.personOrder];
    [self.bottomView addSubview:self.teamOrder];
    [self.bottomView addSubview:self.carLabel];
    [self.bottomView addSubview:self.leftImgView];
    [self.bottomView addSubview:self.rightImgView];
    
    [self loadData];
    // 按钮点击事件
    [self setBtnAddTarget];
    //数据请求
    [self setHomeInfo];
    
}
/**网络状态改变开始  */
-(void) reachabilityChanged :(NSNotification *) notification
{
    Reachability *curr = [notification object];
    if ([curr isMemberOfClass:[Reachability class]]) {
        [self showState];
    }
}

-(void) showState
{
    //检查当前网络状态
    Reachability *currentReachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NetworkStatus state = [currentReachability currentReachabilityStatus];
    switch (state) {
        case NotReachable :
           // self.notNet.hidden=NO;
            break;
        case ReachableViaWiFi :
           // self.notNet.hidden=YES;
            
            break;
        case ReachableViaWWAN :
           // self.notNet.hidden=YES;
            break;
    }
}
/**展现网络结束*/

-(void)notNetLoad{
        self.mainScroll.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.width*185/375+self.view.frame.size.width*(0.5+0.0625*3)+120);
        float wid=self.scroll.frame.size.width;
        float hei=self.scroll.frame.size.height;
    
        self.scroll.bounces = NO;
        //self.scroll.contentSize=CGSizeMake(3*wid,hei);
        self.scroll.pagingEnabled = YES;
        self.scroll.showsHorizontalScrollIndicator = NO;
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, wid, hei)];
            img.contentMode = UIViewContentModeScaleToFill;
            img.image=[UIImage imageNamed:@"questionAccept"];
            [self.scroll addSubview:img];
       
}
-(void)loadData{
    self.mainScroll.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.width*185/375+self.view.frame.size.width*(0.5+0.0625*3)+120);
    float wid=self.scroll.frame.size.width;
    float hei=self.scroll.frame.size.height;
    
    self.scroll.bounces = NO;
    self.scroll.contentSize=CGSizeMake(self.arrysMuta.count*wid,hei);
    self.scroll.pagingEnabled = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i<self.arrysMuta.count; i++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*wid,0, wid, hei)];
        img.contentMode = UIViewContentModeScaleAspectFill;
        HomeModel *homeMo=self.arrysMuta[i];
        NSString *tempStr=[PHJKRequestUrl stringByAppendingString:homeMo.pic];//home_photo
        [img sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"home_photo"]];
        img.userInteractionEnabled=YES;
        UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taps)];
        [img addGestureRecognizer:ges];
        [self.scroll addSubview:img];
    }
    self.scroll.delegate=self;
   
}
//加载轮播图片 并且开始轮播
-(void)loadDatas{
    [self loadData];
    //加载小点图片
    [self loadImgBtnAry];
    //自动轮播
     self.scrollTimer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}
-(void)loadImgBtnAry{
    int counts=self.arrysMuta.count;
    float wids=counts*5+(counts-1)*8.0;
    for (int i=0; i<counts; i++) {
        UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-wids)*0.5+i*13, 7, 5, 5)];
        imgV.image=[UIImage imageNamed:@"home_notelected"];
        if (i==0) {
           imgV.image=[UIImage imageNamed:@"home_selected"];
        }
        imgV.tag=33+i;
        [self.pagView addSubview:imgV];
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.nPage=page;
    UIImageView * temp = [self.view viewWithTag:33+page];
    temp.image=[UIImage imageNamed:@"home_selected"];
    
    for(int i=33;i<self.arrysMuta.count+33;i++){
        if(i!=(33+page)){
            
        UIImageView * temps = [self.view viewWithTag:i];
            temps.image=[UIImage imageNamed:@"home_notelected"];
        }
    }
}
-(void)autoScroll{
    CGFloat scrollviewW=self.scroll.frame.size.width;
    CGFloat offset=self.scroll.contentOffset.x+scrollviewW;
    int cou=self.arrysMuta.count-1;
    if (offset>self.scroll.frame.size.width*cou) {
        offset=0.0;
    }
    [self.scroll scrollRectToVisible:CGRectMake(offset, 0.0, self.view.frame.size.width, self.view.frame.size.width*185/375) animated:YES];
}
-(void)taps{
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
        WebViewController *webViewController=[sb instantiateViewControllerWithIdentifier:@"WebViewController"];
        HomeModel *infos=self.arrysMuta[self.nPage];
        webViewController.nPage=self.nPage;
        webViewController.URLCon=infos.url;
        [self.navigationController pushViewController:webViewController animated:YES];
}

/**
 *  首页轮播咨询请求
 *
 */
- (void)setHomeInfo
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    NSString *userAccountz=[user objectForKey:@"userAccountz"];
    NSString *userPwdz=[user objectForKey:@"userPwdz"];
    NSLog(@"**************%@",userIdz);
    NSLog(@"**************%@",userAccountz);
    NSLog(@"**************%@",userPwdz);
    
    if (userAccountz==nil||[userAccountz isEqualToString:@""]) {
        userIdz=@"";
        userAccountz=@"";
        userPwdz=@"";
    }
    [RequestServer fetchMethodName:@"newsList" parameters:@{@"userId":@"22",@"userAccount":@"4",@"userPwd":userPwdz} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
       
        NSString *str=responseDic[@"retCode"];
        NSString *retMsg=responseDic[@"retMsg"];
        if ([str isEqualToString:@"0"]) {
             NSArray *ary=responseDic[@"data"];
            for (NSDictionary *dic in ary) {
                HomeModel *homeMoel=[HomeModel objectWithKeyValues:dic];
                [self.arrysMuta addObject:homeMoel];
            }
             [self loadDatas];
        }else{
            [self showAllTextDialog:retMsg];
            [self loadDatas];
        }
      
       
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        [self notNetLoad];
        //[self  showAllTextDialog:@"网络链接失败,请检查网络!"];
        
    }];
}



/*
 addTarget方法
 */
-(void)setBtnAddTarget{
    //ReportCheckController
    [self.postSearchBtn addTarget:self action:@selector(postSearchTap) forControlEvents:UIControlEventTouchUpInside];
    [self.friendRecommendBtn addTarget:self action:@selector(friendRecommendTap) forControlEvents:UIControlEventTouchUpInside];
    //个人定制
    [self.personOrderBtn addTarget:self action:@selector(personOrderTaps) forControlEvents:UIControlEventTouchUpInside];
    [self.myQstBtn addTarget:self action:@selector(myQstBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [self.personOrder addTarget:self action:@selector(personOrderTap) forControlEvents:UIControlEventTouchUpInside];
    [self.teamOrder addTarget:self action:@selector(teamOrderTap) forControlEvents:UIControlEventTouchUpInside];
    [self.surveyBtn addTarget:self action:@selector(surveyBtnTap) forControlEvents:UIControlEventTouchUpInside];
    [self.bodySearchBtn addTarget:self action:@selector(bodySearchTap) forControlEvents:UIControlEventTouchUpInside];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/*
 按钮的点击事件
 */
-(void)postSearchTap{
    UIStoryboard  *reportCheckSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    ReportCheckController *reportCheckCon=[reportCheckSB instantiateViewControllerWithIdentifier:@"ReportCheckController"];
    reportCheckCon.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:reportCheckCon animated:YES];
}
-(void)bodySearchTap{
    MyOrderController *MyOrderCont=[[MyOrderController alloc]init];
    [self.navigationController pushViewController:MyOrderCont animated:YES];
}
-(void)friendRecommendTap{
    UIStoryboard  *recommendSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    FriendConmendController *recommendController=[recommendSB instantiateViewControllerWithIdentifier:@"FriendConmendController"];
    recommendController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:recommendController animated:YES];
}
-(void)personOrderTaps{
    UIStoryboard  *personModelSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    PersonBaseInfoController *personBaseInfoController=[personModelSB instantiateViewControllerWithIdentifier:@"PersonBaseInfoController"];
    personBaseInfoController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:personBaseInfoController animated:YES];
}

-(void)personOrderTap{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    
    if (userIdz==nil||[userIdz isEqualToString:@""]) {
        
        //跳转到个人中心
        self.tabBarController.selectedIndex=3;
        [self performSelector:@selector(boun) withObject:nil afterDelay:0.5];
       
        return;
    }
    
    UIStoryboard  *personOrder=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    PersonageOrderController *personageOrderController=[personOrder instantiateViewControllerWithIdentifier:@"PersonageOrderController"];
    personageOrderController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:personageOrderController animated:YES];
    
}
-(void)boun{
    //发送消息
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"回调到首页" forKey:@"temp"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"change" object:self userInfo:dic];
}
-(void)teamOrderTap{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];

    
    if (userIdz==nil||[userIdz isEqualToString:@""]) {
        
        //跳转到个人中心
        self.tabBarController.selectedIndex=3;
        [self performSelector:@selector(boun) withObject:nil afterDelay:0.5];
        
        return;
    }
    
    UIStoryboard  *teamOrderSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    TeamOrderController *teamOrderController=[teamOrderSB instantiateViewControllerWithIdentifier:@"TeamOrderController"];
    teamOrderController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:teamOrderController animated:YES];
}

-(void)myQstBtnTap{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    
    
    if (userIdz==nil||[userIdz isEqualToString:@""]) {
        
        //跳转到个人中心
        self.tabBarController.selectedIndex=3;
        [self performSelector:@selector(boun) withObject:nil afterDelay:0.5];
        
        return;
    }
    UIStoryboard  *myQuestionSB=[UIStoryboard storyboardWithName:@"MyQuestionController" bundle:nil];
    MyQuestionController *myQuestionController=[myQuestionSB instantiateInitialViewController];
    myQuestionController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:myQuestionController animated:YES];
}

- (void)surveyBtnTap {
    SatisfiedViewController *svc = [[SatisfiedViewController alloc] init];
    [svc.view setBackgroundColor:[UIColor whiteColor]];
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)showAllTextDialog:(NSString *)str{
    UIWindow *win=[[UIApplication sharedApplication].windows lastObject];
    self.HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.mode = MBProgressHUDModeText;
    [win addSubview:self.HUD];
    //self.HUD.dimBackground = YES;
    self.HUD.labelText = str;
    [self.HUD hide:YES afterDelay:2];
    self.HUD.removeFromSuperViewOnHide = YES;
}

@end
