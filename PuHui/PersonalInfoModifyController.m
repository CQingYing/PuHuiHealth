//
//  PersonalInfoModifyController.m
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "PersonalInfoModifyController.h"
#import "BBRim.h"
#import "IQKeyboardManager.h"
#import "MainTabBarController.h"
#import "HomePageController.h"
#import "RequestServer.h"
#import "RecomMealModel.h"
#import "NSObject+MJKeyValue.h"
#import "NSString+Extension.h"
#import "MBProgressHUD.h"
#import "PersonController.h"
#import "UIImageView+WebCache.h"
#import "PersonalCenterLoginController.h"

@interface PersonalInfoModifyController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *personView;
@property (strong, nonatomic) IBOutlet UIButton *photoBtn;
@property (strong, nonatomic) IBOutlet UIButton *nicknameBtn;
@property (strong, nonatomic) IBOutlet UIButton *pwBtn;
@property (strong, nonatomic) IBOutlet UIImageView *personImg;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  UIImage *img;


@property (assign,nonatomic)CGFloat viewHeight;
// 蒙版
@property (strong, nonatomic)  UIView *boardView;
// 昵称修改
@property (strong, nonatomic)  UIView *modifyNickname;
@property (strong, nonatomic)  UIButton *deleBtn;
@property (strong, nonatomic)  UIButton *sureBtn;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UITextField *nicknameTxtFid;
//  密码修改
@property (strong, nonatomic)  UIView *modifyPW;
@property (strong, nonatomic)  UIButton *deleBtnPW;
@property (strong, nonatomic)  UIButton *sureBtnPW;
@property (strong, nonatomic)  UILabel *pwLabel;
@property (strong, nonatomic)  UITextField *oldPWTxtFid;
@property (strong, nonatomic)  UITextField *nePWTxtFid;
@property (strong, nonatomic)  UITextField *reNewPWTxtFid;
//修改头像
@property (strong, nonatomic)  UIView *photo;
@property (strong, nonatomic)  UILabel *titlePhoto;
@property (strong, nonatomic)  UIImageView *linePhoto;
@property (strong, nonatomic)  UIButton *photograph;
@property (strong, nonatomic)  UIButton *selfPhoto;
@property (strong, nonatomic)  UIButton *cancelPhoto;
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  NSString *imagePath;

@property(strong, nonatomic) NSMutableArray *tempMuta;
@property(strong, nonatomic) NSMutableArray *arrysMuta;

@property (strong, nonatomic) IBOutlet UIButton *cencelLogin;
@property(strong, nonatomic) NSString *iconUrl;
@property(strong, nonatomic) NSString *userName;
@property(strong, nonatomic) NSString *passWord;
@property(strong, nonatomic) NSString *pictureStr;
@property (strong, nonatomic)  UIButton *leftBtn;
@end

@implementation PersonalInfoModifyController
//懒加载
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}

- (NSMutableArray *)tempMuta
{
    if (!_tempMuta) {
        _tempMuta=[[NSMutableArray alloc]init];
    }
    return _tempMuta;
}

//懒加载-昵称修改
- (UIView *)boardView
{
    if (!_boardView) {
        _boardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _boardView.backgroundColor=[UIColor blackColor];
        _boardView.alpha=0.4;
    }
    return _boardView;
}

- (UIButton *)deleBtn
{
    if (!_deleBtn) {
        _deleBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 8, 40, 40)];
        [_deleBtn setImage:[UIImage imageNamed:@"person_dele"] forState:UIControlStateNormal];
    }
    return _deleBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-56, 8, 40, 40)];
        [_sureBtn setImage:[UIImage imageNamed:@"person_finish"] forState:UIControlStateNormal];
    }
    return _sureBtn;
}
- (UIView *)modifyNickname
{
    if (!_modifyNickname) {
        _modifyNickname=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*0.5-50, self.view.frame.size.width, 100)];
        _modifyNickname.backgroundColor=[UIColor whiteColor];
      
    }
    return _modifyNickname;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width)*0.5-50, 12,100, 30)];
        _nameLabel.text=@"编辑昵称";
        _nameLabel.font=[UIFont systemFontOfSize:22];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.textColor=[UIColor blackColor];
        
    }
    
    return _nameLabel;
}
- (UITextField *)nicknameTxtFid
{
    if (!_nicknameTxtFid) {
        _nicknameTxtFid=[[UITextField alloc]initWithFrame:CGRectMake(16,56,self.view.frame.size.width-32,30)];
        _nicknameTxtFid.placeholder=@"昵称为1-10位的汉子字母或数字";
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_nicknameTxtFid radius:4 width:1 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    }
    
    return _nicknameTxtFid;
}

