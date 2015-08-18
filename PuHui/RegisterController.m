//
//  RegisterController.m
//  PuHui
//
//  Created by rp.wang on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "RegisterController.h"
#import "BBRim.h"
#import "MBProgressHUD.h"
#import "NSString+Extension.h"
#import "PersonController.h"

@interface RegisterController ()
@property (strong, nonatomic)  UIButton *btn;
@property (strong, nonatomic) IBOutlet UIView *phoneLabel;
@property (strong, nonatomic) IBOutlet UIView *rephoneLabel;
@property (strong, nonatomic) IBOutlet UIView *pwLabel;
@property (strong, nonatomic) IBOutlet UIView *repwLabel;
@property (strong, nonatomic) IBOutlet UIView *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *regiBtn;
@property (strong, nonatomic) NSArray *ary;
@property (strong, nonatomic) IBOutlet UITextField *phoneTxtFid;
@property (strong, nonatomic) IBOutlet UITextField *rephoneTxtFid;
@property (strong, nonatomic) IBOutlet UITextField *pwTxtFid;
@property (strong, nonatomic) IBOutlet UITextField *repwTxtFid;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTxtFid;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (assign,nonatomic) int temp;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    //导航栏信息
    self.navigationItem.title=@"快速注册";
    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.btn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0, 0 ,40, 40)];
    self.navigationItem.rightBarButtonItem   =[[UIBarButtonItem alloc]initWithCustomView:vi];
    self.btn.userInteractionEnabled=YES;
    [self.btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    self.btn.enabled=NO;
    self.ary=@[self.phoneLabel,self.rephoneLabel,self.pwLabel,self.repwLabel,self.nameLabel];
    BBRim *rim=[[BBRim alloc]init];
    
    [rim bb_rimWithViews:self.ary radius:6 width:2 color:[UIColor grayColor]];
    [rim bb_rimWithView:self.regiBtn radius:8 width:2 color:[UIColor clearColor]];
    
    //[self showAllTextDialog:@"asdfas"];
}
- (IBAction)registerTap:(id)sender {
    if([self.phoneTxtFid.text trim]==nil||[[self.phoneTxtFid.text  trim]isEqualToString:@""]){
        [self showAllTextDialog:@"请输入手机号码!"];
    }
    else if([self.rephoneTxtFid.text trim]==nil||[[self.rephoneTxtFid.text trim ]isEqualToString:@""]){
        [self showAllTextDialog:@"请再次输入手机号码!"];
    }
    else if([self.pwTxtFid.text trim]==nil||[[self.pwTxtFid.text trim] isEqualToString:@""]){
        [self showAllTextDialog:@"请输入密码!"];
    }
     else if([self.repwTxtFid.text trim]==nil||[[self.repwTxtFid.text trim] isEqualToString:@""]){
        [self showAllTextDialog:@"请再次输入密码!"];
    }
    else if([self.nicknameTxtFid.text trim]==nil||[[self.nicknameTxtFid.text trim] isEqualToString:@""]){
        [self showAllTextDialog:@"请输入昵称!"];
    }
    else if(![[self.phoneTxtFid.text trim ]isEqualToString:[self.rephoneTxtFid.text trim]]){
        [self showAllTextDialog:@"两次输入的手机号不同,请确认!"];
    }
    else if(![[self.pwTxtFid.text trim ]isEqualToString:[self.repwTxtFid.text trim]]){
        [self showAllTextDialog:@"两次输入的密码不同,请确认!"];
    }
    else if(![self isPhoneNum:[self.phoneTxtFid.text trim]]){
        [self showAllTextDialog:@"手机号码格式不正确"];
    }//isNicknames
    else if(![self isPasswd:[self.pwTxtFid.text trim]]){
        [self showAllTextDialog:@"密码为6-20位数字和字母组合"];
    }
    else if(![self isNicknames:[self.nicknameTxtFid.text trim]]){
        [self showAllTextDialog:@"昵称为2-10位的汉字字母或数字"];
    }else{
        [self setMealInfoQD];
       //  [self setMealInfo];
    }
}//.com
-(void)tap{
    [RequestServer fetchMethodName:@"userLogin" parameters:@{@"userAccount":[self.phoneTxtFid.text trim],@"userPwd":[self.pwTxtFid.text trim]} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
        NSString *str=responseDic[@"retMsg"];
        NSString * reInt=responseDic[@"retCode"];
        
        if ([reInt isEqualToString:@"0"]) {
            NSArray * userNa=responseDic[@"data"];
            NSDictionary * dicInfo=userNa[0];
            NSString * userNaStr=dicInfo[@"userName"];
            NSString * userIdStr=dicInfo[@"userId"];
            
            NSString * favoritesNumStr=dicInfo[@"favoritesNum"];
            NSString * questionsNumStr=dicInfo[@"questionsNum"];
            NSString * userIconStr=dicInfo[@"userIcon"];
            
            
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:[self.phoneTxtFid.text  trim] forKey:@"userAccountz"];
            [user setObject:[self.pwTxtFid.text  trim]  forKey:@"userPwdz"];
            [user setObject:userIdStr forKey:@"userIdz"];
            [user setObject:userNaStr forKey:@"userNamez"];
            
            [user setObject:favoritesNumStr forKey:@"favoritesNumz"];
            [user setObject:questionsNumStr forKey:@"questionsNumz"];
            [user setObject:userIconStr forKey:@"userIconz"];
            
            [user synchronize];
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"PersonController" bundle:nil];
            PersonController *personController=[sb instantiateInitialViewController];
            [self.navigationController pushViewController:personController animated:YES];
        }else{
            [self showAllTextDialog:str];
        }
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];

    
}
/**
 *  注册信息接口：健康接口
 *
 *  注册成功账号信息
 */
