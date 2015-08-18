//
//  InternalReconmmendControlller.m
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "InternalReconmmendControlller.h"
#import "BBRim.h"
#import "SelectSetMealController.h"
#import "RecomMealModel.h"
#import "JKAlertDialog.h"
#import "NSObject+MJKeyValue.h"
#import "NSObject+MJMember.h"
#import "SelectSetMealCell.h"
#import "RecommendController.h"
#import <MessageUI/MessageUI.h>
#import "NSString+Extension.h"
#import "InternalRecmCell.h"
#import "MBProgressHUD.h"

@interface InternalReconmmendControlller () <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *nameView;
@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) IBOutlet UIView *selectView;
- (IBAction)buttonClick;
@property (weak, nonatomic) IBOutlet UIImageView *imageVbtn1;
@property (weak, nonatomic) IBOutlet UIImageView *imageVbtn2;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UILabel *selectMel;
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic) NSMutableArray *tempMuta;
@property (strong, nonatomic) UITableView *slectMeal;
@property (strong, nonatomic) JKAlertDialog *myAlert;
@property (strong, nonatomic) NSString *isManSex;
@property (strong, nonatomic) IBOutlet UIButton *recommBtn;

@property (strong, nonatomic) IBOutlet UIImageView *arrowIcon;


@property (strong, nonatomic) NSString * mealNamez;
@property (assign, nonatomic) NSString * pacgID;
@property (assign, nonatomic) NSString * retailz;
@property (assign, nonatomic) NSString * costz;
@property (strong, nonatomic)  MBProgressHUD *HUD;

@end



@implementation InternalReconmmendControlller
//懒加载
//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
//*筛选临时的模型数据*/
- (NSMutableArray *)tempMuta
{
    if (!_tempMuta) {
        _tempMuta=[[NSMutableArray alloc]init];
    }
    return _tempMuta;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isManSex=@"男";
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithViews:@[self.nameView,self.phoneView,self.selectView] radius:4 width:1 color:[UIColor grayColor]];
    [self.recommBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _imageVbtn1.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UesrClicked1:)];
    [_imageVbtn1 addGestureRecognizer:singleTap1];
    [self.view addSubview:_imageVbtn1];
   
    _imageVbtn2.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(UesrClicked2:)];
    [_imageVbtn2 addGestureRecognizer:singleTap2];
    self.imageVbtn2 = _imageVbtn2;
    [self.view addSubview:_imageVbtn2];
    
    _selectMel.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userClicked3:)];
    [_selectMel addGestureRecognizer:singleTap3];
    self.selectMel = _selectMel;
    [self.view addSubview:_selectMel];
    
    _arrowIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userClicked3:)];
    [_arrowIcon addGestureRecognizer:singleTap4];
    self.arrowIcon = _arrowIcon;
    [self.view addSubview:_arrowIcon];
    
}

- (void)UesrClicked1:(UITapGestureRecognizer *)sender{

    [_imageVbtn1 setImage:[UIImage imageNamed:@"inrcm_select"]];
    [_imageVbtn2 setImage:[UIImage imageNamed:@"inrcm_notselect"]];
    self.isManSex=@"男";
}

- (void)UesrClicked2:(UITapGestureRecognizer *)sender{
    [_imageVbtn2 setImage:[UIImage imageNamed:@"inrcm_select"]];
    [_imageVbtn1 setImage:[UIImage imageNamed:@"inrcm_notselect"]];
    self.isManSex=@"女";
}

- (void)userClicked3:(UIGestureRecognizer *)sender{
    _slectMeal=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 270, 1000) style:UITableViewStylePlain];
    _slectMeal.delegate = self;
    _slectMeal.dataSource = self;
    JKAlertDialog *alert = [[JKAlertDialog alloc]initWithTitle:@"提示" message:@""];
    alert.contentView =  _slectMeal;
    [alert addButtonWithTitle:@"取消"];
     _myAlert = alert;
    [alert show];
    [self setMealInfo];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.arrysMuta.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   InternalRecmCell *cell = (InternalRecmCell *)[tableView cellForRowAtIndexPath:indexPath];
    _selectMel.text=cell.mealName.text;
    self.pacgID= cell.mealID.text;
    self.retailz=cell.mealDetail.text;
    self.costz=cell.mealCost.text;
    if ([cell.mealName.text containsString:@"女"]) {
        [_imageVbtn2 setImage:[UIImage imageNamed:@"inrcm_select"]];
        [_imageVbtn1 setImage:[UIImage imageNamed:@"inrcm_notselect"]];
        self.isManSex=@"女";
    }else{
        [_imageVbtn1 setImage:[UIImage imageNamed:@"inrcm_select"]];
        [_imageVbtn2 setImage:[UIImage imageNamed:@"inrcm_notselect"]];
        self.isManSex=@"男";
    }
    
    
    [_myAlert dismiss];
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *alert = (UIAlertView*)[theTimer userInfo];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    alert =NULL;
}

- (IBAction)buttonClick {
    if ([self.nameTF.text trim]==nil||[[self.nameTF.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入被推荐人姓名！"];
    }else if ([self.phoneTF.text trim]==nil||[[self.phoneTF.text trim] isEqualToString:@""]) {
        [self showAllTextDialog:@"请输入手机号码！"];
    }else if( ![self isPhoneNum:[self.phoneTF.text trim]] ){
        [self showAllTextDialog:@"请输入正确的手机号码！"];
    }else if([self.selectMel.text isEqualToString:@"套餐选择"]){
        [self showAllTextDialog:@"请选择套餐！"];
    }
//    if (([_nameTF.text isEqualToString:@""]||_nameTF.text == nil)||([_phoneTF.text isEqualToString:@""]||_phoneTF.text == nil)||(([_nameTF.text isEqualToString:@""]||_nameTF.text == nil)&&([_phoneTF.text isEqualToString:@""]||_phoneTF.text == nil))) {
//        UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:nil message:@"输入内容不能为空" delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
//        [NSTimer scheduledTimerWithTimeInterval:1.5f
//                                         target:self
//                                       selector:@selector(timerFireMethod:)
//                                       userInfo:alert
//                                        repeats:YES];
//        [alert show];
    else{
        [self recommDatas];
        
        

    }
}


//18591980191
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if( [MFMessageComposeViewController canSendText] ){
            
            MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
            
            controller.recipients = [NSArray arrayWithObject:self.phoneTF.text];
            //controller.body = @"您申请的健康体检专项体检计划已经通过，密码【" + self.recommendCode! + "】有效期15天，持此码在【普惠】所有分院享受7折优惠，垂询4006126126.";
            controller.body = @"这是普惠的测试信息，我随便写的，不要惊讶！";
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
            [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"推荐短信"];
        }else{
            [self alertWithTitle:@"提示信息" msg:@"设备没有短信功能"];
        }
    }else{
        
        
    }
    _nameTF.text = @"";
    _phoneTF.text = @"";
    _isManSex = @"";
    _selectMel.text = @"套餐选择";
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
        
        [_slectMeal reloadData];
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
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
                @"app_serv_record.name":self.nameTF.text,
                @"app_serv_record.mobile":self.phoneTF.text,
                @"app_serv_record.sex":self.isManSex} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {

                    if(![responseDic[@"app_serv_record"] isEqualToString:@"null"]){
                   
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil  message:@"推荐成功，发送短信" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确定", nil];
                        
                                [alert show];
                        
                        
                    }else{
                     [self showAllTextDialog:@"推荐失败！"];
                    }
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
   }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
