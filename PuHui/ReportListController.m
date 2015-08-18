//
//  ReportListController.m
//  PuHui
//
//  Created by rp.wang on 15/7/17.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "ReportListController.h"
#import "ReportListCell.h"
#import "ReportDetailController.h"  
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "BaseInfoModel.h"

@interface ReportListController ()

@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  NSMutableArray  *baseInfoAry;
@property (strong, nonatomic)  NSMutableArray  *reportDetailsAry;
@property (strong, nonatomic)  NSMutableArray *sumA;
@end

@implementation ReportListController
- (NSMutableArray *)sumA
{
    if (!_sumA) {
        _sumA = [[NSMutableArray  alloc] init];
    }
    
    return _sumA;
}

- (NSMutableArray *)reportDetailsAry
{
if (!_reportDetailsAry) {
_reportDetailsAry = [[NSMutableArray  alloc] init];
}
return _reportDetailsAry;
}

- (NSMutableArray *)baseInfoAry
{
    if (!_baseInfoAry) {
        _baseInfoAry = [[NSMutableArray  alloc] init];
    }
    return _baseInfoAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=100;
    NSLog(@"$$$$%@$$$$%@",self.areaCon,self.phoneCon);
    
    [self loadDatas];

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
    return self.baseInfoAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID=@"Cell";
    ReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ReportListCell" owner:nil options:nil]lastObject];
    }
    
    BaseInfoModel *info=self.baseInfoAry[indexPath.row];
    cell.nameLab.text=info.name;
    cell.timeLab.text=info.date;
    cell.mealLab.text=info.packages;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReportDetailController *reportDetailCon=[[ReportDetailController alloc]init];
    reportDetailCon.baseInfoAry=self.baseInfoAry;
    reportDetailCon.reportDetailsAry=self.reportDetailsAry;
    reportDetailCon.nums=indexPath.row;
    reportDetailCon.sumA=self.sumA;
    [self.navigationController pushViewController:reportDetailCon animated:YES];
}


-(void)loadDatas{
    
[RequestServer fetchMethodName:@"health_appserv_myReport" parameters:@{@"cityName":self.areaCon,@"phone":self.phoneCon} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiYW successHandler:^(NSMutableDictionary *responseDic) {
    
    
  
    if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
        
        NSArray *inforArys=responseDic[@"data"];
        //方式1
        for (NSDictionary *dict  in inforArys) {
            BaseInfoModel *meals=[BaseInfoModel objectWithKeyValues:dict[@"baseInfo"]];
            [self.baseInfoAry  addObject:meals];
        }
        
        for (NSDictionary *dict  in inforArys) {
            NSString *str= dict[@"summaryAnalysis"];
            [self.sumA addObject:str];
        }
        
        //方式1
        for (NSDictionary *dict  in inforArys) {
           NSArray *temp= dict[@"reportDetails"];
           [self.reportDetailsAry  addObject:temp];;
        }
        [self.tableView reloadData];
        
    }else{
      [self showAllTextDialog:responseDic[@"retMsg"]];
    }
} failureHandler:^(NSString *errorInfo) {
    NSLog(@"%@",errorInfo);
}];

    
}


- (void)showAllTextDialog:(NSString *)str{
    UIWindow *win=[[UIApplication sharedApplication].windows lastObject];
    self.HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.mode = MBProgressHUDModeText;
    [win addSubview:self.HUD];
    //self.HUD.dimBackground = YES;
    self.HUD.labelText = str;
    [self.HUD hide:YES afterDelay:2];
    self.HUD.removeFromSuperViewOnHide = YES;
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
