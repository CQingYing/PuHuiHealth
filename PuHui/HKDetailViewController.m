//
//  HKDetailViewController.m
//  PuHui
//
//  Created by administrator on 15/8/11.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "HKDetailViewController.h"
#import "Masonry.h"
#import "RequestServer.h"

@interface HKDetailViewController ()
@property (copy, nonatomic) NSString *infoContent;
@property (copy, nonatomic) NSString *infoTitle;
@property (copy, nonatomic) NSString *categoryName;
@property (copy, nonatomic) NSString *releaseTime;

@end

@implementation HKDetailViewController
@synthesize infoId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self setMainView];
}

- (void)setMainView {
    [RequestServer fetchMethodName:@"infomationDetail" parameters:@{@"infoId":infoId} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
            self.infoContent = responseDic[@"infoContent"];
            self.infoTitle = responseDic[@"infoTitle"];
            self.categoryName = responseDic[@"categoryName"];
            self.releaseTime = responseDic[@"releaseTime"];
            
            UIView *backView = [[UIView alloc] init];
            [self.view addSubview:backView];
            UILabel *title = [[UILabel alloc] init];
            [backView addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(backView).offset(10);
                make.left.equalTo(backView.mas_left);
                make.right.equalTo(backView.mas_right);
            }];
            title.text = self.infoTitle;
            [title setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            [title setTextAlignment:NSTextAlignmentCenter];
            UILabel *name = [[UILabel alloc] init];
            [backView addSubview:name];
            [name mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(title.mas_bottom).offset(10);
                make.left.equalTo(backView.mas_left).offset(10);
            }];
            NSString *temp = @"分类:";
            name.text = [temp stringByAppendingString:self.categoryName];
            [name setTextColor:[UIColor darkGrayColor]];
            UILabel *time = [[UILabel alloc] init];
            [backView addSubview:time];
            [time mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(name.mas_top);
                make.left.equalTo(name.mas_right);
                make.right.equalTo(backView.mas_right).offset(-10);
            }];
            [time setTextAlignment:NSTextAlignmentRight];
            temp = @"发布时间:";
            NSString *subStr = [[self.releaseTime substringFromIndex:0] substringToIndex:10];
            time.text = [temp stringByAppendingString:subStr];
            [time setTextColor:[UIColor darkGrayColor]];
            UILabel *content = [[UILabel alloc] init];
            [backView addSubview:content];
            content.numberOfLines = 0;
            [content mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(name.mas_left);
                make.right.equalTo(time.mas_right);
                make.top.equalTo(name.mas_bottom).offset(15);
            }];
            temp = @"    ";
            content.text = [temp stringByAppendingString:self.infoContent];
            [content setTextColor:[UIColor darkGrayColor]];
            [backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(67);
                make.left.equalTo(self.view.mas_left);
                make.right.equalTo(self.view.mas_right);
                make.bottom.equalTo(content.mas_bottom).offset(20);
            }];
            [backView setBackgroundColor:[UIColor whiteColor]];
        }
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
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
