//
//  TeamOrderInfoController.m
//  PuHui
//
//  Created by rp.wang on 15/7/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "TeamOrderInfoController.h"
#import "BBRim.h"
#import "TeamOrderFinishController.h"
#import "NSString+Extension.h"
#import "MBProgressHUD.h"

@interface TeamOrderInfoController ()
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong, nonatomic) IBOutlet UIImageView *dateImg;

@property (strong, nonatomic)  UIDatePicker *datapicker;
@property (strong, nonatomic)  UIView *bottView;
@property (strong, nonatomic)  UIWindow *win;
@property (strong, nonatomic)  UIButton *selTimeBtn;
@property (assign,nonatomic)  int  temp;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  UIButton *rightBtn;
@property (strong, nonatomic)  UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UITextField *timeTxtFid;
//nameTxtFidphoneTxtFid
@property (strong, nonatomic) IBOutlet UITextField *nameTxtFid;
@property (strong, nonatomic) IBOutlet UITextField *phoneTxtFid;
@property (strong, nonatomic) IBOutlet UILabel *addLab;
@property (strong, nonatomic) IBOutlet UILabel *consLab;
@property (strong, nonatomic) IBOutlet UILabel *conmLab;







@end

@implementation TeamOrderInfoController
- (UIWindow *)win
{
    if (!_win) {
        _win= [[UIApplication sharedApplication].windows lastObject];
    }
    return _win;
}
- (UIView *)bottView
{
    if (!_bottView) {
        _bottView= [[UIView alloc] initWithFrame:CGRectMake(0,self.win.frame.size.height-250, self.view.frame.size.width, 250)];
        _bottView.backgroundColor=[UIColor whiteColor];
    }
    return _bottView;
}
- (UIDatePicker *)datapicker
{
    if (!_datapicker) {
        _datapicker= [[UIDatePicker alloc] init];
        _datapicker.frame=CGRectMake(0, 0, self.view.frame.size.width, 50);
    }
    return _datapicker;
}
- (UIButton *)selTimeBtn
{
    if (!_selTimeBtn) {
        _selTimeBtn= [[UIButton alloc] initWithFrame:CGRectMake(16, self.bottView.frame.size.height-50, self.view.frame.size.width-32, 45)];
        //_selTimeBtn.backgroundColor=[UIColor grayColor];
        [_selTimeBtn setTitle:@"选择" forState:UIControlStateNormal];
        [_selTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selTimeBtn addTarget:self action:@selector(STTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selTimeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.temp=1;
    self.timeTxtFid.enabled=NO;
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"团体预约";
    self.sureBtn.backgroundColor=[UIColor orangeColor];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.sureBtn radius:4 width:1 color:[UIColor clearColor]];
    
    self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.rightBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [self.rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [self.rightBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTaps) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    
     [rim bb_rimWithView:self.selTimeBtn radius:6 width:2 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    //加日期控件
    [self.win addSubview:self.bottView];
    [self.bottView addSubview:self.datapicker];
    [self.bottView addSubview:self.selTimeBtn];
  
    self.bottView.hidden=YES;
    //设置默认数据
    [self setDefault];
    //日期选择点击
    [self setTap];
    
}

-(void)setTap{
    self.dateImg.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(isSelTime)];
    [self.dateImg addGestureRecognizer:tap];
}
-(void)isSelTime{
    if (self.temp==1) {
        self.bottView.hidden=NO;
        self.temp=2;
        return;
    }
    if (self.temp==2) {
        NSDate *selecteddate=[self.datapicker date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:selecteddate];
        self.timeTxtFid.text=currentDateStr;
        self.bottView.hidden=YES;
        self.temp=1;
        return;
    }
}
-(void)setDefault{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    NSString *userAccountz=[user objectForKey:@"userAccountz"];
    NSString *userPwdz=[user objectForKey:@"userPwdz"];
    NSString *userNamez=[user objectForKey:@"userNamez"];
    NSDate *dates=[[NSDate alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *currentDateStr = [dateFormatter stringFromDate:dates];
    self.phoneTxtFid.text=userAccountz;
    self.nameTxtFid.text=userNamez;
    self.timeTxtFid.text=currentDateStr;
    self.timeTxtFid.textColor=[UIColor grayColor];
    self.phoneTxtFid.textColor=[UIColor grayColor];
    self.nameTxtFid.textColor=[UIColor grayColor];
    
    
    self.nameTxtFid.text=self.userName;
    self.phoneTxtFid.text=self.userPhone;
    self.addLab.text=[self.addCon substringFromIndex:5];
    self.consLab.text=self.contractName;
    self.conmLab.text=self.groupName;
    
}
-(void)STTap{
    [self.nameTxtFid endEditing:YES];
    [self.phoneTxtFid endEditing:YES];
    NSDate *selecteddate=[self.datapicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:selecteddate];
    self.timeTxtFid.text=currentDateStr;
    self.bottView.hidden=YES;
    self.temp=1;
}
-(void)leftTaps{
    self.temp=1;
    self.bottView.hidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)leftTap{
    self.temp=1;
    self.bottView.hidden=YES;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确认要放弃预约吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.tag = 2;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
            //alertView;
        }
        if (buttonIndex == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}







- (IBAction)sureTap:(id)sender {

    
    NSDate * now = [NSDate date];
    NSDate * anHourAgo = [now dateByAddingTimeInterval:-60*60];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *dates=[dateFormatter dateFromString:[self.timeTxtFid.text trim]];
    NSTimeInterval  timeBetween = [now timeIntervalSinceDate:dates];

    if(timeBetween>0) {
        [self showAllTextDialog:@"选择的日期应该在今天以后!"];
        return;
    }
    [self setSureInfo];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setSureInfo
{
    
    
    //调试团体吗：1000150807000993      5001130607000015
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];

    NSString *userAccountz=[user objectForKey:@"userAccountz"];
    NSString *userPwdz=[user objectForKey:@"userPwdz"];
    NSString *userIdz=[user objectForKey:@"userIdz"];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *dates=[dateFormatter dateFromString:[self.timeTxtFid.text trim]];
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatters stringFromDate:dates];
    NSString *adds =[self.addCon substringFromIndex:5];
    
    NSLog(@"^^^%@^^^%@^^^%@^^^%@^^^%@^^^%@^^^%@^^^%@",userIdz,userAccountz,userPwdz,self.userPhone,self.userName,dateStr,adds,self.codesCon);
    [RequestServer fetchMethodName:@"groupAppointment" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz,@"appointPhone":self.phoneTxtFid.text,@"appointName":self.nameTxtFid.text,@"appointTime":dateStr,@"appointAddress":adds,@"package_id":@"",@"packagesName":@"",@"groupNum":self.codesCon} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic)
     {
         
         
         if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
             UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
             TeamOrderFinishController *selectCourtController=[sb instantiateViewControllerWithIdentifier:@"TeamOrderFinishController"];
             [self.navigationController pushViewController:selectCourtController animated:YES];
             
         }else{
             [self showAllTextDialog:responseDic[@"retMsg"]];
             return ;
             
         }
     }
                    failureHandler:^(NSString *errorInfo)
     {
         NSLog(@"error :%@",errorInfo);
     }];
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
