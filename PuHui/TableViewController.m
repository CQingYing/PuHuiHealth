//
//  TableViewController.m
//  PuHui
//
//  Created by rp.wang on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "TableViewController.h"
#import "PersonController.h"
#import "TableViewCell.h"
#import "BBRim.h"

@interface TableViewController ()
@property (strong, nonatomic)  PersonController *perController;
@property (strong, nonatomic) NSArray *aryImage;
@property (strong, nonatomic) NSArray *aryLabel;
@property (strong, nonatomic) IBOutlet UITableView *tabView;
@property (strong, nonatomic) NSArray *aryArrow;
//@property (strong, nonatomic) IBOutlet UITableView *tabView;
@end

@implementation TableViewController
//懒加载
- (NSArray *)aryImage
{
    if (!_aryImage) {
        _aryImage = @[@"person_muzhi",@"person_car",@"person_yuyue",@"person_pen",@"person_setting"];
    }
    return _aryImage;
}
- (NSArray *)aryLabel
{
    if (!_aryLabel) {
        _aryLabel= @[@"内部推荐",@"我的订单",@"我的预约",@"给我们留言",@"系统更新"];
    }
    return _aryLabel;
}
- (NSArray *)aryArrow
{
    if (!_aryArrow) {
        _aryArrow = @[@"person_ye_arr",@"person_arrow"];
    }
    return _aryArrow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(8, 20, self.view.frame.size.width-16, self.view.frame.size.height-20) style:UITableViewStyleGrouped ];
    self.tableView.scrollEnabled=NO;
    self.tableView.rowHeight=53;
    //@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle;
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
    {
        return 1;
    }else if(section==1)
    {
        return 2;
    }else
    {
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *ID=@"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil]lastObject];
    }
    if (indexPath.section==0) {
        cell.leftLcon.image=[UIImage imageNamed:self.aryImage[indexPath.row]];
        cell.centerLabel.text=self.aryLabel[indexPath.row];
        cell.centerLabel.textColor=[UIColor orangeColor];
        cell.rightIcon.image=[UIImage imageNamed:self.aryArrow[0]];
    }
    if (indexPath.section==1) {
        
        cell.leftLcon.image=[UIImage imageNamed:self.aryImage[indexPath.row+1]];
        cell.centerLabel.text=self.aryLabel[indexPath.row+1];
        cell.rightIcon.image=[UIImage imageNamed:self.aryArrow[1]];
    }
    if (indexPath.section==2) {
        cell.leftLcon.image=[UIImage imageNamed:self.aryImage[indexPath.row+3]];
        cell.centerLabel.text=self.aryLabel[indexPath.row+3];
        cell.rightIcon.image=[UIImage imageNamed:self.aryArrow[1]];
    }
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
