//
//  RecommendController.m
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "RecommendController.h"
#import "InternalReconmmendControlller.h"
#import "ReconmmendHistoryController.h"
#import "BBRim.h"

#import "SelectSetMealController.h"
#import "RecomMealModel.h"
#import "RecommendHistoryCell.h"


#import "JKAlertDialog.h"
#import "NSObject+MJKeyValue.h"
#import "NSObject+MJMember.h"
#import "SelectSetMealCell.h"
#import <MessageUI/MessageUI.h>
#import "NSString+Extension.h"
#import "InternalRecmCell.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "RecodHistoryInfo.h"


@interface RecommendController () <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *reconmmentSeg;
@property (strong, nonatomic)  InternalReconmmendControlller *inRcmControlller;
@property (strong, nonatomic)  ReconmmendHistoryController *rcmHistoryController;
@property (strong, nonatomic)  UIButton *leftBtn;

@property (strong, nonatomic)  UIScrollView *scroll;
@property (strong, nonatomic)  UIView *oneView;
@property (strong, nonatomic)  UIView *twoView;
@property (strong, nonatomic)  UIView *sub1View;
@property (strong, nonatomic)  UIImageView *img1;
@property (strong, nonatomic)  UITextField *txtFid1;

@property (strong, nonatomic)  UIView *sub2View;
@property (strong, nonatomic)  UIImageView *img2;
@property (strong, nonatomic)  UITextField *txtFid2;

@property (strong, nonatomic)  UIView *sub3View;
@property (strong, nonatomic)  UIImageView *img3;
@property (strong, nonatomic)  UILabel *txt3;
@property (strong, nonatomic)  UIButton *btn3;

@property (strong, nonatomic) UITableView *slectMeal;
@property (strong, nonatomic) JKAlertDialog *myAlert;
@property (strong, nonatomic)  MBProgressHUD *HUD;


@property (strong, nonatomic) NSString * mealNamez;
@property (assign, nonatomic) NSString * pacgID;
@property (assign, nonatomic) NSString * retailz;
@property (assign, nonatomic) NSString * costz;

@property (strong, nonatomic)  UILabel *mealLab;
@property (strong, nonatomic)  UILabel *femaLab;
@property (strong, nonatomic)  UIImageView *mealImg;
@property (strong, nonatomic)  UIImageView *femaImg;
@property (strong, nonatomic)  UIButton * reconBtn;
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic) NSMutableArray *arrysMutas;
@property (strong, nonatomic)  NSString * isManSex;


@property (strong, nonatomic) UITableView *historyTabView;
@property (strong, nonatomic) UIView *historyView;
@property (assign,nonatomic)  int pageCount;
@property (strong, nonatomic) NSString *codesz;
@property (strong, nonatomic) NSString *namez;


@property (strong, nonatomic)  UILabel *lab1;
@property (strong, nonatomic)  UILabel *lab0;
@property (strong, nonatomic)  UILabel *lab2;

@end

@implementation RecommendController
//懒加载
//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
//*模型数据*/
- (NSMutableArray *)arrysMutas
{
    if (!_arrysMutas) {
        _arrysMutas=[[NSMutableArray alloc]init];
    }
    return _arrysMutas;
}
//懒加载InternalReconmmendControlller/ReconmmendHistoryController
- (UIScrollView *)scroll
{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 110, self.view.frame.size.width-16, self.view.frame.size.height-116)];
       // _scroll.backgroundColor=[UIColor redColor];
    }
    return _scroll;
}

- (UIView *)historyView
{
    if (!_historyView) {
        _historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height-116)];
    }
    return _historyView;
}
- (UITableView *)historyTabView
{
    if (!_historyTabView) {
        _historyTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-116)];
    }
    return _historyTabView;
}
- (UIView *)oneView
{
    if (!_oneView) {
        _oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-16, 16+43+16+43+16+43+20+50)];
        _oneView.backgroundColor=[UIColor whiteColor];
      
    }
    return _oneView;
}
- (UIView *)twoView
{
    if (!_twoView) {
        _twoView = [[UIView alloc] initWithFrame:CGRectMake(0, 16+43+16+43+16+43+20+60, self.view.frame.size.width-16, 150)];
        _twoView.backgroundColor=[UIColor whiteColor];
        
    }
    return _twoView;
}

