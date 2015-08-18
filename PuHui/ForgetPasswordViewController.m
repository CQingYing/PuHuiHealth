//
//  ForgetPasswordViewController.m
//  PuHui
//
//  Created by administrator on 15/7/28.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "Masonry.h"
#import "RequestServer.h"

@interface ForgetPasswordViewController ()
@property (strong, nonatomic) UITextField *phoneText;
@property (strong, nonatomic) UITextField *numbnerText;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *phone;
@property (assign, nonatomic) int countTimes;
@property (strong, nonatomic) UILabel *getNumberLabel;
@property (strong, nonatomic) UIButton *getNumber;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UILabel *phoneLabel = [[UILabel alloc] init];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [phoneLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    phoneLabel.text = @"手机号：";
    [phoneLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.width.mas_equalTo(@80);
    }];
    self.phoneText = [[UITextField alloc] init];
    [self.phoneText setDelegate:self];
    [self.view addSubview:self.phoneText];
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_right);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.centerY.equalTo(phoneLabel.mas_centerY);
        make.height.equalTo(phoneLabel.mas_height).offset(10);
    }];
    UIImage *bigbox = [UIImage imageNamed:@"big box"];
    [self.phoneText setBackground:bigbox];
    UILabel *numberLabel = [[UILabel alloc] init];
    [numberLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    numberLabel.text = @"验证码：";
    [numberLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_left);
        make.top.equalTo(phoneLabel.mas_bottom).offset(30);
        make.height.equalTo(phoneLabel.mas_height);
        make.width.equalTo(phoneLabel.mas_width);
    }];
    self.getNumber = [[UIButton alloc] init];
    [self.view addSubview:self.getNumber];
    [self.getNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.phoneText.mas_right);
        make.centerY.equalTo(numberLabel.mas_centerY);
        make.height.equalTo(self.phoneText.mas_height);
        make.width.mas_equalTo(@110);
    }];
    UIImage *getNumberImage = [UIImage imageNamed:@"orange box"];
    [self.getNumber setBackgroundImage:getNumberImage forState:UIControlStateNormal];
    self.getNumberLabel = [[UILabel alloc] init];
    [self.getNumber addSubview:self.getNumberLabel];
    [self.getNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.getNumber);
    }];
    [self.getNumberLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [self.getNumberLabel setTextColor:[UIColor grayColor]];
    self.getNumberLabel.text = @"获取验证码";
    [self.getNumberLabel setTextAlignment:NSTextAlignmentCenter];
    self.numbnerText = [[UITextField alloc] init];
    [self.numbnerText setDelegate:self];
    [self.view addSubview:self.numbnerText];
    UIImage *smallbox = [UIImage imageNamed:@"small box"];
    [self.numbnerText setBackground:smallbox];
    [self.numbnerText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.getNumber);
        make.left.equalTo(self.phoneText.mas_left);
        make.right.equalTo(self.getNumber.mas_left).offset(-10);
    }];
    
    UIButton *sureButton = [[UIButton alloc] init];
    [self.view addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_left);
        make.right.equalTo(self.phoneText.mas_right);
        make.top.equalTo(numberLabel.mas_bottom).offset(150);
        make.height.mas_equalTo(@50);
    }];
    UIImage *sureImage = [UIImage imageNamed:@"button1"];
    [sureButton setBackgroundImage:sureImage forState:UIControlStateNormal];
    UILabel *sureLabel = [[UILabel alloc] init];
    [sureButton addSubview:sureLabel];
    [sureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sureButton);
    }];
    sureLabel.text = @"确定";
    [sureLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [sureLabel setTextColor:[UIColor whiteColor]];
    [sureLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.getNumber addTarget:self action:@selector(getNumberClicked) forControlEvents:UIControlEventTouchUpInside];
    [sureButton addTarget:self action:@selector(sureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)getNumberClicked
{
    [self.getNumber setEnabled:NO];
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch = [phoneTest evaluateWithObject:self.phoneText.text];
    if (isMatch) {
        [RequestServer fetchMethodName:@"getVerifyCode" parameters:@{@"userId":@"",@"userAccount":@"",@"userPwd":@"",@"phone":self.phoneText.text} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            self.code = responseDic[@"verifyCode"];
            self.phone = self.phoneText.text;
            NSString *temp = responseDic[@"retCode"];
            if ([temp isEqualToString:@"0"]) {
                self.countTimes=60;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"验证码即将发送至您的手机，请注意查收" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:responseDic[@"retMsg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
        } failureHandler:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
        }];
    } else {
        UIAlertView *alerts = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alerts show];
    }
}
-(void)countTime{
    if (self.countTimes >= 1) {
        self.countTimes--;
        self.getNumberLabel.text = [NSString stringWithFormat:@"%d秒后重发",self.countTimes];
    } else {
        self.getNumberLabel.text = @"获取验证码";
        [self.getNumber setEnabled:YES];
        [self.timer invalidate];
    }
}
-(void)sureButtonClicked
{
    if ([self.phoneText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请输入手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    } else if ([self.numbnerText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请输入验证码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    } else {
        if ([self.phoneText.text isEqual:self.phone]&&[self.numbnerText.text isEqual:self.code]) {
            [RequestServer fetchMethodName:@"forgotPassword" parameters:@{@"userAccount":self.phoneText.text} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"密码即将发送至您的手机，请注意查收" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [self.navigationController popViewControllerAnimated:YES];
            } failureHandler:^(NSString *errorInfo) {
                NSLog(@"%@",errorInfo);
            }];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"验证码错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
