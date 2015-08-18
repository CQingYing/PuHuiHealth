//
//  SatisfiedViewController.m
//  PuHui
//
//  Created by administrator on 15/8/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "SatisfiedViewController.h"
#import "Masonry.h"
#import "SatiWebViewController.h"

@interface SatisfiedViewController ()

@property (strong, nonatomic) UITableView *mainTable;
@property (strong, nonatomic) UIWebView *SatisfiedWebView;

@end

@implementation SatisfiedViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.navigationController.navigationBarHidden = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTable = [[UITableView alloc] init];
    [self.view addSubview:self.mainTable];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"choice";
    UITableViewCell *cell = [self.mainTable dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"检前满意度调查";
    } else {
        cell.textLabel.text = @"检后满意度调查";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SatiWebViewController *swvc = [[SatiWebViewController alloc] init];
    if (indexPath.row == 0) {
        swvc.url = @"http://192.168.1.253:8081/PuhuiServer/questionbefore.html";
    } else {
        swvc.url = @"http://192.168.1.253:8081/PuhuiServer/questionafter.html";
    }
    [self.navigationController pushViewController:swvc animated:YES];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
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
