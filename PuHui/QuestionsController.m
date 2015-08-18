//
//  QuestionsController.m
//  PuHui
//
//  Created by rp.wang on 15/7/14.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "QuestionsController.h"
#import "BBRim.h"
#import "RequestServer.h"


@interface QuestionsController ()
@property (strong, nonatomic) NSString *picString;
@property(strong, nonatomic) UIWebView *phoneCallWebView;
@end

@implementation QuestionsController
@synthesize questionId,sendPostCtlr;
//懒加载PhoneAskController SendPostController

- (PhoneAskController *)phoneAskCtlr
{
    if (!_phoneAskCtlr) {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"MyQuestionController" bundle:nil];
       _phoneAskCtlr=[sb instantiateViewControllerWithIdentifier:@"PhoneAskController"];
       _phoneAskCtlr.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49);
    }
    return _phoneAskCtlr;
}
- (SendPostController *)sendPostCtlr
{
    if (!sendPostCtlr) {
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"MyQuestionController" bundle:nil];
        sendPostCtlr=[sb instantiateViewControllerWithIdentifier:@"SendPostController"];
        sendPostCtlr.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49);
        
    }
    return sendPostCtlr;
}

- (NSString *)questionId {
    if (!questionId) {
        questionId = @"";
    }
    return questionId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置两个按钮属性
    if (questionId == nil) {
        questionId = @"";
    }
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithViews:@[self.phoneBtn,self.postBtn] radius:6 width:1 color:[UIColor orangeColor]];
    self.postBtn.backgroundColor=[UIColor orangeColor];
    [self.postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.phoneBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:self.sendPostCtlr.view];
    [self.postBtn setTitle:@"提交" forState:UIControlStateNormal];
}

- (IBAction)phoneTap:(id)sender {
    UIButton *temp = (UIButton *)sender;
    if (temp.backgroundColor == [UIColor orangeColor]) {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:4006126126"]];
        if ( !self.phoneCallWebView ) {
            self.phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        }
        [self.phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
    } else {
        [self.postBtn setTitle:@"发帖提问" forState:UIControlStateNormal];
        [self.sendPostCtlr.view removeFromSuperview];
        [self.view addSubview:self.phoneAskCtlr.view];
        
        self.phoneBtn.backgroundColor=[UIColor orangeColor];
        [self.phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.postBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.postBtn.backgroundColor=[UIColor whiteColor];
    }
}

- (IBAction)postTap:(id)sender {
    UIButton *temp = (UIButton *)sender;
    if (temp.backgroundColor == [UIColor orangeColor]) {
        if ([self.sendPostCtlr.contentField.text isEqualToString:@""]||![self.sendPostCtlr.isEditTV isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请输入提问内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        } else {
            if ([self.sendPostCtlr.oldFied.text isEqualToString:@""]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请输入年龄" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            } else {
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *userId= [user objectForKey:@"userIdz"];
                NSString *userAccount = [user objectForKey:@"userAccountz"];
                NSString *userPwd = [user objectForKey:@"userPwdz"];
                if (self.sendPostCtlr.imageView.image != nil)
                {
                    UIImage *img = self.sendPostCtlr.imageView.image;
                    if (img.size.width>=img.size.height) {
                        CGSize finalSize = CGSizeMake(800, img.size.height / (img.size.width / 800));
                        img = [UIImage imageCompressForSize:img targetSize:finalSize];
                    } else {
                        CGSize finalSize = CGSizeMake(img.size.width / (img.size.height / 800), 800);
                        img = [UIImage imageCompressForSize:img targetSize:finalSize];
                    }
                    NSData *data;
                    data = UIImageJPEGRepresentation(img, 0.75);
                    NSString *pictureDataString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    self.picString = pictureDataString;
                } else {
                    self.picString = @"";
                }
                [RequestServer fetchMethodName:@"question" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"questionId":questionId,@"content":self.sendPostCtlr.contentField.text,@"age":self.sendPostCtlr.oldFied.text,@"gender":self.sendPostCtlr.sex,@"department":@"",@"pic":self.picString} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
                    if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"提问成功，请等待医师解答" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        alert.tag = 2;
                        [alert setDelegate:self];
                        [alert show];
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:responseDic[@"retMsg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        alert.tag = 2;
                        [alert setDelegate:self];
                        [alert show];
                    }
                    NSString *temp = responseDic[@"retMsg"];
                    NSLog(@"%@",temp);
                } failureHandler:^(NSString *errorInfo) {
                    NSLog(@"%@",errorInfo);
                }];
            }
        }
    } else {
        [self.postBtn setTitle:@"提交" forState:UIControlStateNormal];
        [self.phoneAskCtlr.view removeFromSuperview];
        [self.view addSubview:self.sendPostCtlr.view];
        self.postBtn.backgroundColor=[UIColor orangeColor];
        [self.postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.phoneBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.phoneBtn.backgroundColor=[UIColor whiteColor];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
