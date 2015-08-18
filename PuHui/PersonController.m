//
//  PersonController.m
//  PuHui
//
//  Created by rp.wang on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "PersonController.h"
#import "TableViewController.h"
#import "BBRim.h"
#import "LeaveMessageController.h"
#import "RecommendController.h"
#import "MyOrderController.h"
#import "PersonalInfoModifyController.h"
#import "FavoriteViewController.h"
#import "PersonMyQuesController.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MyAppointmentController.h"
#import "ShoppingCartController.h"


@interface PersonController ()
@property (strong, nonatomic)  TableViewController *viewController;
@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
@property (strong, nonatomic) IBOutlet UIButton *clearBtn;
@property (strong, nonatomic) IBOutlet UIView *sectionOne;
@property (strong, nonatomic) IBOutlet UIView *sectionTwo;
@property (strong, nonatomic) IBOutlet UIView *sectionThrww;
@property (strong, nonatomic) IBOutlet UILabel *recomLabel;
@property (strong, nonatomic) IBOutlet UIButton *leaveMessage;
@property (strong, nonatomic) IBOutlet UIButton *recommendBtn;
@property (strong, nonatomic) IBOutlet UIButton *myOrderBtn;
@property (strong, nonatomic) IBOutlet UIButton *personageInforBtn;
@property (strong, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (strong, nonatomic) IBOutlet UIButton *questionBtn;
@property (strong, nonatomic) IBOutlet UIButton *appointmentBtn;
@property (strong, nonatomic) IBOutlet UIImageView *personImage;
@property (strong, nonatomic) IBOutlet UIButton *cancelLoginBtn;
@property (strong, nonatomic) IBOutlet UILabel *UnreadCou;
@property (strong, nonatomic) IBOutlet UILabel *favoriteCountLab;
@property (strong, nonatomic) IBOutlet UILabel *quesCountLab;
//favoriteCountLab   quesCountLab
@property (strong, nonatomic) IBOutlet UILabel *nickNameBtn;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  NSString *userName;
@property (strong, nonatomic)  NSString *userIcon;
@property (strong, nonatomic) IBOutlet UIButton *updateBtn;
@end

@implementation PersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
//    if(self.tabBarController.selectedIndex==3){
//    UITabBarController *tabBar=(UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
//        tabBar.selectedViewController=self;}
    
    BBRim *rim=[[BBRim alloc]init];
    [self.clearBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.recomLabel.textColor=[UIColor orangeColor];
    [rim bb_rimWithViews:@[self.headLabel,self.clearBtn,self.sectionOne,self.sectionTwo,self.sectionThrww] radius:8 width:1 color:[UIColor grayColor]];
    [rim bb_rimWithView:self.personImage radius:40 width:2 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    UIView *viewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:viewLeft];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:viewLeft];
    self.navigationItem.title=@"个人中心";
    //注销按钮的属性
    [self.cancelLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelLoginBtn.backgroundColor=[UIColor orangeColor];
    [rim bb_rimWithView:self.cancelLoginBtn radius:6 width:1 color:[UIColor clearColor]];
    
    //通知
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(receiveNotification:) name:@"ChangeImageNotification"  object:nil];
    NSNotificationCenter *pc = [NSNotificationCenter defaultCenter];
    [pc addObserver:self selector:@selector(obtainNotification:) name:@"changNameNotification" object:nil];
    
    //属性传值
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    self.userName=[user objectForKey:@"userNamez"];
    self.userIcon=[user objectForKey:@"userIconz"];
    //@"http://xalanqi.xicp.net:8081/PuhuiServer/userimg/060f00f608984ef88ca0169d923b608e.jpg"
    self.nickNameBtn.text=self.userName;
    NSString *tempStr=[PHJKRequestUrl stringByAppendingString:self.userIcon];
    [self.personImage  sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"person_Head"]];
    // 设置未读数角标
    [self setUnreadNum];
    // 获取收藏 和 提问数
    [self getCounts];
    
}
- (void)receiveNotification:(NSNotification *)notify{
    
    NSDictionary *dict = [notify userInfo];
    NSString *baseImg = [dict objectForKey:@"baseImg"];
    UIImage  *image = [dict objectForKey:@"img"];
//   [self showAllTextDialog:baseImg];
    self.personImage.image =image;
}
- (void)obtainNotification:(NSNotification *)notify{
    NSDictionary *dic  = [notify userInfo];
    NSString *nickName = [dic objectForKey:@"nickNamez"];
    self.nickNameBtn.text = nickName;
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
- (IBAction)toLeaveMessage:(id)sender {
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"LeaveMessageController" bundle:nil];
    LeaveMessageController *toLeaveMessage=[sb instantiateInitialViewController];
    toLeaveMessage.hidesBottomBarWhenPushed=YES;
     [self.navigationController pushViewController:toLeaveMessage animated:YES];
}
- (IBAction)recommend:(id)sender {
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"RecommendController" bundle:nil];
    RecommendController *recommendController=[sb instantiateInitialViewController];
    
    recommendController.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:recommendController animated:YES];
}
- (IBAction)myOrder:(id)sender {
    MyOrderController *myOrder=[[MyOrderController alloc]init];
    myOrder.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:myOrder animated:YES];
}
- (IBAction)personageInfor:(id)sender {
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"PersonalInfoModifyController" bundle:nil];
    PersonalInfoModifyController *recommendController=[sb instantiateInitialViewController];
    recommendController.hidesBottomBarWhenPushed=YES;

    recommendController.name=self.nickNameBtn.text;
    recommendController.image=self.personImage.image;
    
    [self.navigationController pushViewController:recommendController animated:YES];
}
- (IBAction)clickFavoriteBtn:(id)sender {
    FavoriteViewController *fvc = [[FavoriteViewController alloc] init];
    fvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fvc animated:YES];
}

