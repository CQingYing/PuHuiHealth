//
//  ReportCheckController.m
//  PuHui
//
//  Created by rp.wang on 15/7/17.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "ReportCheckController.h"
#import "BBRim.h"
#import "ReportListController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"

@interface ReportCheckController ()
@property (strong, nonatomic) IBOutlet UIButton *checkBtn;
@property (strong, nonatomic) IBOutlet UITextField *phoneNO;
@property (assign,nonatomic)  int countTimes;
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) IBOutlet UILabel *areaLab;
@property (strong, nonatomic) IBOutlet UITextField *codeTxtImg;

@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic) IBOutlet UILabel *codeLab;
@property (strong, nonatomic) IBOutlet UIButton *localBtn;
@property (strong, nonatomic)  UITableView *tabView;
@property (strong, nonatomic)  NSArray *cityAry;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (assign,nonatomic) int temp;
@property (strong, nonatomic)  NSString *codeStr;
@end

@implementation ReportCheckController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.checkBtn radius:6 width:1 color:[UIColor clearColor]];
    [self.localBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -150, 0, 0)];
    [self.localBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -120)];
    self.cityAry=@[@"西安市",@"咸阳市",@"成都市",@"洛阳市",@"天津市",@"重庆市",@"郑州市",@"合肥市",@"贵阳市",@"南阳市"];
    self.tabView=[[UITableView alloc]init];
    self.tabView.frame=CGRectMake(116, 38, self.view.frame.size.width-134, 150);
    self.tabView.userInteractionEnabled=YES;
    self.tabView.delegate=self;
    self.tabView.dataSource=self;
    self.tabView.rowHeight=30;
    [rim bb_rimWithViews:@[self.tabView,self.localBtn] radius:1 width:1 color:[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:0.2]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.checkBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.checkBtn.backgroundColor=[UIColor orangeColor];
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.codeLab radius:4 width:1 color:[UIColor orangeColor]];
    self.codeLab.textColor=[UIColor blueColor];
    UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takeCodeTap)];
    self.codeLab.userInteractionEnabled=YES;
    [self.codeLab addGestureRecognizer:ges];
}
- (IBAction)cheakTap:(id)sender {
    if([self.phoneNO.text trim]==nil||[[self.phoneNO.text  trim]isEqualToString:@""]){
        [self showAllTextDialog:@"请输入手机号码!"];
    }
    else if([self.codeTxtImg.text trim]==nil||[[self.codeTxtImg.text  trim]isEqualToString:@""]){
        [self showAllTextDialog:@"请输入验证码!"];
    }else if ( ![self isPhoneNum:[self.phoneNO.text trim]]){
        [self showAllTextDialog:@"请输入正确手机号!"];
    }
//    else if(![[self.codeTxtImg.text trim] isEqualToString:self.codeStr]){
//        [self showAllTextDialog:@"验证码不正确!"];
//    }
    else{
        
        ReportListController *reportListCon=[[ReportListController alloc]init];
        reportListCon.phoneCon=[self.phoneNO.text trim];
        reportListCon.areaCon=[self.areaLab.text trim];
        [self.navigationController  pushViewController:reportListCon animated:YES];
    
    }
    
    

    
}

-(void)cheakData{
    
    
//    [RequestServer fetchMethodName:@"getVerifyCode" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz,@"phone":self.phoneNO.text} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
//       
//    
//    } failureHandler:^(NSString *errorInfo) {
//        NSLog(@"%@",errorInfo);
//    }];

}
- (void)takeCodeTap {
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *userIdz=[user objectForKey:@"userIdz"];
    NSString *userAccountz=[user objectForKey:@"userAccountz"];
    NSString *userPwdz=[user objectForKey:@"userPwdz"];

    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch = [phoneTest evaluateWithObject:self.phoneNO.text];
    if (isMatch) {
        [RequestServer fetchMethodName:@"getVerifyCode" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz,@"phone":self.phoneNO.text} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            NSString *code = responseDic[@"verifyCode"];
            self.codeStr=responseDic[@"verifyCode"];
            NSString *phone = self.phoneNO.text;
            NSString *temp = responseDic[@"retCode"];
            if ([temp isEqualToString:@"0"]) {
                self.countTimes=60;
                self.codeLab.textColor=[UIColor grayColor];
               
                self.codeLab.userInteractionEnabled=NO;
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
            }
            [self showAllTextDialog:responseDic[@"retMsg"]];
            
        } failureHandler:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
        }];
    } else {
        [self showAllTextDialog:@"请输入正确的手机号!"];
    }

    
}
-(void)countTime{
    if (self.countTimes >= 1) {
         [self.codeLab setEnabled:NO];
        self.countTimes--;
        self.codeLab.text=[NSString stringWithFormat:@"%ds后获取",self.countTimes] ;
    } else {
        [self.codeLab setEnabled:YES];
        self.codeLab.text= @"获取验证码";
        self.codeLab.textColor=[UIColor blueColor];
        [self.timer invalidate];
        self.codeLab.userInteractionEnabled=YES;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityAry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.tabView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text =self.cityAry[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tabView cellForRowAtIndexPath:indexPath];
    [self.localBtn setTitle:cell.textLabel.text forState:UIControlStateNormal];
    self.areaLab.text=cell.textLabel.text;
    [self.tabView removeFromSuperview];
    self.temp=0;
}

- (IBAction)localTap:(id)sender {
    
    if (self.temp==0) {
        [self.tabView reloadData];
        self.mainView.clipsToBounds=NO;
        [self.mainView insertSubview:self.tabView atIndex:[[self.mainView subviews] count]];
        self.temp=1;
        return;
    }
    if(self.temp==1){
        [self.tabView removeFromSuperview];
        self.temp=0;
        return;
    }
}
- (BOOL)isPhoneNum:(NSString *)phoneNO {
    //    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    if ([phoneTest evaluateWithObject:[phoneNO trim]]) {
        return  YES;
    }else {
        return NO;
    }
}
@end
