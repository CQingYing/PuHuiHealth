//
//  SureOrderController.m
//  PuHui
//
//  Created by rp.wang on 15/7/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "SureOrderController.h"
#import "BBRim.h"
#import "FinishViewController.h"

#import "MBProgressHUD.h"
#import "NSString+Extension.h"
#import "TestResultModel.h"

@interface SureOrderController ()
@property (strong, nonatomic) IBOutlet UIButton *sureOrder;
@property (strong, nonatomic) IBOutlet UITextField *nameTxtFid;
@property (strong, nonatomic) IBOutlet UITextField *phoneTxtFid;
@property (strong, nonatomic) IBOutlet UITextField *timeTxtFid;
@property (strong, nonatomic) IBOutlet UILabel *addLabel;
@property (strong, nonatomic) IBOutlet UILabel *mealLabel;
@property (strong, nonatomic)  UIDatePicker *datapicker;
@property (strong, nonatomic) IBOutlet UIView *viView;
@property (strong, nonatomic)  UIView *bottView;
@property (strong, nonatomic)  UIWindow *win;
@property (strong, nonatomic)  UIButton *selTimeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *selTimeImg;
@property (assign,nonatomic)  int  temp;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  UIButton *rightBtn;
@property (strong, nonatomic)  UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIImageView *delImg;
@property (strong, nonatomic) IBOutlet UIImageView *delLine;
@property (strong, nonatomic)  NSMutableArray *endAry;
@end

@implementation SureOrderController

- (NSMutableArray *)endAry
{
    if (!_endAry) {
        _endAry= [[NSMutableArray alloc] init];
    }
    return _endAry;
}

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
    self.navigationItem.title=@"个人预约";
    // Do any additional setup after loading the view.
    self.temp=1;
    //设置navigationbar的按钮
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
    //设置确认按钮风格
    [self.sureOrder setTintColor:[UIColor whiteColor]];
    self.sureOrder.backgroundColor=[UIColor orangeColor];
    BBRim *rim=[[BBRim  alloc]init];
    [rim bb_rimWithView:self.sureOrder radius:4 width:1 color:[UIColor clearColor]];
    [rim bb_rimWithView:self.selTimeBtn radius:6 width:2 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    //设置传递的数据
    NSString *str=[self.adContent substringFromIndex:5];
    self.addLabel.text=str;
    self.mealLabel.text=self.mealTyContent;
    //加日期控件
    [self.win addSubview:self.bottView];
    [self.bottView addSubview:self.datapicker];
    [self.bottView addSubview:self.selTimeBtn];
    self.bottView.hidden=YES;
    //设置默认值
    [self setDefault];
    //日期选择点击
    [self setTap];
    self.timeTxtFid.enabled=NO;
    
    
    if (self.signOrd==2) {
        self.delImg.hidden=YES;
        self.delLine.hidden=YES;
    }
}
- (IBAction)sureOrders:(id)sender {
    self.temp=1;
    self.bottView.hidden=YES;
//时间比较
      NSDate * now = [NSDate date];
    　　NSDate * anHourAgo = [now dateByAddingTimeInterval:-60*60];
//    　　NSTimeInterVal timeBetween = [now timeIntervalSinceDate:anHourAgo];
//    　　NSLog(@”%f”,timeBetween);
//    NSDate * now = [NSDate date];
//    NSDate * anHourAgo = [now dateByAddingTimeInterval:-60*60];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *dates=[dateFormatter dateFromString:[self.timeTxtFid.text trim]];
   NSTimeInterval  timeBetween = [now timeIntervalSinceDate:dates];
   
    if ([self.nameTxtFid.text trim]==nil||[[self.nameTxtFid.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入真实姓名!"];
    }else if([self.phoneTxtFid.text trim]==nil||[[self.phoneTxtFid.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入手机号!"];
    }else if([self.timeTxtFid.text trim]==nil||[[self.timeTxtFid.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请选择时间!"];
    }else if(![self isPhoneNum:[self.phoneTxtFid.text trim]]) {
        [self showAllTextDialog:@"请输入正确的手机号!"];
    }else if(timeBetween>0) {
        [self showAllTextDialog:@"选择的日期应该在今天以后!"];
    }else{
        
        [self setPersonalAppointmentInfo];
    }
}

- (void)setPersonalAppointmentInfo
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    NSString *userAccountz=[user objectForKey:@"userAccountz"];
    NSString *userPwdz=[user objectForKey:@"userPwdz"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *dates=[dateFormatter dateFromString:[self.timeTxtFid.text trim]];
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatters stringFromDate:dates];
    
    NSLog(@"^^^%@^^^%@^^^%@^^^%@^^^%@^^^%@^^^%@",userIdz,userAccountz,userPwdz,self.pagIDContent,[self.adContent substringFromIndex:5],self.mealTyContent,dateStr);
    
    
    
    
    
    if (self.signOrd==2) {
        for (int i=0; i<self.orderAry.count; i++) {
            TestResultModel *info=self.orderAry[i];
            NSDictionary *dic=@{@"itemId":info.itemId, @"itemName":info.itemName,@"itemRetail":info.itemRetail,@"itemCost":info.itemCost};
            [self.endAry addObject:dic];
        }
        
        
        [RequestServer fetchMethodName:@"custAppointment" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz,@"appointPhone":[self.phoneTxtFid.text trim],@"appointName":[self.nameTxtFid.text trim],@"appointTime":dateStr,@"appointAddress":[self.adContent substringFromIndex:5],@"data":self.endAry} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            
            NSString *codes=responseDic[@"retCode"];
            if (![codes isEqualToString:@"0"]) {
                [self showAllTextDialog:responseDic[@"retMsg"]];
                return ;
            }
            [self showAllTextDialog:responseDic[@"retMsg"]];
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
            FinishViewController *finishController=[sb instantiateViewControllerWithIdentifier:@"FinishViewController"];
            //finishController.mealTyContent=self.mealTyContent;
            [self.navigationController pushViewController:finishController animated:YES];

       
            
        } failureHandler:^(NSString *errorInfo) {
            
            NSLog(@"error :%@",errorInfo);
            
        }];

    }else{
    
    
        [RequestServer fetchMethodName:@"PersonalAppointment" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz,@"appointPhone":[self.phoneTxtFid.text trim],@"appointName":[self.nameTxtFid.text trim],@"appointTime":dateStr,@"appointAddress":[self.adContent substringFromIndex:5],@"package_id":self.pagIDContent,@"packagesName":self.mealTyContent} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            NSString *codes=responseDic[@"retCode"];
            NSLog(@"^^^^%@",codes);
            if (![codes isEqualToString:@"0"]) {
                [self showAllTextDialog:responseDic[@"retMsg"]];
                return ;
            }
            [self showAllTextDialog:responseDic[@"retMsg"]];
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
            FinishViewController *finishController=[sb instantiateViewControllerWithIdentifier:@"FinishViewController"];
            finishController.mealTyContent=self.mealTyContent;
            [self.navigationController pushViewController:finishController animated:YES];
            
        } failureHandler:^(NSString *errorInfo) {
            
            NSLog(@"error :%@",errorInfo);
            
        }];
    
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTap{
    self.selTimeImg.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(isSelTime)];
    [self.selTimeImg addGestureRecognizer:tap];
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
-(void)rightTap{
   self.temp=1;
   self.bottView.hidden=YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