//懒加载-密码

- (UIButton *)deleBtnPW
{
    if (!_deleBtnPW) {
        _deleBtnPW = [[UIButton alloc] initWithFrame:CGRectMake(16, 8, 40, 40)];
        [_deleBtnPW setImage:[UIImage imageNamed:@"person_dele"] forState:UIControlStateNormal];
    }
    return _deleBtnPW;
}

- (UIButton *)sureBtnPW
{
    if (!_sureBtnPW) {
        _sureBtnPW = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-56, 8, 40, 40)];
        [_sureBtnPW setImage:[UIImage imageNamed:@"person_finish"] forState:UIControlStateNormal];
    }
    return _sureBtnPW;
}
- (UIView *)modifyPW
{
    if (!_modifyPW) {
        _modifyPW=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*0.5-88, self.view.frame.size.width, 100+38*2)];
        _modifyPW.backgroundColor=[UIColor whiteColor];
        
    }
    return _modifyPW;
}

- (UILabel *)pwLabel
{
    if (!_pwLabel) {
        _pwLabel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width)*0.5-50, 12,100, 30)];
        _pwLabel.text=@"密码修改";
        _pwLabel.font=[UIFont systemFontOfSize:22];
        _pwLabel.textAlignment=NSTextAlignmentCenter;
        _pwLabel.textColor=[UIColor blackColor];
        
    }
    
    return _pwLabel;
}
- (UITextField *)oldPWTxtFid
{
    if (!_oldPWTxtFid) {
        _oldPWTxtFid=[[UITextField alloc]initWithFrame:CGRectMake(16,56,self.view.frame.size.width-32,30)];
        _oldPWTxtFid.placeholder=@"请输入原始密码";
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_oldPWTxtFid radius:4 width:1 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    }
    
    return _oldPWTxtFid;
}

- (UITextField *)nePWTxtFid
{
    if (!_nePWTxtFid) {
        _nePWTxtFid=[[UITextField alloc]initWithFrame:CGRectMake(16,56+38,self.view.frame.size.width-32,30)];
        _nePWTxtFid.placeholder=@"请输入新密码";
        _nePWTxtFid.secureTextEntry=YES;
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_nePWTxtFid radius:4 width:1 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    }
    return _nePWTxtFid;
}

- (UITextField *)reNewPWTxtFid
{
    if (!_reNewPWTxtFid) {
        _reNewPWTxtFid=[[UITextField alloc]initWithFrame:CGRectMake(16,56+38*2,self.view.frame.size.width-32,30)];
        _reNewPWTxtFid.placeholder=@"请再次输入新密码";
        _reNewPWTxtFid.secureTextEntry=YES;
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_reNewPWTxtFid radius:4 width:1 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    }
    
    return _reNewPWTxtFid;
}

//懒加载-修改头像
- (UIView *)photo
{
    if (!_photo) {
        _photo=[[UIView alloc]initWithFrame:CGRectMake(16,self.view.frame.size.height*0.5-88-5,self.view.frame.size.width-32,110+38*2)];
        _photo.backgroundColor=[UIColor whiteColor];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_photo radius:4 width:1 color:[UIColor clearColor]];
    }

    return _photo;
}
- (UILabel *)titlePhoto
{
    if (!_titlePhoto) {
        _titlePhoto=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width)*0.5-50-16, 12,100, 30)];
        _titlePhoto.text=@"上传照片";
        _titlePhoto.font=[UIFont systemFontOfSize:22];
        _titlePhoto.textAlignment=NSTextAlignmentCenter;
        _titlePhoto.textColor=[UIColor blackColor];
        
    }
    
    return _titlePhoto;
}

