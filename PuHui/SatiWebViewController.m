//
//  SatiWebViewController.m
//  PuHui
//
//  Created by administrator on 15/8/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "SatiWebViewController.h"
#import "Masonry.h"

@interface SatiWebViewController ()

@property (strong, nonatomic) UIWebView *mainWeb;

@end

@implementation SatiWebViewController
@synthesize url;

- (UIWebView *)mainWeb {
    if (!_mainWeb) {
        _mainWeb = [[UIWebView alloc] init];
    }
    return _mainWeb;
}

- (void)viewWillAppear:(BOOL)animated {
    NSURL *phoneURL = [NSURL URLWithString:url];
    [self.view addSubview:self.mainWeb];
    [self.mainWeb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.mainWeb loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //url = @"";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
