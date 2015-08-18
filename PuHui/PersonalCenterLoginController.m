//
//  PersonalCenterLoginController.m
//  PuHui
//
//  Created by rp.wang on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "PersonalCenterLoginController.h"
#import "RegisterController.h"
#import "PersonController.h"
#import "MBProgressHUD.h"
#import "NSString+Extension.h"
#import "ForgetPasswordViewController.h"
#import "SevenSwitch.h"

@interface PersonalCenterLoginController ()
@property (strong, nonatomic)  UIButton *btn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UITextField *phoneTxtFid;
@property (strong, nonatomic) IBOutlet UITextField *pwTxtFid;

@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  NSString *str;
@property (strong, nonatomic)  NSString *txtFid;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@end

@implementation PersonalCenterLoginController
@synthesize flag;

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(defID:) name:@"RGST" object:nil];
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *inph=[user objectForKey:@"userAccountz"];
    self.phoneTxtFid.text=inph;
     //UIView *viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
   // self.tabBarController.tabBar.hidden=NO;
    //navagationBar 右边按钮
    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.btn setTitle:@"注册" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem   =[[UIBarButtonItem alloc]initWithCustomView:self.btn];
    //self.navigationItem.leftBarButtonItem   =[[UIBarButtonItem alloc]initWithCustomView:viewLeft];
    [self.btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    self.btn.userInteractionEnabled=YES;
    //注册监听者。
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goChange:) name:@"change" object:nil];
    
    SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width-68, 90, 60, 30)];
//    mySwitch.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 - 80);
    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    mySwitch.offImage = [UIImage imageNamed:@"logindot.png"];
    mySwitch.onImage = [UIImage imageNamed:@"loginabc.png"];
    mySwitch.onColor = [UIColor colorWithHue:0.08f saturation:0.74f brightness:1.00f alpha:1.00f];
    mySwitch.isRounded = YES;
    mySwitch.on=YES;
    self.pwTxtFid.secureTextEntry=YES;
    [self.mainView addSubview:mySwitch];
}
- (void)defID:(NSNotification *)notify{
    
    NSDictionary *dict = [notify userInfo];
    NSString *baseImg = [dict objectForKey:@"phone"];
    self.phoneTxtFid.text=baseImg;
}

- (void)cancelPW:(NSNotification *)notify{
    NSDictionary *dict = [notify userInfo];
    self.pwTxtFid.text=@"";
}

-(void)goChange:(NSNotification *)notification
{
    //拿到通知内容。
    NSDictionary *dic = [notification userInfo];
    NSString *temp = [dic objectForKey:@"temp"];
    self.str =temp;
    NSLog(@"^^^^^%@",self.str);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  登陆接口：渠道接口
 *
 *
 */
- (void)setLoginInfoQD
{
     [RequestServer fetchMethodName:@"appuser_login" parameters:@{@"app_user.phone":[self.phoneTxtFid.text trim],@"app_user.vpwd":[self.pwTxtFid.text trim]} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD  successHandler:^(NSMutableDictionary *responseDic) {
        
         NSDictionary *str= responseDic[@"appuser"];
         NSString *strq= responseDic[@"appuser"];
//         if (![strq isEqualToString:@"null"]&& strq!=nil&& ![strq isEqualToString: @""]) {
             if (!(str.count<5))
             {
                 NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                 NSString *appID= str[@"appuser_id"];
                 NSString *orgid= str[@"org_id"];
                 [user setObject:appID forKey:@"appuseridz"];
                 [user setObject:orgid  forKey:@"orgidz"];
                 [self setLoginInfo];
             }
        // }
         
         else
         {
             [self showAllTextDialog:@"用户名或者密码错误！"];
             return ;
         }
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}


/**
 *  登陆请求:健康
 *
 */
- (void)setLoginInfo
{
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
            
            
            //userAccountz userPwdz userNamez
          NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:[self.phoneTxtFid.text  trim] forKey:@"userAccountz"];
            [user setObject:[self.pwTxtFid.text  trim]  forKey:@"userPwdz"];
            [user setObject:userIdStr forKey:@"userIdz"];
            [user setObject:userNaStr forKey:@"userNamez"];
            
            [user setObject:favoritesNumStr forKey:@"favoritesNumz"];
            [user setObject:questionsNumStr forKey:@"questionsNumz"];
            [user setObject:userIconStr forKey:@"userIconz"];
            
            [user synchronize];
            
            if ([flag isEqualToString:@"0"]) {
                [self.navigationController popViewControllerAnimated:NO];
                NSLog(@"----1111----");
                return ;
            }
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"AlreadLogin" object:self userInfo:nil];
            if ([self.str isEqualToString:@"回调到首页"]) {
                self.tabBarController.selectedIndex=0;
                self.str =@"";
                return ;
            }
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"PersonController" bundle:nil];
            PersonController *personController=[sb instantiateInitialViewController];
            [self.navigationController pushViewController:personController animated:YES];
            
            NSLog(@"^^^%@",[user objectForKey:@"userIdz"]);
            
            
        }else{
            [self showAllTextDialog:str];
        }
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}
-(void)tap{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"RegisterController" bundle:nil];
    RegisterController *registerController=[sb instantiateInitialViewController];
    [self.navigationController pushViewController:registerController animated:YES];
}
- (IBAction)loginTap:(id)sender {
    
    if ([self.phoneTxtFid.text trim]==nil||[[self.phoneTxtFid.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入手机号！"];
    }
    else if ([self.pwTxtFid.text trim]==nil||[[self.pwTxtFid.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入密码！"];
    }
    else if ( ![self isPhoneNum:[self.phoneTxtFid.text trim]]) {
        [self showAllTextDialog:@"请输入正确手机号！"];
    }else{
        [self setLoginInfoQD];
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
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self ];
 
}

-(IBAction)forgetPassword:(id)sender {
    ForgetPasswordViewController *fpc = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:fpc animated:YES];
}
- (void)switchChanged:(SevenSwitch *)sender {
    self.txtFid=self.pwTxtFid.text;
    if (sender.on) {
        //暗文
        self.pwTxtFid.text=self.txtFid;
        self.pwTxtFid.secureTextEntry=YES;
        
    }else{
        //明文
        self.pwTxtFid.text=self.txtFid;
        self.pwTxtFid.secureTextEntry=NO;
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