- (UIImageView *)linePhoto
{
    if (!_linePhoto) {
        _linePhoto=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50,self.view.frame.size.width-32, 1)];
        [_linePhoto setImage:[UIImage imageNamed:@"photo_line"]];
        
    }
    
    return _linePhoto;
}
- (UIButton *)photograph
{
    if (!_photograph) {
        _photograph=[[UIButton alloc]initWithFrame:CGRectMake(8, 60,self.view.frame.size.width-48, 30)];
        [_photograph setImage:[UIImage imageNamed:@"photo_camera"] forState:UIControlStateNormal];
        [_photograph setTitle:@"拍照" forState:UIControlStateNormal];
        [_photograph setTitleColor:[UIColor colorWithRed:171/255 green:173/255 blue:179/255 alpha:0.6] forState:UIControlStateNormal];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_photograph radius:4 width:1 color:[UIColor colorWithRed:171/255 green:173/255 blue:179/255 alpha:0.3]];
    }
    return _photograph;
}

- (UIButton *)selfPhoto
{
    if (!_selfPhoto) {
        _selfPhoto=[[UIButton alloc]initWithFrame:CGRectMake(8, 60+38,self.view.frame.size.width-48, 30)];
        [_selfPhoto setImage:[UIImage imageNamed:@"photo_image"] forState:UIControlStateNormal];
        [_selfPhoto setTitle:@"从相册中选取" forState:UIControlStateNormal];
         [_selfPhoto setTitleColor:[UIColor colorWithRed:171/255 green:173/255 blue:179/255 alpha:0.6] forState:UIControlStateNormal];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_selfPhoto radius:4 width:1 color:[UIColor colorWithRed:171/255 green:173/255 blue:179/255 alpha:0.3]];
    }
    
    return _selfPhoto;
}

