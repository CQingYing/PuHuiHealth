//
//  TeamOrderController.m
//  PuHui
//
//  Created by rp.wang on 15/7/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "TeamOrderController.h"
#import "BBRim.h"
#import "IQKeyboardManager.h"
#import "SelectMealController.h"
#import "MBProgressHUD.h"
#import "NSString+Extension.h"

@interface TeamOrderController ()
@property (strong, nonatomic) IBOutlet UIButton *sureNext;
@property (strong, nonatomic) IBOutlet UIView *viewLable;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic) IBOutlet UITextField *codeTxtFid;
@property (strong, nonatomic)  UIButton *leftBtn;

@end

@implementation TeamOrderController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //@property (strong, nonatomic)  UIButton *leftBtn;
    self.navigationItem.title=@"团体预约";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    
    self.sureNext.backgroundColor=[UIColor orangeColor];
    [self.sureNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.sureNext radius:4 width:1 color:[UIColor clearColor]];
    [rim bb_rimWithView:self.viewLable radius:1 width:1 color:[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:0.2]];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    
}
-(void)leftTap{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sureTap:(id)sender {
    
    
    if ([self.codeTxtFid.text trim]==nil||[[self.codeTxtFid.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入16位数字团体码!"];
    }else if(![self isTeamCode:[self.codeTxtFid.text trim]]){
        [self showAllTextDialog:@"请输入16位数字团体码!"];
    }else{
        [self setGroupNumInfo];
    }
}

- (void)setGroupNumInfo
{
   //调试团体吗：1000150807000993      5001130607000015
    [RequestServer fetchMethodName:@"health_appserv_groupNumInfo" parameters:@{@"groupNum":[self.codeTxtFid.text trim]} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiYW  successHandler:^(NSMutableDictionary *responseDic)
     {
         
         
         if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
            NSArray  *infors=responseDic[@"data"];
            NSDictionary *dic= infors[0];
             UIStoryboard *selectMealSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
             SelectMealController *selectMealController=[selectMealSB instantiateViewControllerWithIdentifier:@"SelectMealController"];
             
             selectMealController.groupName = dic[@"groupName"];
             selectMealController.userName= dic[@"userName"];
             selectMealController.userPhone= dic[@"userPhone"];
             selectMealController.contractName= dic[@"contractName"];
             selectMealController.codesCon=self.codeTxtFid.text;
             [self.navigationController pushViewController:selectMealController animated:YES];
            
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (BOOL)isTeamCode:(NSString *)phoneNO {
    //    NSString *phoneRegex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    //    NSString *phoneRegexs = @"^(1)\\d{10}$";
    NSString *phoneRegex = @"^\\d{16}$";
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    if ([phoneTest evaluateWithObject:[phoneNO trim]]) {
        return  YES;
    }else {
        return NO;
    }
}
@end