- (UILabel *)lab0
{
    if (!_lab0) {
        _lab0 = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width-16-16, 25)];
        _lab0.text=@"优惠政策";
        _lab0.font=[UIFont systemFontOfSize:19];
    }
    return _lab0;
}
- (UILabel *)lab1
{
    if (!_lab1) {
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(16, 8+25, self.view.frame.size.width-16-16-8, 40)];
        _lab1.text=@"1.“内部推荐”是为受保护客户开通的健康专享计划。";
        _lab1.numberOfLines=0;
        _lab1.font=[UIFont systemFontOfSize:14];
    }
    return _lab1;
}
- (UILabel *)lab2
{
    if (!_lab2) {
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 8+25+40, self.view.frame.size.width-16-16-8, 40)];
        _lab2.text=@"2.仅授权的服务人员持有“推荐终端”并且享有“推荐权”。";
        _lab2.numberOfLines=0;
        _lab2.font=[UIFont systemFontOfSize:14];
    }
    return _lab2;
}

- (UIView *)sub1View
{
    if (!_sub1View) {
        _sub1View = [[UIView alloc] initWithFrame:CGRectMake(8, 16, 214, 43)];
       // _sub1View.backgroundColor=[UIColor greenColor];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_sub1View radius:3 width:1 color:[UIColor grayColor]];
        
    }
    return _sub1View;
}
- (UIView *)sub2View
{
    if (!_sub2View) {
        _sub2View = [[UIView alloc] initWithFrame:CGRectMake(8, 16+43+16, 214, 43)];
       // _sub2View.backgroundColor=[UIColor greenColor];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_sub2View radius:3 width:1 color:[UIColor grayColor]];
    }
    return _sub2View;
}
- (UIView *)sub3View
{
    if (!_sub3View) {
        _sub3View = [[UIView alloc] initWithFrame:CGRectMake(8, 16+43+16+43+16, 214, 43)];
        //_sub3View.backgroundColor=[UIColor greenColor];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_sub3View radius:3 width:1 color:[UIColor grayColor]];
    }
    return _sub3View;
}
- (UIButton *)btn3
{
    if (!_btn3) {
        _btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 214, 43)];
        [_btn3 addTarget:self action:@selector(btn3Tap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}


- (UIImageView *)img1
{
    if (!_img1) {
        _img1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 20, 23)];
        _img1.image=[UIImage imageNamed:@"inrcm_name"];
    }
    return _img1;
}
- (UITextField *)txtFid1
{
    if (!_txtFid1) {
        _txtFid1 = [[UITextField alloc] initWithFrame:CGRectMake(16+8+20, 8, 214-16+8+20, 30)];
        _txtFid1.placeholder=@"被推荐人姓名";
    }
    return _txtFid1;
}
- (UIImageView *)img2
{
    if (!_img2) {
        _img2 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 9, 16, 25)];
        _img2.image=[UIImage imageNamed:@"inrcm_phone"];
    }
    return _img2;
}
- (UITextField *)txtFid2
{
    if (!_txtFid2) {
        _txtFid2 = [[UITextField alloc] initWithFrame:CGRectMake(214-172, 8, 172, 30)];
        _txtFid2.placeholder=@"被推荐人电话";
    }
    return _txtFid2;
}
- (UILabel *)txt3
{
    if (!_txt3) {
        _txt3 = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 214-28-8, 21)];
        _txt3.text=@"套餐选择";
    }
    return _txt3;
}
- (UIImageView *)img3
{
    if (!_img3) {
        _img3 = [[UIImageView alloc] initWithFrame:CGRectMake(214-28+2, 18, 14, 8)];
        _img3.image=[UIImage imageNamed:@"inrcm_downarrow"];
    }
    return _img3;
}

