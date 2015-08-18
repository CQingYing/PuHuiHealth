//
//  PersonDesignController.m
//  PuHui
//
//  Created by administrator on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonDesignController4.h"
#import "Masonry.h"
#import "PersonDesignController5.h"

@interface PersonDesignController4 ()
@property(strong, nonatomic) UIButton *nextStep;
@property(strong, nonatomic) UIButton *submit;
@property(strong, nonatomic) UIImageView *imgView;

@end

@implementation PersonDesignController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.navigationController setNavigationBarHidden:NO];

    UIImage *image = [UIImage imageNamed:@"progress bar_04"];
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
    self.nextStep = [[UIButton alloc] init];
    [self.nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextStep setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.nextStep.layer.cornerRadius = 6;
    self.nextStep.layer.masksToBounds = YES;
    self.nextStep.layer.borderColor = [UIColor orangeColor].CGColor;
    self.nextStep.layer.borderWidth = 1;
    [self.view addSubview:self.nextStep];
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-8);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@70);
    }];
    self.submit = [[UIButton alloc] init];
    [self.submit setTitle:@"提交" forState:UIControlStateNormal];
    [self.submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submit setBackgroundColor:[UIColor orangeColor]];
    self.submit.layer.cornerRadius = 5;
    self.submit.layer.masksToBounds = YES;
    [self.view addSubview:self.submit];
    [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.bottom.equalTo(self.nextStep);
        make.right.equalTo(self.nextStep.mas_left).offset(-16);
    }];
    
    [self.nextStep addTarget:self action:@selector(clickNextStep) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setScrollView
{
    UIScrollView *sv = [[UIScrollView alloc] init];
    [self.view addSubview:sv];
    [sv setBackgroundColor:[UIColor whiteColor]];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.imgView.mas_bottom).offset(5);
        make.bottom.equalTo(self.nextStep.mas_top).offset(-8);
    }];
    UIView *contentView = [[UIView alloc] init];
    
    UILabel *question10 = [[UILabel alloc] init];
    question10.text = @"10、大便情况?";
    [question10 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question10];
    [question10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(contentView.mas_top).offset(8);
    }];
    UILabel *ans101 = [[UILabel alloc] init];
    ans101.text = @"基本正常";
    [ans101 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans101];
    [ans101 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question10).offset(49);
        make.top.equalTo(question10.mas_bottom).offset(8);
    }];
    UILabel *ans102 = [[UILabel alloc] init];
    ans102.text = @"腹泻、排不尽感";
    [ans102 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans102];
    [ans102 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question10).offset(49);
        make.top.equalTo(ans101.mas_bottom).offset(8);
    }];
    UILabel *ans103 = [[UILabel alloc] init];
    ans103.text = @"便秘或便中带血";
    [ans103 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans103];
    [ans103 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question10).offset(49);
        make.top.equalTo(ans102.mas_bottom).offset(8);
    }];
    
    UILabel *question11 = [[UILabel alloc] init];
    question11.text = @"11、小便情况?";
    [question11 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question11];
    [question11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans103.mas_bottom).offset(8);
    }];
    UILabel *ans111 = [[UILabel alloc] init];
    ans111.text = @"基本通畅";
    [ans111 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans111];
    [ans111 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question11).offset(49);
        make.top.equalTo(question11.mas_bottom).offset(8);
    }];
    UILabel *ans112 = [[UILabel alloc] init];
    ans112.text = @"尿频、尿急、尿痛";
    [ans112 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans112];
    [ans112 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question11).offset(49);
        make.top.equalTo(ans111.mas_bottom).offset(8);
    }];
    UILabel *ans113 = [[UILabel alloc] init];
    ans113.text = @"血尿";
    [ans113 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans113];
    [ans113 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question11).offset(49);
        make.top.equalTo(ans112.mas_bottom).offset(8);
    }];
    
    UILabel *question12 = [[UILabel alloc] init];
    question12.text = @"12、有无视物模糊、迎风流泪或眼前飞蚊感?";
    [question12 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question12];
    [question12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans113.mas_bottom).offset(8);
    }];
    UILabel *ans121 = [[UILabel alloc] init];
    ans121.text = @"无";
    [ans121 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans121];
    [ans121 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question12).offset(49);
        make.top.equalTo(question12.mas_bottom).offset(8);
    }];
    UILabel *ans122 = [[UILabel alloc] init];
    ans122.text = @"偶有";
    [ans122 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans122];
    [ans122 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question12).offset(49);
        make.top.equalTo(ans121.mas_bottom).offset(8);
    }];
    UILabel *ans123 = [[UILabel alloc] init];
    ans123.text = @"常有";
    [ans123 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans123];
    [ans123 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question12).offset(49);
        make.top.equalTo(ans122.mas_bottom).offset(8);
    }];
    
    UILabel *question13 = [[UILabel alloc] init];
    question13.text = @"13、有无听力下降或耳鸣?";
    [question13 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question13];
    [question13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans123.mas_bottom).offset(8);
    }];
    UILabel *ans131 = [[UILabel alloc] init];
    ans131.text = @"无";
    [ans131 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans131];
    [ans131 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question13).offset(49);
        make.top.equalTo(question13.mas_bottom).offset(8);
    }];
    UILabel *ans132 = [[UILabel alloc] init];
    ans132.text = @"偶有";
    [ans132 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans132];
    [ans132 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question13).offset(49);
        make.top.equalTo(ans131.mas_bottom).offset(8);
    }];
    UILabel *ans133 = [[UILabel alloc] init];
    ans133.text = @"常有";
    [ans133 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans133];
    [ans133 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question13).offset(49);
        make.top.equalTo(ans132.mas_bottom).offset(8);
    }];
    
    UILabel *question14 = [[UILabel alloc] init];
    question14.text = @"14、有无口腔溃疡或口臭?";
    [question14 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question14];
    [question14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans133.mas_bottom).offset(8);
    }];
    UILabel *ans141 = [[UILabel alloc] init];
    ans141.text = @"无";
    [ans141 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans141];
    [ans141 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question14).offset(49);
        make.top.equalTo(question14.mas_bottom).offset(8);
    }];
    UILabel *ans142 = [[UILabel alloc] init];
    ans142.text = @"偶有";
    [ans142 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans142];
    [ans142 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question14).offset(49);
        make.top.equalTo(ans141.mas_bottom).offset(8);
    }];
    UILabel *ans143 = [[UILabel alloc] init];
    ans143.text = @"常有";
    [ans143 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans143];
    [ans143 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question14).offset(49);
        make.top.equalTo(ans142.mas_bottom).offset(8);
    }];
    
    UILabel *question15 = [[UILabel alloc] init];
    question15.text = @"15、有无不明原因鼻塞、喷嚏、流涕?";
    [question15 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question15];
    [question15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans143.mas_bottom).offset(8);
    }];
    UILabel *ans151 = [[UILabel alloc] init];
    ans151.text = @"无";
    [ans151 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans151];
    [ans151 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question15).offset(49);
        make.top.equalTo(question15.mas_bottom).offset(8);
    }];
    UILabel *ans152 = [[UILabel alloc] init];
    ans152.text = @"有";
    [ans152 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans152];
    [ans152 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question15).offset(49);
        make.top.equalTo(ans151.mas_bottom).offset(8);
    }];
    
    UILabel *question16 = [[UILabel alloc] init];
    question16.text = @"16、有无舌麻木?";
    [question16 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question16];
    [question16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans152.mas_bottom).offset(8);
    }];
    UILabel *ans161 = [[UILabel alloc] init];
    ans161.text = @"无";
    [ans161 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans161];
    [ans161 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question16).offset(49);
        make.top.equalTo(question16.mas_bottom).offset(8);
    }];
    UILabel *ans162 = [[UILabel alloc] init];
    ans162.text = @"偶有";
    [ans162 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans162];
    [ans162 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question16).offset(49);
        make.top.equalTo(ans161.mas_bottom).offset(8);
    }];
    UILabel *ans163 = [[UILabel alloc] init];
    ans163.text = @"常有";
    [ans163 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans163];
    [ans163 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question16).offset(49);
        make.top.equalTo(ans162.mas_bottom).offset(8);
    }];
    
    UILabel *question17 = [[UILabel alloc] init];
    question17.text = @"17、有无腹胀、腹痛、恶心、呕吐?";
    [question17 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question17];
    [question17 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans163.mas_bottom).offset(8);
    }];
    UILabel *ans171 = [[UILabel alloc] init];
    ans171.text = @"无";
    [ans171 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans171];
    [ans171 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question17).offset(49);
        make.top.equalTo(question17.mas_bottom).offset(8);
    }];
    UILabel *ans172 = [[UILabel alloc] init];
    ans172.text = @"偶有";
    [ans172 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans172];
    [ans172 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question17).offset(49);
        make.top.equalTo(ans171.mas_bottom).offset(8);
    }];
    UILabel *ans173 = [[UILabel alloc] init];
    ans173.text = @"常有";
    [ans173 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans173];
    [ans173 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question17).offset(49);
        make.top.equalTo(ans172.mas_bottom).offset(8);
    }];
    
    UILabel *question18 = [[UILabel alloc] init];
    question18.text = @"18、有无心慌、胸闷、气短?";
    [question18 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question18];
    [question18 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans173.mas_bottom).offset(8);
    }];
    UILabel *ans181 = [[UILabel alloc] init];
    ans181.text = @"无";
    [ans181 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans181];
    [ans181 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question18).offset(49);
        make.top.equalTo(question18.mas_bottom).offset(8);
    }];
    UILabel *ans182 = [[UILabel alloc] init];
    ans182.text = @"偶有";
    [ans182 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans182];
    [ans182 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question18).offset(49);
        make.top.equalTo(ans181.mas_bottom).offset(8);
    }];
    UILabel *ans183 = [[UILabel alloc] init];
    ans183.text = @"常有";
    [ans183 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans183];
    [ans183 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question18).offset(49);
        make.top.equalTo(ans182.mas_bottom).offset(8);
    }];
    
    UILabel *question19 = [[UILabel alloc] init];
    question19.text = @"19、有无头晕、头痛?";
    [question19 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question19];
    [question19 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans183.mas_bottom).offset(8);
    }];
    UILabel *ans191 = [[UILabel alloc] init];
    ans191.text = @"无";
    [ans191 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans191];
    [ans191 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question19).offset(49);
        make.top.equalTo(question19.mas_bottom).offset(8);
    }];
    UILabel *ans192 = [[UILabel alloc] init];
    ans192.text = @"偶有";
    [ans192 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans192];
    [ans192 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question19).offset(49);
        make.top.equalTo(ans191.mas_bottom).offset(8);
    }];
    UILabel *ans193 = [[UILabel alloc] init];
    ans193.text = @"常有";
    [ans193 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans193];
    [ans193 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question19).offset(49);
        make.top.equalTo(ans192.mas_bottom).offset(8);
    }];
    
    UILabel *question20 = [[UILabel alloc] init];
    question20.text = @"20、有无明显咳嗽、咳痰?";
    [question20 setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [contentView addSubview:question20];
    [question20 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(16);
        make.top.equalTo(ans193.mas_bottom).offset(8);
    }];
    UILabel *ans201 = [[UILabel alloc] init];
    ans201.text = @"无";
    [ans201 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans201];
    [ans201 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question20).offset(49);
        make.top.equalTo(question20.mas_bottom).offset(8);
    }];
    UILabel *ans202 = [[UILabel alloc] init];
    ans202.text = @"偶有";
    [ans202 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans202];
    [ans202 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question20).offset(49);
        make.top.equalTo(ans201.mas_bottom).offset(8);
    }];
    UILabel *ans203 = [[UILabel alloc] init];
    ans203.text = @"常有";
    [ans203 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [contentView addSubview:ans203];
    [ans203 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(question20).offset(49);
        make.top.equalTo(ans202.mas_bottom).offset(8);
    }];
    
    [sv addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv);
        make.width.equalTo(sv);
        make.bottom.equalTo(ans203.mas_bottom).offset(15);
    }];
}

-(void)clickNextStep
{
    PersonDesignController5 *pdc5 = [[PersonDesignController5 alloc] init];
    [self.navigationController pushViewController:pdc5 animated:YES];
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