- (UIButton *)cancelPhoto
{
    if (!_cancelPhoto) {
        _cancelPhoto=[[UIButton alloc]initWithFrame:CGRectMake(8, 60+38*2,self.view.frame.size.width-48, 30)];
        [_cancelPhoto setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelPhoto setTitleColor:[UIColor colorWithRed:171/255 green:173/255 blue:179/255 alpha:0.6] forState:UIControlStateNormal];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_cancelPhoto radius:4 width:1 color:[UIColor colorWithRed:171/255 green:173/255 blue:179/255 alpha:0.3]];
    }
    
    return _cancelPhoto;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"基本资料";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(tagHome) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];

    
    self.personImg.image=self.image;
    // 设置边框
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.personView radius:4 width:1 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    [rim bb_rimWithView:self.personImg radius:40 width:2 color:[UIColor colorWithRed:123/255 green:123/255 blue:123/255 alpha:0.3]];
    //设置navigationItem
    UIButton *homeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //171 3 9
    [homeBtn setImage:[UIImage imageNamed:@"person_home"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(tagHome) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:homeBtn];
    [[IQKeyboardManager sharedManager] setEnable:YES];
   // [self  addKeyboradNotification];
    
    //设置头像中按钮addtarget方法
    [self.cancelPhoto addTarget:self action:@selector(phCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.selfPhoto addTarget:self action:@selector(LocalPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.photograph addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    
    //弹出层addTarget事件
    [self.deleBtn addTarget:self action:@selector(nicknameDel) forControlEvents:UIControlEventTouchUpInside];
    [self.deleBtnPW addTarget:self action:@selector(pwDel) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtn addTarget:self action:@selector(nickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.sureBtnPW addTarget:self action:@selector(pwSureBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self passByValue];
}

- (void)passByValue{
    
//    [self showAllTextDialog:self.image];
//    [self showAllTextDialog:self.name];
    
    self.nickName.text = self.name;
   // NSString *tempStr=[PHJKRequestUrl stringByAppendingString:self.image];
  //  [self.personImg  sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"person_Head"]];
}
- (IBAction)nicknameModify:(id)sender
{
    [self.view addSubview:self.boardView];
    [self.view addSubview:self.modifyNickname];
    [self.modifyNickname addSubview:self.deleBtn];
    [self.modifyNickname addSubview:self.sureBtn];
    [self.modifyNickname addSubview:self.nameLabel];
    [self.modifyNickname addSubview:self.nicknameTxtFid];
    [self.nicknameTxtFid becomeFirstResponder];
}
- (IBAction)passwordModify:(id)sender {
    [self.view addSubview:self.boardView];
    [self.view addSubview:self.modifyPW];
    [self.modifyPW addSubview:self.deleBtnPW];
    [self.modifyPW addSubview:self.sureBtnPW];
    [self.modifyPW addSubview:self.pwLabel];
    [self.modifyPW addSubview:self.oldPWTxtFid];
    [self.modifyPW addSubview:self.nePWTxtFid];
    [self.modifyPW addSubview:self.reNewPWTxtFid];
    [self.oldPWTxtFid becomeFirstResponder];
}
- (IBAction)photoModify:(id)sender {
    [self.view addSubview:self.boardView];
    [self.view addSubview:self.photo];
    [self.photo addSubview:self.titlePhoto];
    [self.photo addSubview:self.linePhoto];
    [self.photo addSubview:self.photograph];
    [self.photo addSubview:self.selfPhoto];
    [self.photo addSubview:self.cancelPhoto];
    
}
//navigationItem的点击事件  HomePageController
-(void)tagHome{
    [self.navigationController popViewControllerAnimated:YES];
  
}
//设置头像按钮点击事件
-(void)phCancel
{
    [self.photo removeFromSuperview];
    [self.boardView removeFromSuperview];
}

//从相册提取图片
- (void)LocalPhoto{
 
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentModalViewController:picker animated:YES];
    [self.photo removeFromSuperview];
    [self.boardView removeFromSuperview];

}

//使用相机拍照
- (void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    UIImagePickerControllerQualityType qualityType = UIImagePickerControllerQualityTypeHigh;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        picker.videoQuality = qualityType;
        [self presentModalViewController:picker animated:YES];
    }
    else
    {
        NSLog(@"该设备无摄像头");
    }
    [self.photo removeFromSuperview];
    [self.boardView removeFromSuperview];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    if (image != nil)
    {
        self.img=image;
        
        
        
        UIGraphicsBeginImageContext(CGSizeMake(240, 240));
        
        // 绘制改变大小的图片
        
        [image drawInRect:CGRectMake(0, 0, 240, 240)];
        
        // 从当前context中创建一个改变大小后的图片
        
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 使当前的context出堆栈
        
        UIGraphicsEndImageContext();
        
        
        //[self showAllTextDialog:[NSString stringWithFormat:@"%f,%f",scaledImage.size.width,scaledImage.size.height]];
        NSData *data;
        if (UIImagePNGRepresentation(scaledImage))
        {
            data = UIImagePNGRepresentation(scaledImage);
            NSString *pictureDataString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            self.pictureStr = pictureDataString;
        }
        else
        {
            data = UIImageJPEGRepresentation(scaledImage, 1.0);
            NSString *pictureDataString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            self.pictureStr = pictureDataString;
        }
    }
    /* 关闭相册界面 */
    [picker dismissModalViewControllerAnimated:YES];
    [self getPhotoInfo];
    [self notif];
    
}
-(void)notif{
    // 取得ios系统唯一的全局的广播站 通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //设置广播内容
    NSString *str = self.pictureStr;
    UIImage *imgView=self.personImg.image;
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          str, @"baseImg" ,
                          imgView, @"img" ,nil];
    //将内容封装到广播中 给ios系统发送广播
    [nc postNotificationName:@"ChangeImageNotification" object:self userInfo:dict];
}
-(void)nicknameDel
{
    [self.modifyNickname removeFromSuperview];
    [self.boardView removeFromSuperview];
}
-(void)nickSureBtn{
    [self getUserNameInfo];
    
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

- (void)obtainNickName{
    NSNotificationCenter *pc = [NSNotificationCenter defaultCenter];
    NSString *nickName = self.nicknameTxtFid.text;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:nickName,@"nickNamez", nil];
    [pc postNotificationName:@"changNameNotification" object:self userInfo:dic];
}
-(void)pwDel
{
    [self.modifyPW removeFromSuperview];
    [self.boardView removeFromSuperview];
}

-(void)pwSureBtn{
    [self getPassWordInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
  //修改昵称
- (void)getUserNameInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
//    if(!((self.nicknameTxtFid.text.length<=10)&&(self.nicknameTxtFid.text.length>=1))){
//        [self showAllTextDialog:@"昵称为1-10位的汉字字母或数字"];
//        return;
//    }
    if(![self isNicknames:self.nicknameTxtFid.text]){
        [self showAllTextDialog:@"昵称为2-10位的汉字字母或数字"];
        return;
    }
    [RequestServer fetchMethodName:@"modifyUserName" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"userName":self.nicknameTxtFid.text} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        
        if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
            
            self.nickName.text = self.nicknameTxtFid.text;
            [user setObject:self.nicknameTxtFid.text forKey:@"userNamez"];
        }
        NSString *retMsg=responseDic[@"retMsg"];
        [self showAllTextDialog:retMsg];
        [self obtainNickName];
        [self.modifyNickname removeFromSuperview];
        [self.boardView removeFromSuperview];
        
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}
   //修改头像
- (void)getPhotoInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
  
    [RequestServer fetchMethodName:@"modifyUserIcon" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"userIcon":self.pictureStr} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        
        if ([responseDic[@"retCode"]isEqualToString:@"0"]) {
            [self.personImg setImage:self.img];
             NSString *iconURL=responseDic[@"iconURL"];
            [user setObject:iconURL forKey:@"userIconz"] ;
            [self notif];
        }
        NSString *retMsg=responseDic[@"retMsg"];
       [self showAllTextDialog:retMsg];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
    
    
}
   //修改密码
- (void)getPassWordInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    if ([[self.oldPWTxtFid.text trim] isEqualToString:@""]||[self.oldPWTxtFid.text trim]==nil) {
        [self showAllTextDialog:@"请输入原密码"];
        return ;
    }
    if ([[self.nePWTxtFid.text trim] isEqualToString:@""]||[self.nePWTxtFid.text trim]==nil) {
        [self showAllTextDialog:@"请输入新密码"];
        return ;
    }
    if ([[self.reNewPWTxtFid.text trim] isEqualToString:@""]||[self.reNewPWTxtFid.text trim]==nil) {
        [self showAllTextDialog:@"请再次输入新密码"];
        return ;
    }
    if (![self.oldPWTxtFid.text isEqualToString:userPwd]) {
        [self showAllTextDialog:@"请确认原密码是否正确"];
        return ;
    }
    if (![self.reNewPWTxtFid.text isEqualToString:self.nePWTxtFid.text]) {
        [self showAllTextDialog:@"两次新密码不同"];
        return ;
    }
    if ([self.oldPWTxtFid.text isEqualToString:self.nePWTxtFid.text]) {
        [self showAllTextDialog:@"新密码不能等于原密码"];
        return ;
    }
    if (![self isPasswd:self.nePWTxtFid.text]) {
        [self showAllTextDialog:@"请输入6到20位字母数字组合密码"];
        return ;
    }
   
    [RequestServer fetchMethodName:@"modifyPassword" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"newPwd":self.nePWTxtFid.text} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        
       // userPwdz
        if ([responseDic[@"retCode"]isEqualToString:@"0"]) {
           // [user setObject:@""  forKey:@"userAccountz"];
            [user setObject:@""  forKey:@"userPwdz"];
            [user setObject:@""  forKey:@"userIdz"];
            [user setObject:@""  forKey:@"userNamez"];
            
            [user setObject:@""  forKey:@"favoritesNumz"];
            [user setObject:@""  forKey:@"questionsNumz"];
            [user setObject:@""  forKey:@"userIconz"];
            
            
            [user synchronize];
            
//            //修改成功
            NSString *retMsg=responseDic[@"retMsg"];
            [self showAllTextDialog:@"密码修改成功，请重新登录"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"AAA",@"MIMA", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"mdfLogin" object:self userInfo:dic];
        }else
        {
            NSString *retMsg=responseDic[@"retMsg"];
            [self showAllTextDialog:retMsg];
        }
       
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}
  //消息提示
- (void)showAllTextDialog:(NSString *)str{
    UIWindow *win=[[UIApplication sharedApplication].windows lastObject];
    self.HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.mode = MBProgressHUDModeText;
    [win addSubview:self.HUD];
    self.HUD.dimBackground = YES;
    self.HUD.labelText = str;
    [self.HUD hide:YES afterDelay:2];
    self.HUD.removeFromSuperViewOnHide = YES;
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
    //[0-9 | A-Z | a-z]{6,16}      ^[0-9a-zA-Z\u4e00-\u9fa5]{1,10}$
    NSString *passwdRegex = @"^[0-9a-zA-Z\u4e00-\u9fa5]{2,10}$";
    NSPredicate* passwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwdRegex];
    if ([passwdTest evaluateWithObject:nicknames]) {
        return  YES;
    }else {
        return NO;
    }
}
@end
