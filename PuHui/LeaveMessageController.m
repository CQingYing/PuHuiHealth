//
//  LeaveMessageController.m
//  PuHui
//
//  Created by rp.wang on 15/7/7.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "LeaveMessageController.h"
#import "BBRim.h"
#import "IQKeyboardManager.h"
#import "MBProgressHUD.h"
#import "NSString+Extension.h"
//titleTxtFild renameTxtFild qqTxtFild emailTxtFild contentTxt codetTxtFild
@interface LeaveMessageController ()
@property (strong, nonatomic) IBOutlet UITextField *titleTxtFild;
@property (strong, nonatomic) IBOutlet UITextField *renameTxtFild;
@property (strong, nonatomic) IBOutlet UITextField *qqTxtFild;
@property (strong, nonatomic) IBOutlet UITextField *emailTxtFild;
@property (strong, nonatomic) IBOutlet UITextView *contentTxt;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *resetBtn;

@end

@implementation LeaveMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithViews:@[self.titleTxtFild,self.renameTxtFild,self.qqTxtFild,self.emailTxtFild,self.contentTxt] radius:4 width:1 color:[UIColor clearColor]];
    [rim bb_rimWithView:self.resetBtn radius:4 width:1 color:[UIColor orangeColor]];
    [self.resetBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    //导航栏邮编按钮
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    //@property (strong, nonatomic)  UIButton *leftBtn;
    self.navigationItem.title=@"给我们留言";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(rightTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:NO];
}
-(void)rightTap{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getLeaveMegInfo{
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    NSString *userId  = [users objectForKey:@"userIdz"];
    NSString *userAccount = [users objectForKey:@"userAccountz"];
    NSString *userPwd = [users objectForKey:@"userPwdz"];
    
    NSLog(@"^^^^%@^^^^%@^^^^%@",userId,userAccount,userPwd);
    
    [RequestServer fetchMethodName:@"guestbook" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"title":self.titleTxtFild.text,@"name":self.renameTxtFild.text,@"userQQ":self.qqTxtFild.text,@"userEmail":self.emailTxtFild.text,@"content":self.contentTxt.text} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
//        NSString *temp = responseDic[@"retCode"];
//        if ([temp isEqualToString:@"0"]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"留言成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"留言失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alert show];
//        }
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}

//titleTxtFild renameTxtFild qqTxtFild emailTxtFild contentTxt codetTxtFild
-(void)clearClick{
    self.titleTxtFild.text=@"";
    self.renameTxtFild.text=@"";
    self.qqTxtFild.text=@"";
    self.emailTxtFild.text=@"";
    self.contentTxt.text=@"";
}
- (IBAction)reSeting:(id)sender {
    [self clearClick];
}

- (IBAction)sureTap:(id)sender {
    
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    NSString *userId  = [users objectForKey:@"userIdz"];
    NSString *userAccount = [users objectForKey:@"userAccountz"];
    NSString *userPwd = [users objectForKey:@"userPwdz"];
    if([self.titleTxtFild.text trim]==nil||[[self.titleTxtFild.text trim] isEqualToString:@""])
    {
     [self showAllTextDialog:@"请输入留言标题!"];
        return;
    }
    if([self.emailTxtFild.text trim]==nil||[[self.emailTxtFild.text trim] isEqualToString:@""])
    {
        [self showAllTextDialog:@"请输入邮箱!"];
        return;
    }
    if([self.contentTxt.text trim]==nil||[[self.contentTxt.text trim] isEqualToString:@""])
    {
        [self showAllTextDialog:@"请输入留言内容!"];
        return;
    }
    if(![self validateEmail:[self.emailTxtFild.text trim]]){
        [self showAllTextDialog:@"请输入正确的邮箱!"];
        return;
    }
    
//    NSRange foundObj=[temp rangeOfString:jap options:NSCaseInsensitiveSearch];
//    if(foundObj.length>0) {
//        NSLog(@"Yes ! Jap found");
//    } else {
//        NSLog(@"Oops ! no jap");
//    }
    
    [RequestServer fetchMethodName:@"guestbook" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"title":self.titleTxtFild.text,@"name":self.renameTxtFild.text,@"userQQ":self.qqTxtFild.text,@"userEmail":self.emailTxtFild.text,@"content":self.contentTxt.text} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        NSLog(@"^^^^%@",responseDic[@"retMsg"]);
        [self showAllTextDialog:responseDic[@"retMsg"]];
        //        NSString *temp = responseDic[@"retCode"];
        //        if ([temp isEqualToString:@"0"]) {
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"留言成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //            [alert show];
        //        }else{
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"留言失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //            [alert show];
        //        }
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
    
    NSLog(@"^^^^%@^^^^%@^^^^%@",userId,userAccount,userPwd);
    
    //[self getLeaveMegInfo];
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

//邮箱
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
