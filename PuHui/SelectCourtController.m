//
//  SelectCourtController.m
//  PuHui
//
//  Created by rp.wang on 15/7/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "SelectCourtController.h"
#import "SelectBranchCourtsCell.h"
#import "TeamOrderInfoController.h"
#import "BranchCourtsInfors.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
@interface SelectCourtController ()
@property (strong, nonatomic) IBOutlet UITableView *tabView;
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic)  UIButton *leftBtn;
@end

@implementation SelectCourtController
//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.navigationItem.title=@"团体预约";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    
    self.tabView.rowHeight=101;
    [self setCenterPreviewInfo];
}
-(void)leftTap{
    [self.navigationController popViewControllerAnimated:YES];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID=@"Cell";
    SelectBranchCourtsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectBranchCourtsCell" owner:nil options:nil]lastObject];
    }
    BranchCourtsInfors *branchInfos=self.arrysMuta[indexPath.row];
    cell.nameLabel.text=branchInfos.name;
    cell.phoneLabel.text=[NSString stringWithFormat:@"预约电话:%@",branchInfos.phone];
    cell.addLabel.text=[NSString stringWithFormat:@"详细地址:%@",branchInfos.addr];
    cell.timeLabel.text=[NSString stringWithFormat:@"营业时间:%@",branchInfos.serv_time];
    NSString *tempStr=[PHQDRequestUrl stringByAppendingString:branchInfos.pic];
    [cell.picIng sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectBranchCourtsCell * cell=(SelectBranchCourtsCell *)[self.tabView cellForRowAtIndexPath:indexPath];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    TeamOrderInfoController *teamOrderInfoController=[sb instantiateViewControllerWithIdentifier:@"TeamOrderInfoController"];
    teamOrderInfoController.contractName=self.contractName;
    teamOrderInfoController.groupName=self.groupName;
    teamOrderInfoController.userName=self.userName;
    teamOrderInfoController.userPhone=self.userPhone;
    teamOrderInfoController.addCon=cell.addLabel.text;
    teamOrderInfoController.codesCon=self.codesCon;
    //teamOrderInfoController
    [self.navigationController pushViewController:teamOrderInfoController animated:YES];
}

- (void)setCenterPreviewInfo
{
    [RequestServer fetchMethodName:@"centerPreview" parameters:@{@"city":self.cityContent}  shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD  successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"centerPreview"];
        for (NSDictionary *dict  in inforArys) {
            BranchCourtsInfors *branchCourtsInfor=[BranchCourtsInfors objectWithKeyValues:dict];
            [self.arrysMuta  addObject:branchCourtsInfor];
        }
        [self.tabView reloadData];
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
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


@end
