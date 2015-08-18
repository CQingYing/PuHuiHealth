//
//  ReconmmendHistoryController.m
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "ReconmmendHistoryController.h"
#import "RecommendHistoryCell.h"
#import "InternalReconmmendControlller.h"
#import "RecodHistoryInfo.h"
#import "NSString+Extension.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface ReconmmendHistoryController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (assign, nonatomic) int pageCount;
@end

@implementation ReconmmendHistoryController

- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight=134;
    [self setupRefresh];
}
- (void)setupRefresh
{
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.tableView headerBeginRefreshing];
    // 上拉加载
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *userId = [user objectForKey:@"userIdz"];
    self.pageCount = 0;
    
    [RequestServer fetchMethodName:@"find_app_serv_record_By_userId" parameters:@{@"app_serv_record.appuser_id":@"835",@"pageIndex":[NSString stringWithFormat:@"%d",self.pageCount]} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
        [self.arrysMuta removeAllObjects];
        NSArray *inforArys=responseDic[@"app_serv_record_list"];
        for (NSDictionary *dict  in inforArys) {
            RecodHistoryInfo *meals=[RecodHistoryInfo objectWithKeyValues:dict];
            [self.arrysMuta addObject:meals];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}

- (void)footerRereshing
{
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *userId = [user objectForKey:@"userIdz"];
     self.pageCount++;
    [RequestServer fetchMethodName:@"find_app_serv_record_By_userId" parameters:@{@"app_serv_record.appuser_id":@"835",@"pageIndex":[NSString stringWithFormat:@"%d",self.pageCount]} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"app_serv_record_list"];
        for (NSDictionary *dict  in inforArys) {
            RecodHistoryInfo *meals=[RecodHistoryInfo objectWithKeyValues:dict];
            [self.arrysMuta addObject:meals];
        }
       
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Return the number of rows in the section.
    return self.arrysMuta.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID=@"Cell";
    RecommendHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        //注意：cell的xib文件必须设定Identifier为Cell，即为ID
        cell=[[[NSBundle mainBundle]loadNibNamed:@"RecommendHistoryCell" owner:nil options:nil]lastObject];
    }
    RecodHistoryInfo *info= self.arrysMuta[indexPath.row];
    cell.nameT.text = info.name;
    cell.phoneT.text = info.mobile;
    cell.sexT.text = info.sex;
    cell.mealT.text = info.package_name;
    cell.keyT.text = info.app_barcode;
    cell.timeT.text = info.create_date;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
