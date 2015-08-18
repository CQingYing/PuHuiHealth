//
//  WebViewController.m
//  PuHui
//
//  Created by rp.wang on 15/7/29.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webVie;
@property (strong, nonatomic) NSString *endURL;
@end

@implementation WebViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"点击了第%d页:%@",self.nPage,self.URLCon);
    NSString *temp = [self.URLCon lowercaseString];
    NSRange range;
    range.location = 0;     //从4开始
    range.length = 4;       //6个字符
    if (![[temp substringWithRange:range] isEqualToString:@"http"]) {
        self.endURL=[NSString stringWithFormat:@"%@%@",@"http://",temp];
    }
    NSLog(@"^^^%@",self.endURL);
    NSURL *url =[NSURL URLWithString:self.endURL];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webVie loadRequest:request];
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
