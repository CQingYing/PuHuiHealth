//
//  QuestionDetailController.m
//  PuHui
//
//  Created by rp.wang on 15/7/15.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "QuestionDetailController.h"
#import "RequestServer.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "QuestionsController.h"
#import "UIImageView+WebCache.h"
#import "LQUITapGestureRecognizer.h"

@interface QuestionDetailController ()
@property (strong, nonatomic) UILabel *qstLabel;
@property (strong, nonatomic) UIView *qstView;
@property (strong, nonatomic) UIButton *contuQstBtn;
@property (strong, nonatomic) UIButton *finishQstBtn;
@property (strong, nonatomic) UIView *lastView;
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic) NSMutableArray *tempMuta;
@property (strong, nonatomic) UIScrollView *mainScroll;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UIScrollView *imageScrollView;
@end

@implementation QuestionDetailController
@synthesize questionId,questionDetailData,whereComeIn,gender,age;

- (NSMutableArray *)arrysMuta {
    if (!_arrysMuta) {
        _arrysMuta = [[NSMutableArray alloc] init];
    }
    return _arrysMuta;
}

- (NSMutableArray *)tempMuta {
    if (!_tempMuta) {
        _tempMuta = [[NSMutableArray alloc] init];
    }
    return _tempMuta;
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
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.mainScroll = [[UIScrollView alloc] init];
    self.contentView = [[UIView alloc] init];
    [self.view addSubview:self.mainScroll];
    [self.mainScroll addSubview:self.contentView];
    [self.mainScroll setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.contentView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.lastView = nil;
    
    UITabBar *tabbar = [[UITabBar alloc] init];
    [self.view addSubview:tabbar];
    [tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    [self.mainScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(tabbar.mas_top);
        make.top.equalTo(self.view);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScroll);
        make.width.equalTo(self.mainScroll.mas_width);
    }];
    self.contuQstBtn = [[UIButton alloc] init];
    [tabbar addSubview:self.contuQstBtn];
    [self.contuQstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabbar.mas_bottom).offset(-5);
        make.right.equalTo(tabbar.mas_right).offset(-10);
        make.top.equalTo(tabbar.mas_top).offset(5);
        make.width.equalTo(tabbar.mas_width).multipliedBy(0.22);
    }];
    [self.contuQstBtn setBackgroundColor:[UIColor orangeColor]];
    UILabel *settleLabel = [[UILabel alloc] init];
    [settleLabel setTextAlignment:NSTextAlignmentCenter];
    settleLabel.text = @"继续提问";
    [settleLabel setTextColor:[UIColor whiteColor]];
    [self.contuQstBtn addSubview:settleLabel];
    [settleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contuQstBtn);
    }];
    self.contuQstBtn.layer.cornerRadius = 5;
    self.contuQstBtn.layer.masksToBounds = YES;
    
    self.finishQstBtn = [[UIButton alloc] init];
    [tabbar addSubview:self.finishQstBtn];
    [self.finishQstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabbar.mas_bottom).offset(-5);
        make.right.equalTo(self.contuQstBtn.mas_left).offset(-10);
        make.top.equalTo(tabbar.mas_top).offset(5);
        make.width.equalTo(tabbar.mas_width).multipliedBy(0.22);
    }];
    [self.finishQstBtn setBackgroundColor:[UIColor whiteColor]];
    UILabel *deleteLabel = [[UILabel alloc] init];
    [deleteLabel setTextAlignment:NSTextAlignmentCenter];
    deleteLabel.text = @"结束提问";
    [deleteLabel setTextColor:[UIColor orangeColor]];
    [self.finishQstBtn addSubview:deleteLabel];
    [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.finishQstBtn);
    }];
    self.finishQstBtn.layer.cornerRadius = 5;
    self.finishQstBtn.layer.masksToBounds = YES;
    self.finishQstBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    self.finishQstBtn.layer.borderWidth = 1;
    
    [self.contuQstBtn addTarget:self action:@selector(contineQus) forControlEvents:UIControlEventTouchUpInside];
    [self.finishQstBtn addTarget:self action:@selector(finishQus) forControlEvents:UIControlEventTouchUpInside];
    
    if ([whereComeIn isEqualToString:@"0"]) {
        [self.contuQstBtn setEnabled: NO];
        [self.contuQstBtn setAlpha:0.5];
    } else if ([whereComeIn isEqualToString:@"2"]) {
        [self.contuQstBtn setEnabled: NO];
        [self.contuQstBtn setAlpha:0.5];
        [self.finishQstBtn setEnabled: NO];
        [self.finishQstBtn setAlpha:0.5];
    }
    for (UIView *view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    self.image = [[UIImageView alloc] init];
    [self.image setContentMode:UIViewContentModeScaleAspectFit];
    [self.image setBackgroundColor:[UIColor darkGrayColor]];
    self.imageScrollView = [[UIScrollView alloc] init];
    [self.imageScrollView setBackgroundColor:[UIColor darkGrayColor]];
    self.imageScrollView.maximumZoomScale = 2.0;
    self.imageScrollView.minimumZoomScale = 0.5;
    self.imageScrollView.delegate = self;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"questionDetail" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"questionId":questionId} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            QuestionDetailModel *question=[QuestionDetailModel objectWithKeyValues:dict];
            [self.arrysMuta  addObject:question];
        }
        [self.tempMuta addObject:questionDetailData];
        for (QuestionDetailModel * info in self.arrysMuta)
        {
            [self.tempMuta addObject:info];
        }
        [self setMainView];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMainView {
    NSString *type = [[NSString alloc] init];
    for (QuestionDetailModel *question in self.tempMuta) {
        if (self.lastView == nil) {
            type = question.type;
            UIView *detailView = [[UIView alloc] init];
            [detailView setBackgroundColor:[UIColor whiteColor]];
            self.lastView = detailView;
            [self.contentView addSubview:detailView];
            UILabel *content = [[UILabel alloc] init];
            [detailView addSubview:content];
            content.text = question.content;
            content.numberOfLines = 0;
            [content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mainScroll.mas_left).offset(10);
                make.right.equalTo(self.mainScroll.mas_right).offset(-10);
                make.top.equalTo(detailView.mas_top).offset(10);
            }];
            UIImageView *picture = [[UIImageView alloc] init];
            [picture setContentMode:UIViewContentModeScaleAspectFit];
            [detailView addSubview:picture];
            if (![question.pic isEqualToString:@""]) {
                NSString *tempStr=[PHJKRequestUrl stringByAppendingString:question.pic];
                [picture sd_setImageWithURL:[NSURL URLWithString:tempStr]];
                [picture mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(content.mas_left).offset(30);
                    make.top.equalTo(content.mas_bottom).offset(20);
                    make.right.equalTo(content.mas_right).offset(-130);
                    make.height.equalTo(@100);
                }];
                LQUITapGestureRecognizer *tap = [[LQUITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
                tap.image = picture;
                picture.userInteractionEnabled = YES;
                [picture addGestureRecognizer:tap];
            } else {
                [picture mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(content.mas_left).offset(30);
                    make.top.equalTo(content.mas_bottom).offset(20);
                }];
            }
            UILabel *name = [[UILabel alloc] init];
            [detailView addSubview:name];
            if (question.asker == nil) {
                name.text = question.expert;
            } else {
                name.text = question.asker;
            }
            [name mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(picture.mas_bottom).offset(10);
                make.left.equalTo(content.mas_left).offset(5);
            }];
            UILabel *sex = [[UILabel alloc] init];
            [detailView addSubview:sex];
            if ([gender isEqualToString:@"1"]) {
                sex.text = @"男";
            } else if ([gender isEqualToString:@"2"]) {
                sex.text = @"女";
            } else {
                sex.text = @"";
            }
            [sex mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(name);
                make.left.equalTo(name.mas_right).offset(5);
            }];
            UILabel *old = [[UILabel alloc] init];
            [detailView addSubview:old];
            old.text = [age stringByAppendingString:@"岁"];
            [old mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(sex);
                make.left.equalTo(sex.mas_right).offset(5);
            }];
            UILabel *data = [[UILabel alloc] init];
            [detailView addSubview:data];
            data.text = question.create_date;
            [data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(name.mas_top);
                make.right.equalTo(detailView.mas_right).offset(-10);
            }];
            [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.mainScroll);
                make.top.equalTo(self.mainScroll).offset(10);
                make.bottom.equalTo(name.mas_bottom).offset(10);
            }];
        } else {
            type = question.type;
            UIView *detailView = [[UIView alloc] init];
            [detailView setBackgroundColor:[UIColor whiteColor]];
            [self.contentView addSubview:detailView];
            UILabel *content = [[UILabel alloc] init];
            [detailView addSubview:content];
            content.text = question.content;
            content.numberOfLines = 0;
            [content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mainScroll.mas_left).offset(10);
                make.right.equalTo(self.mainScroll.mas_right).offset(-10);
                make.top.equalTo(detailView.mas_top).offset(10);
            }];
            UIImageView *picture = [[UIImageView alloc] init];
            [picture setContentMode:UIViewContentModeScaleAspectFit];
            [detailView addSubview:picture];
            if (![question.pic isEqualToString:@""]&&question.pic != nil) {
                NSString *tempStr=[PHJKRequestUrl stringByAppendingString:question.pic];
                [picture sd_setImageWithURL:[NSURL URLWithString:tempStr]];
                [picture mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(content.mas_left).offset(30);
                    make.top.equalTo(content.mas_bottom).offset(20);
                    make.right.equalTo(content.mas_right).offset(-130);
                    make.height.equalTo(@100);
                }];
                LQUITapGestureRecognizer *tap = [[LQUITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
                tap.image = picture;
                picture.userInteractionEnabled = YES;
                [picture addGestureRecognizer:tap];
            } else {
                [picture mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(content.mas_left).offset(30);
                    make.top.equalTo(content.mas_bottom).offset(20);
                }];
            }
            UILabel *name = [[UILabel alloc] init];
            [detailView addSubview:name];
            if (question.asker == nil) {
                name.text = question.expert;
            } else {
                name.text = question.asker;
            }
            [name mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(picture.mas_bottom).offset(10);
                make.left.equalTo(content.mas_left).offset(5);
            }];
            if ([question.type isEqualToString:@"0"]) {
                UILabel *sex = [[UILabel alloc] init];
                [detailView addSubview:sex];
                if ([gender isEqualToString:@"1"]) {
                    sex.text = @"男";
                } else if ([gender isEqualToString:@"2"]) {
                    sex.text = @"女";
                } else {
                    sex.text = @"";
                }
                [sex mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(name);
                    make.left.equalTo(name.mas_right).offset(5);
                }];
                UILabel *old = [[UILabel alloc] init];
                [detailView addSubview:old];
                old.text = [age stringByAppendingString:@"岁"];
                [old mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(sex);
                    make.left.equalTo(sex.mas_right).offset(5);
                }];
            }
            UILabel *data = [[UILabel alloc] init];
            [detailView addSubview:data];
            data.text = question.create_date;
            [data mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(name.mas_top);
                make.right.equalTo(detailView.mas_right).offset(-10);
            }];
            [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.mainScroll);
                make.bottom.equalTo(name.mas_bottom).offset(10);
                make.top.equalTo(self.lastView.mas_bottom).offset(10);
            }];
            self.lastView = detailView;
        }
    }
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lastView.mas_bottom).offset(10);
    }];
    if ([type isEqualToString:@"0"]) {
        [self.contuQstBtn setEnabled: NO];
        [self.contuQstBtn setAlpha:0.5];
    }
}

