//
//  HKTableViewController.m
//  PuHui
//
//  Created by administrator on 15/8/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "HKTableViewController.h"
#import "HKTableViewCell.h"
#import "HKTableModel.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "HKSearchViewController.h"
#import "HKDetailViewController.h"
#import "Masonry.h"

@interface HKTableViewController ()
@property (strong, nonatomic) UITextField *searchText;
@property (strong, nonatomic) UIButton *searchBtn;
@property (strong, nonatomic) UITableView *mainTable;
@property (assign, nonatomic) int currentPage;
@property (strong, nonatomic) NSMutableArray *modelData;
@end

@implementation HKTableViewController
@synthesize categoryId,NavTitle;

- (NSMutableArray *)modelData {
    if (!_modelData) {
        _modelData = [[NSMutableArray alloc] init];
    }
    return _modelData;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    NSLog(@"######%@",self.categoryId);
    // Do any additional setup after loading the view.
    self.searchBtn = [[UIButton alloc] init];
    self.mainTable = [[UITableView alloc] init];
    [self.view addSubview:self.mainTable];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    self.mainTable.rowHeight = 121;
    [self.mainTable setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.searchBtn addTarget:self action:@selector(clickedSearchBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupRefresh:self.mainTable];
    self.navigationItem.title = NavTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.modelData count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self setHeadView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"HKTable";
    HKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HKTableViewCell" owner:nil options:nil]lastObject];
    }
    NSString *temp = @"标题:";
    cell.HKTitle.text = [temp stringByAppendingString:((HKTableModel *)[self.modelData objectAtIndex:indexPath.row]).infoTitle];
    temp = @"简介:";
    cell.HKIntroduce.text = [temp stringByAppendingString:((HKTableModel *)[self.modelData objectAtIndex:indexPath.row]).infoSummary];
    temp = @"分类:";
    cell.HKClass.text = [temp stringByAppendingString:((HKTableModel *)[self.modelData objectAtIndex:indexPath.row]).categoryName];
    temp = @"发布时间:";
    NSString *subStr = ((HKTableModel *)[self.modelData objectAtIndex:indexPath.row]).releaseTime;
    subStr = [[subStr substringFromIndex:0]substringToIndex:10];
    cell.HKTime.text = [temp stringByAppendingString:subStr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HKDetailViewController *dv = [[HKDetailViewController alloc] init];
    dv.infoId = ((HKTableModel *)[self.modelData objectAtIndex:indexPath.row]).infoId;
    [self.navigationController pushViewController:dv animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (void)setupRefresh:(UITableView *)tableView {
    //下拉刷新
    [tableView addHeaderWithTarget:self action:@selector(TableheaderRereshing) dateKey:@"table"];
    [tableView headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [tableView addFooterWithTarget:self action:@selector(TablefooterRereshing)];
    //一些设置
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    tableView.headerPullToRefreshText = @"下拉可以刷新了";
    tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    tableView.headerRefreshingText = @"刷新中。。。";
    
    tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    tableView.footerRefreshingText = @"加载中。。。";
}
//下拉刷新
- (void)TableheaderRereshing
{
    self.currentPage = 1;
    
    [RequestServer fetchMethodName:@"infomationList" parameters:@{@"categoryId":categoryId,@"pageNum":[NSString stringWithFormat:@"%d",self.currentPage],@"pageSize":@"10"} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        [self.modelData removeAllObjects];
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            HKTableModel *model=[HKTableModel objectWithKeyValues:dict];
            [self.modelData addObject:model];
        }
        self.currentPage++;
        [self.mainTable reloadData];
        [self.mainTable headerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

- (void)TablefooterRereshing
{
    [RequestServer fetchMethodName:@"infomationList" parameters:@{@"categoryId":categoryId,@"pageNum":[NSString stringWithFormat:@"%d",self.currentPage],@"pageSize":@"10"} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            HKTableModel *model=[HKTableModel objectWithKeyValues:dict];
            [self.modelData insertObject:model atIndex:[_modelData count]];
        }
        self.currentPage++;
        [self.mainTable reloadData];
        [self.mainTable footerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

- (void)clickedSearchBtn {
    if ([self.searchText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"搜索内容不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    } else {
        HKSearchViewController *hksv = [[HKSearchViewController alloc] init];
        hksv.search = self.searchText.text;
        [self.navigationController pushViewController:hksv animated:YES];
    }
}

- (UIView *)setHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    [headView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UIView *back = [[UIView alloc] init];
    [headView addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headView);
        make.top.equalTo(headView.mas_top).offset(5);
        make.bottom.equalTo(headView.mas_bottom).offset(-5);
    }];
    [back setBackgroundColor:[UIColor whiteColor]];
    [headView addSubview:self.searchBtn];
    [self.searchBtn setImage:[UIImage imageNamed:@"Zsearch"] forState:UIControlStateNormal];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).offset(15);
        make.right.equalTo(headView.mas_right).offset(-20);
    }];
    self.searchText = [[UITextField alloc] init];
    [headView addSubview:self.searchText];
    [self.searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBtn.mas_top).offset(5);
        make.left.equalTo(headView.mas_left).offset(20);
        make.right.equalTo(self.searchBtn.mas_left).offset(-5);
    }];
    self.searchText.placeholder = @"按标题、简介搜索";
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Zsearch_line"]];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    [headView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.searchBtn.mas_bottom);
        make.left.equalTo(headView.mas_left).offset(10);
        make.right.equalTo(self.searchBtn.mas_left).offset(-5);
    }];
    return headView;
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