- (UIImageView *)mealImg
{
    if (!_mealImg) {
        _mealImg = [[UIImageView alloc] initWithFrame:CGRectMake(8+26+8, 16+43+16+43+16+43+20, 25, 25)];
        _mealImg.image=[UIImage imageNamed:@"inrcm_select"];
    }
    return _mealImg;
}
- (UIImageView *)femaImg
{
    if (!_femaImg) {
        _femaImg = [[UIImageView alloc] initWithFrame:CGRectMake(8+26+8+25+10+26+8, 16+43+16+43+16+43+20, 25, 25)];
        _femaImg.image=[UIImage imageNamed:@"inrcm_notselect"];
    }
    return _femaImg;
}

- (UIButton *)reconBtn
{
    if (!_reconBtn) {
        _reconBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-71-8-16, 16+43+16+43+10+43+20, 71, 34)];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_reconBtn radius:4 width:1 color:[UIColor orangeColor]];
        [_reconBtn setTitle:@"推荐" forState:UIControlStateNormal];
        [_reconBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_reconBtn addTarget:self action:@selector(reconTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reconBtn;
}

- (UILabel *)mealLab
{
    if (!_mealLab) {
        _mealLab = [[UILabel alloc] initWithFrame:CGRectMake(8, 16+43+16+43+16+43+20, 26, 21)];
        _mealLab.text=@"男";
    }
    return _mealLab;
}
- (UILabel *)femaLab
{
    if (!_femaLab) {
        _femaLab = [[UILabel alloc] initWithFrame:CGRectMake(8+26+8+25+10, 16+43+16+43+16+43+20, 26, 21)];
        _femaLab.text=@"女";
    }
    return _femaLab;
}


- (InternalReconmmendControlller *)inRcmControlller
{
    if (!_inRcmControlller) {
        UIStoryboard *inRcmControlllerSB=[UIStoryboard storyboardWithName:@"InternalReconmmendControlller" bundle:nil];
        _inRcmControlller= [inRcmControlllerSB instantiateInitialViewController];
        _inRcmControlller.view.frame = CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height-110);
    }
    return _inRcmControlller;
}
- (ReconmmendHistoryController *)rcmHistoryController
{
    if (!_rcmHistoryController) {
        _rcmHistoryController = [[ReconmmendHistoryController alloc]init];
        _rcmHistoryController.view.frame =  CGRectMake(0, 110, self.view.frame.size.width, self.view.frame.size.height-110);
    }
    return _rcmHistoryController;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
-(void)initBases{
    [self.view addSubview:self.scroll];
    self.scroll.contentSize=CGSizeMake(self.view.frame.size.width-16, 500);
    [self.scroll addSubview:self.oneView];
    [self.oneView addSubview:self.sub1View];
    [self.sub1View addSubview:self.img1];
    [self.sub1View addSubview:self.txtFid1];
    [self.oneView addSubview:self.sub2View];
    [self.sub2View addSubview:self.img2];
    [self.sub2View addSubview:self.txtFid2];
    
    [self.oneView addSubview:self.sub3View];
    [self.sub3View addSubview:self.txt3];
    [self.sub3View addSubview:self.img3];
    [self.sub3View addSubview:self.btn3];
    
    [self.oneView addSubview:self.mealLab];
    [self.oneView addSubview:self.femaLab];
    [self.oneView addSubview:self.mealImg];
    [self.oneView addSubview:self.femaImg];
    [self.oneView addSubview:self.reconBtn];
    
    [self.scroll addSubview:self.twoView];
    [self.twoView addSubview:self.lab0];
    [self.twoView addSubview:self.lab1];
    [self.twoView addSubview:self.lab2];
    
    self.slectMeal=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 270, 1000) style:UITableViewStylePlain];
    self.slectMeal.delegate=self;
    self.slectMeal.dataSource=self;
    
    
    self.historyTabView.delegate=self;
    self.historyTabView.dataSource=self;
    
    
    
    
    [self.view addSubview:self.scroll];
    self.scroll.contentSize=CGSizeMake(self.view.frame.size.width-16, 500);
    [self.scroll addSubview:self.oneView];
    
    
    [self.view addSubview:self.historyView];
    [self.historyView  addSubview:self.historyTabView];
    self.historyView.hidden=YES;
    
    self.pageCount=0;
    [self setupRefresh];
  // [self recommHisDatas];
}
- (void)setupRefresh
{
    // 下拉刷新
    [self.historyTabView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 上拉加载
    
    [self.historyTabView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    
}

#pragma mark 下拉
- (void)headerRereshing
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *appuseridz=[user objectForKey:@"appuseridz"];
    NSString *orgidz=[user objectForKey:@"orgidz"];
    [RequestServer fetchMethodName:@"find_app_serv_record_By_userId" parameters:@{
       @"app_serv_record.appuser_id":appuseridz,
       @"pageIndex":@"0"} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"app_serv_record_list"];
        self.arrysMutas=nil;
        for (NSDictionary *dict  in inforArys) {
            RecodHistoryInfo *meals=[RecodHistoryInfo objectWithKeyValues:dict];
            [self.arrysMutas addObject:meals];
        }
        [self.historyTabView reloadData];
        [self.historyTabView headerEndRefreshing];
        self.pageCount=0;
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}


#pragma mark  上啦
- (void)footerRereshing
{
    self.pageCount++;
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *appuseridz=[user objectForKey:@"appuseridz"];
    NSString *orgidz=[user objectForKey:@"orgidz"];
    [RequestServer fetchMethodName:@"find_app_serv_record_By_userId" parameters:@{@"app_serv_record.appuser_id":appuseridz,@"pageIndex":[NSString stringWithFormat:@"%d",self.pageCount]} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"app_serv_record_list"];
        for (NSDictionary *dict  in inforArys) {
            RecodHistoryInfo *meals=[RecodHistoryInfo objectWithKeyValues:dict];
           // [self.arrysMuta addObject:meals];
            [self.arrysMutas insertObject:meals atIndex:self.arrysMutas.count];
        }
        [self.historyTabView reloadData];
        [self.historyTabView footerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}

-(void)btn3Tap{
    
    JKAlertDialog *alert = [[JKAlertDialog alloc]initWithTitle:@"提示" message:@""];
    alert.contentView =  self.slectMeal;
    [alert addButtonWithTitle:@"取消"];
    self.myAlert = alert;
    [alert show];
    [self setMealInfo];

}
-(void)reconTap{
    if ([self.txtFid1.text trim]==nil||[[self.txtFid1.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入被推荐人姓名！"];
    }else if ([self.txtFid2.text trim]==nil||[[self.txtFid2.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入手机号码！"];
    }else if( ![self isPhoneNum:[self.txtFid2.text trim]] ){
        [self showAllTextDialog:@"请输入正确的手机号码！"];
    }else if([self.txt3.text isEqualToString:@"套餐选择"]){
        [self showAllTextDialog:@"请选择套餐！"];
    }
    else{
        [self recommDatas];
    }
}

//18591980191
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if( [MFMessageComposeViewController canSendText] ){
            
            MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
            
            controller.recipients = [NSArray arrayWithObject:self.txtFid2.text];
            //controller.body = @"您申请的健康体检专项体检计划已经通过，密码【" + self.recommendCode! + "】有效期15天，持此码在【普惠】所有分院享受7折优惠，垂询4006126126.";
            NSString *str=[NSString stringWithFormat:@"%@，我为您申请了普惠体检优惠活动，密码【%@】有效期15天，持此码在【普惠】所有分院享受7折优惠，垂询4006126126。",self.namez,self.codesz];
            controller.body = str;
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
            [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"推荐短信"];
        }else{
            [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
        }
    }else{
        
        
    }
//    self.txtFid1.text = @"";
//    self..text = @"";
//    _isManSex = @"";
//    _selectMel.text = @"套餐选择";
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissModalViewControllerAnimated:NO];
    switch ( result ) {
        case MessageComposeResultCancelled:
            [self alertWithTitle:@"提示信息" msg:@"发送取消"];
            break;
        case MessageComposeResultFailed:
            [self alertWithTitle:@"提示信息" msg:@"发送失败"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示信息" msg:@"发送成功"];
            break;
        default:
            break;
    }
}

- (void) alertWithTitle:(NSString *)title msg:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
}



/**
 *
 *推荐接口
 *
 *
 */
- (void)recommDatas{
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *appuseridz=[user objectForKey:@"appuseridz"];
    NSString *orgidz=[user objectForKey:@"orgidz"];
    // [self showAllTextDialog:self.isManSex]; //131  629 438
    [RequestServer fetchMethodName:@"add_app_serv_record_toapp" parameters:@{
           @"app_serv_record.org_id":@"4",
            @"app_serv_record.appuser_id":appuseridz,
           @"app_serv_record.package_id": self.pacgID,
           @"app_serv_record.retail": self.retailz,
            @"app_serv_record.cost": self.costz,
            @"app_serv_record.name":self.txtFid1.text,
           @"app_serv_record.mobile":self.txtFid2.text,
          @"app_serv_record.sex":self.isManSex} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
                                                                                 
              if(![responseDic[@"app_serv_record"] isEqualToString:@"null"]){
                  
                  self.codesz=responseDic[@"app_serv_record"] ;
                  self.namez=self.txtFid1.text;
                  [self sendAlert];
               
                                                                                     
                                                                                     
                       }else{
                    [self showAllTextDialog:@"推荐失败！"];
                                                                                 }
              } failureHandler:^(NSString *errorInfo) {
                   NSLog(@"error :%@",errorInfo);
                                                                             }];
}

/**
 *  获得套餐列表信息
 *
 */

- (void)setMealInfo
{
    [RequestServer fetchMethodName:@"get_serv_price_by_orgId" parameters:@{@"serv_price.org_id":@"4"} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD   successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"serv_price_list"];
        //package_id   retail   cost
        for (NSDictionary *dict  in inforArys) {
            RecomMealModel *meals=[RecomMealModel objectWithKeyValues:dict];
            [self.arrysMuta  addObject:meals];
        }
        
        [self.slectMeal reloadData];
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}


/**
 *
 *推荐历史接口
 *
 *
 */
- (void)recommHisDatas{
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *appuseridz=[user objectForKey:@"appuseridz"];
    NSString *orgidz=[user objectForKey:@"orgidz"];
    // [self showAllTextDialog:self.isManSex]; //131  629 438
    [RequestServer fetchMethodName:@"find_app_serv_record_By_userId" parameters:@{
                @"app_serv_record.appuser_id":appuseridz,
                @"pageIndex":[NSString stringWithFormat:@"%d",self.pageCount]} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
                    NSArray *inforArys=responseDic[@"app_serv_record_list"];
                    for (NSDictionary *dict  in inforArys) {
                        RecodHistoryInfo *meals=[RecodHistoryInfo objectWithKeyValues:dict];
                        [self.arrysMutas addObject:meals];
                    }
                    self.pageCount++;
                    [self.historyTabView reloadData];
                   // [self.historyTabView headerEndRefreshing];

                    
                    
                    
                    
                 } failureHandler:^(NSString *errorInfo) {
                NSLog(@"error :%@",errorInfo);
       }];
}


//reconmmentSeg切换响应事件
-(void)selectSeg{
    switch (self.reconmmentSeg.selectedSegmentIndex) {
        case 0:
            
            self.scroll.hidden=NO;
            self.historyView.hidden=YES;
            break;
        case 1:
            
            self.historyView.hidden=NO;
            self.scroll.hidden=YES;
            
            [self.historyTabView headerBeginRefreshing];
            break;
        default:
            break;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
   
    self.reconmmentSeg.selectedSegmentIndex=0;
    [self.reconmmentSeg addTarget:self action:@selector(selectSeg) forControlEvents:UIControlEventValueChanged];
    //[self.view addSubview:self.inRcmControlller.view];
    
    
    //导航栏右边按钮
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    //@property (strong, nonatomic)  UIButton *leftBtn;
    self.navigationItem.title=@"好友推荐";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(rightTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    
    [self initBases];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.historyTabView) {
        return self.arrysMutas.count;
    }else{
    return  self.arrysMuta.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.historyTabView) {
        return  134;
    }else{
        return  44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (tableView==self.historyTabView) {
        static NSString *ID=@"Cell";
        RecommendHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            //注意：cell的xib文件必须设定Identifier为Cell，即为ID
            cell=[[[NSBundle mainBundle]loadNibNamed:@"RecommendHistoryCell" owner:nil options:nil]lastObject];
        }
        //[self showAllTextDialog: [NSString stringWithFormat:@"%d",indexPath.row ]];
        RecodHistoryInfo *info= self.arrysMutas[indexPath.row];
        cell.nameT.text = info.name;
        cell.phoneT.text = info.mobile;
        cell.sexT.text = info.sex;
        cell.mealT.text = info.package_name;
        cell.keyT.text = info.app_barcode;
        cell.timeT.text = info.create_date;
        cell.sendBtn.tag=indexPath.row+1;
        UIButton *btn=cell.sendBtn;
        [cell.sendBtn addTarget:self action:@selector(cellBtnTap:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        static NSString *CellIdentifier = @"Celll";
        InternalRecmCell *cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"InternalRecmCell" owner:nil options:nil]lastObject];
        }
        RecomMealModel *info=self.arrysMuta[indexPath.row];
        cell.mealName.text=info.name;
        cell.mealID.text=[NSString stringWithFormat:@"%d",info.package_id]   ;
        cell.mealDetail.text=[NSString stringWithFormat:@"%d",info.retail];
        cell.mealCost.text=[NSString stringWithFormat:@"%d",info.cost] ;
        return cell;
    }
    
    
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.historyTabView) {
          RecommendHistoryCell *cell = (RecommendHistoryCell *)[tableView cellForRowAtIndexPath:indexPath];
        
    }else{
        InternalRecmCell *cell = (InternalRecmCell *)[tableView cellForRowAtIndexPath:indexPath];
        self.mealNamez=cell.mealName.text;
        self.txt3.text=cell.mealName.text;
        
        self.pacgID= cell.mealID.text;
        self.retailz=cell.mealDetail.text;
        self.costz=cell.mealCost.text;
        if ([cell.mealName.text containsString:@"女"]) {
            [self.femaImg setImage:[UIImage imageNamed:@"inrcm_select"]];
            [self.mealImg setImage:[UIImage imageNamed:@"inrcm_notselect"]];
            self.isManSex=@"女";
        }else{
            [self.mealImg setImage:[UIImage imageNamed:@"inrcm_select"]];
            [self.femaImg setImage:[UIImage imageNamed:@"inrcm_notselect"]];
            self.isManSex=@"男";
        }
        
        
        [_myAlert dismiss];

    }
   }


-(void)cellBtnTap:(UIButton *) btn{
    for (int j=0; j<self.arrysMutas.count; j++) {
        if ((btn.tag-1)==j) {
            RecodHistoryInfo *info= self.arrysMutas[(btn.tag-1)];
           // info.name;  .app_barcode
            self.codesz=info.app_barcode;
            self.namez=info.name;
            [self sendAlert];
        }
    }
   
  //  [self showAllTextDialog: [NSString stringWithFormat:@"%d",tags ]];
}
-(void)sendAlert{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil  message:@"推荐成功，发送短信" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
    [alert show];


}
-(void)rightTap{
    [self.navigationController popViewControllerAnimated:YES];
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
- (BOOL)isPhoneNum:(NSString *)phoneNO {
    //    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString *phoneRegex = @"^(1)\\d{10}$";
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    if ([phoneTest evaluateWithObject:[phoneNO trim]]) {
        return  YES;
    }else {
        return NO;
    }
}

@end
