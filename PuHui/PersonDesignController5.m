//
//  PersonDesignController.m
//  PuHui
//
//  Created by administrator on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonDesignController5.h"
#import "Masonry.h"

@interface PersonDesignController5 ()
@property(strong, nonatomic) UIButton *submit;
@property(strong, nonatomic) UIImageView *imgView;

@end

@implementation PersonDesignController5

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.navigationController setNavigationBarHidden:NO];
    
    UIImage *image = [UIImage imageNamed:@"progress bar_05"];
    self.imgView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.height.mas_equalTo(@44);
    }];
    [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
    [self setButton];
    [self setScrollView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setButton
{
    self.submit = [[UIButton alloc] init];
    [self.submit setTitle:@"提交" forState:UIControlStateNormal];
    [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submit setBackgroundColor:[UIColor orangeColor]];
    self.submit.layer.cornerRadius = 5;
    self.submit.layer.masksToBounds = YES;
    [self.view addSubview:self.submit];
    [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@70);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.bottom.equalTo(self.view.mas_bottom).offset(-8);
    }];
}

-(void)setScrollView
{
    UIScrollView *sv = [[UIScrollView alloc] init];
    [self.view addSubview:sv];
    [sv setBackgroundColor:[UIColor whiteColor]];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.imgView.mas_bottom).offset(5);
        make.bottom.equalTo(self.submit.mas_top).offset(-8);
    }];
    UIView *contentView = [[UIView alloc] init];
    
    UILabel *question21 = [[UILabel alloc] init];
    question21.text = @"21、凌晨4-5点心慌饥饿感明显?";
    [question21 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question21];
    [question21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(contentView.mas_top).offset(8);
    }];
    UILabel *ans211 = [[UILabel alloc] init];
    ans211.text = @"无";
    [ans211 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans211];
    [ans211 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question21).offset(49);
        make.top.equalTo(question21.mas_bottom).offset(8);
    }];
    UILabel *ans212 = [[UILabel alloc] init];
    ans212.text = @"有";
    [ans212 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans212];
    [ans212 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question21).offset(49);
        make.top.equalTo(ans211.mas_bottom).offset(8);
    }];
    
    UILabel *question22 = [[UILabel alloc] init];
    question22.text = @"22、晨起眼睑浮肿明显?";
    [question22 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question22];
    [question22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans212.mas_bottom).offset(8);
    }];
    UILabel *ans221 = [[UILabel alloc] init];
    ans221.text = @"无";
    [ans221 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans221];
    [ans221 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question22).offset(49);
        make.top.equalTo(question22.mas_bottom).offset(8);
    }];
    UILabel *ans222 = [[UILabel alloc] init];
    ans222.text = @"有";
    [ans222 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans222];
    [ans222 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question22).offset(49);
        make.top.equalTo(ans221.mas_bottom).offset(8);
    }];
    
    UILabel *question23 = [[UILabel alloc] init];
    question23.text = @"23、长期面色潮红?";
    [question23 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question23];
    [question23 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans222.mas_bottom).offset(8);
    }];
    UILabel *ans231 = [[UILabel alloc] init];
    ans231.text = @"无";
    [ans231 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans231];
    [ans231 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question23).offset(49);
        make.top.equalTo(question23.mas_bottom).offset(8);
    }];
    UILabel *ans232 = [[UILabel alloc] init];
    ans232.text = @"有";
    [ans232 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans232];
    [ans232 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question23).offset(49);
        make.top.equalTo(ans231.mas_bottom).offset(8);
    }];
    
    UILabel *question24 = [[UILabel alloc] init];
    question24.text = @"24、食欲亢进，体重下降或手心潮湿?";
    [question24 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question24];
    [question24 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans232.mas_bottom).offset(8);
    }];
    UILabel *ans241 = [[UILabel alloc] init];
    ans241.text = @"无";
    [ans241 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans241];
    [ans241 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question24).offset(49);
        make.top.equalTo(question24.mas_bottom).offset(8);
    }];
    UILabel *ans242 = [[UILabel alloc] init];
    ans242.text = @"有";
    [ans242 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans242];
    [ans242 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question24).offset(49);
        make.top.equalTo(ans241.mas_bottom).offset(8);
    }];
    
    UILabel *question25 = [[UILabel alloc] init];
    question25.text = @"25、无食欲，进食油腻恶心，易疲劳?";
    [question25 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question25];
    [question25 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans242.mas_bottom).offset(8);
    }];
    UILabel *ans251 = [[UILabel alloc] init];
    ans251.text = @"无";
    [ans251 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans251];
    [ans251 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question25).offset(49);
        make.top.equalTo(question25.mas_bottom).offset(8);
    }];
    UILabel *ans252 = [[UILabel alloc] init];
    ans252.text = @"有";
    [ans252 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans252];
    [ans252 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question25).offset(49);
        make.top.equalTo(ans251.mas_bottom).offset(8);
    }];
    
    UILabel *question26 = [[UILabel alloc] init];
    question26.text = @"26、脖子僵硬不适?";
    [question26 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question26];
    [question26 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans252.mas_bottom).offset(8);
    }];
    UILabel *ans261 = [[UILabel alloc] init];
    ans261.text = @"无";
    [ans261 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans261];
    [ans261 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question26).offset(49);
        make.top.equalTo(question26.mas_bottom).offset(8);
    }];
    UILabel *ans262 = [[UILabel alloc] init];
    ans262.text = @"常有";
    [ans262 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans262];
    [ans262 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question26).offset(49);
        make.top.equalTo(ans261.mas_bottom).offset(8);
    }];
    
    UILabel *question27 = [[UILabel alloc] init];
    question27.text = @"27、腰痛负重后疼痛明显?";
    [question27 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question27];
    [question27 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans262.mas_bottom).offset(8);
    }];
    UILabel *ans271 = [[UILabel alloc] init];
    ans271.text = @"无";
    [ans271 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans271];
    [ans271 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question27).offset(49);
        make.top.equalTo(question27.mas_bottom).offset(8);
    }];
    UILabel *ans272 = [[UILabel alloc] init];
    ans272.text = @"偶有";
    [ans272 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans272];
    [ans272 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question27).offset(49);
        make.top.equalTo(ans271.mas_bottom).offset(8);
    }];
    
    [sv addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv);
        make.width.equalTo(sv);
        make.bottom.equalTo(ans272.mas_bottom).offset(15);
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