-(void)contineQus {
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"MyQuestionController" bundle:nil];
    QuestionsController *questionsController=[sb instantiateViewControllerWithIdentifier:@"QuestionsController"];
    questionsController.questionId = ((QuestionDetailModel *)[self.tempMuta objectAtIndex:0]).questionId;
    questionsController.sendPostCtlr.oldFied.text = self.age;
    [questionsController.sendPostCtlr.oldFied setEnabled:NO];
    questionsController.sendPostCtlr.sex = self.gender;
    if ([self.gender isEqualToString:@"1"]) {
        [questionsController.sendPostCtlr.manBtn setSelected:YES];
        questionsController.sendPostCtlr.womanBtn.selected = NO;
        [questionsController.sendPostCtlr.womanBtn setEnabled:NO];
    } else if ([self.gender isEqualToString:@"2"]) {
        questionsController.sendPostCtlr.manBtn.selected = NO;
        questionsController.sendPostCtlr.womanBtn.selected = YES;
        [questionsController.sendPostCtlr.manBtn setEnabled:NO];
    } else {
        questionsController.sendPostCtlr.manBtn.selected = NO;
        questionsController.sendPostCtlr.womanBtn.selected = NO;
        [questionsController.sendPostCtlr.manBtn setEnabled:NO];
        [questionsController.sendPostCtlr.womanBtn setEnabled:NO];
    }
    [self.navigationController pushViewController:questionsController animated:YES];
}

-(void)finishQus {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"endQuestion" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"questionId":questionId} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"完成" message:@"提问已结束" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)tapImage:(LQUITapGestureRecognizer *)tap {
    self.navigationController.navigationBarHidden = YES;
    [self.image setImage:tap.image.image];
    [self.imageScrollView addSubview:self.image];
    [self.view addSubview:self.imageScrollView];
    [self.imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.imageScrollView);
        make.top.equalTo(self.imageScrollView).offset(17);
    }];
    UITapGestureRecognizer *temp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAgain)];
    [self.imageScrollView addGestureRecognizer:temp];
}

-(void)tapImageAgain {
    self.navigationController.navigationBarHidden = NO;
    [self.image removeFromSuperview];
    [self.imageScrollView removeFromSuperview];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.image;
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