- (IBAction)clickQuestionBtn:(id)sender {
    PersonMyQuesController *PersonMyQues=[[PersonMyQuesController alloc] init];
  //  MyQuestionPersonController *PersonMyQues=[[MyQuestionPersonController alloc] init];
    PersonMyQues.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:PersonMyQues animated:YES];
}
- (IBAction)myCartTap:(id)sender {
    
    ShoppingCartController *shopCartCon=[[ShoppingCartController alloc]init];
    shopCartCon.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:shopCartCon animated:YES];
}

- (IBAction)clickAppointmentBtn:(id)sender {
    MyAppointmentController *MyApp = [[MyAppointmentController alloc] init];
    MyApp.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:MyApp animated:YES];
}
- (IBAction)updateTap:(id)sender {
   NSString *sty = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
    NSLog(@"^^^^^%@",sty);
    return;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *  userIdz= [user objectForKey:@"userIdz"];
    NSString *  userPwdz= [user objectForKey:@"userPwdz"];
    NSString *  userAccountz= [user objectForKey:@"userAccountz"];
    [RequestServer fetchMethodName:@"systemUpdate" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz,@"platform":@"ios",@"versionNum":sty} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {

    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];

}
-(void)setUnreadNum{
    self.UnreadCou.backgroundColor=[UIColor redColor];
    self.UnreadCou.textColor=[UIColor whiteColor];
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.UnreadCou radius:9 width:1 color:[UIColor clearColor]];
    [self unreadCount];
}
//返回未读数量
-(void)unreadCount{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *  userIdz= [user objectForKey:@"userIdz"];
    NSString *  userPwdz= [user objectForKey:@"userPwdz"];
    NSString *  userAccountz= [user objectForKey:@"userAccountz"];
    
    [RequestServer fetchMethodName:@"acceptUnreadNum" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
        if([responseDic[@"retCode"] isEqualToString:@"0"]){
            if ([responseDic[@"unreadNum"] isEqualToString:@"0"]) {
                self.UnreadCou.hidden=YES;
            }else{
             self.UnreadCou.hidden=NO;
                self.UnreadCou.text=responseDic[@"unreadNum"];
            }
        }else
        {
          [self showAllTextDialog:responseDic[@"retMsg"]];
        }
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}
- (IBAction)clearTap:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:@"请确认是否要清除缓存！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清除",nil];
    alert.tag = 2;
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2) {
        if (buttonIndex == 0) {
           // [self.navigationController popViewControllerAnimated:YES];
        }
        if (buttonIndex == 1) {
            
            [self clearCache];
        }
    }
}

-(void)clearCache{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        
        NSLog(@"files :%ld",(unsigned long)[files count]);
       // return ;
        for (NSString *p in files) {
            
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}

//提问数和收藏数

-(void)getCounts{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *  userIdz= [user objectForKey:@"userIdz"];
    NSString *  userPwdz= [user objectForKey:@"userPwdz"];
    NSString *  userAccountz= [user objectForKey:@"userAccountz"];
    
    [RequestServer fetchMethodName:@"getNumber" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
        if([responseDic[@"retCode"] isEqualToString:@"0"]){
            self.favoriteCountLab.text=responseDic[@"favoritesNum"] ;
            self.quesCountLab.text=responseDic[@"questionsNum"] ;
        }else
        {
           // [self showAllTextDialog:responseDic[@"retMsg"]];
        }
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}

-(void)clearCacheSuccess{
    [self showAllTextDialog:@"清除成功"];
}
- (IBAction)cancelLoginTap:(id)sender {
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString * ids=[user objectForKey:@"userAccountz"];
    // [user setObject:@""  forKey:@"userAccountz"];
    [user setObject:@""  forKey:@"userPwdz"];
    [user setObject:@""  forKey:@"userIdz"];
    [user setObject:@""  forKey:@"userNamez"];
    
    [user setObject:@""  forKey:@"favoritesNumz"];
    [user setObject:@""  forKey:@"questionsNumz"];
    [user setObject:@""  forKey:@"userIconz"];
    [user synchronize];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = ids;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ccLogin" object:self userInfo:params];
}

@end