- (void)setMealInfo
{
    [RequestServer fetchMethodName:@"userRegist" parameters:@{@"userPhone":self.phoneTxtFid.text,@"userPwd":self.pwTxtFid.text,@"userName":self.nicknameTxtFid.text} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
        NSString *str=responseDic[@"retMsg"];
        NSString * reInt=responseDic[@"retCode"];
        NSLog(@"^^^^^^^^^%@",reInt);
        [self showAllTextDialog:str];
        if ([reInt isEqualToString:@"0"]) {

            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phone"] = self.phoneTxtFid.text;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"RGST" object:self userInfo:params];
            [self.navigationController popViewControllerAnimated:YES];
        
        }
        
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}
/**
 *  注册信息接口：渠道接口
 *
 *  注册成功账号信息
 */
- (void)setMealInfoQD
{
    [RequestServer fetchMethodName:@"appuser_register" parameters:@{@"app_user.phone":self.phoneTxtFid.text,@"app_user.vpwd":self.pwTxtFid.text,@"app_user.name":self.nicknameTxtFid.text,@"app_user.reg_key":@"126126"} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD  successHandler:^(NSMutableDictionary *responseDic) {
        
        if ([responseDic[@"appuser"] isEqualToString:@"ok"]) {
            [self setMealInfo];
        }else if ([responseDic[@"appuser"] isEqualToString:@"noOrg"]) {
            [self showAllTextDialog:@"没有该渠道"];
            return ;
        }else if ([responseDic[@"appuser"] isEqualToString:@"registered"]) {
            //[self setMealInfo];
            [self showAllTextDialog:@"该账号已经注册！"];
            return ;
        }
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   [self.view endEditing:NO];
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
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    if ([phoneTest evaluateWithObject:[phoneNO trim]]) {
        return  YES;
    }else {
        return NO;
    }
}
- (BOOL)isPasswd:(NSString *)passwd {
    //[0-9 | A-Z | a-z]{6,16}
    NSString *passwdRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9a-zA-Z]{6,20}";
    NSPredicate* passwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwdRegex];
    
    if ([passwdTest evaluateWithObject:passwd]) {
        return  YES;
    }else {
        return NO;
    }
}

- (BOOL)isNicknames:(NSString *)nicknames {
    //[0-9 | A-Z | a-z]{6,16}    [\\u4E00-\\u9FFF]{2,5}|[a-zA-Z]{2,16}
    NSString *passwdRegex = @"^[0-9a-zA-Z\u4e00-\u9fa5]{2,10}$";
    NSPredicate* passwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwdRegex];
    if ([passwdTest evaluateWithObject:nicknames]) {
        return  YES;
    }else {
        return NO;
    }
}
@end
