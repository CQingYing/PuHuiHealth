//
//  MyAppointmentController.m
//  PuHui
//
//  Created by administrator on 15/8/4.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "MyAppointmentController.h"
#import "RequestServer.h"
#import "Masonry.h"
#import "SingleAppointmentCell.h"
#import "OtherAppointmentCell.h"
#import "detailViewController.h"
#import "PersonDetailViewController.h"

@interface MyAppointmentController ()
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) UITableView *mainTable;
@property (strong, nonatomic)  UIButton *leftBtn;
@end

@implementation MyAppointmentController

- (NSMutableArray *)array {
    if (!_array) {
        _array = [[NSMutableArray alloc] init];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏右边按钮
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    //@property (strong, nonatomic)  UIButton *leftBtn;
    self.navigationItem.title=@"我的预约";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(rightTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    
    [self getInfo];
    self.mainTable = [[UITableView alloc] init];
    [self.mainTable setDataSource:self];
    [self.mainTable setDelegate:self];
    [self.view addSubview:self.mainTable];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    self.mainTable.rowHeight = 150;
    [self.mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainTable setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getInfo {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"myAppointment" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        self.array = responseDic[@"data"];
        [self.mainTable reloadData];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.array objectAtIndex:indexPath.row][@"appointType"] isEqualToString:@"0"]) {
        static NSString *ID = @"SingleApp";
        SingleAppointmentCell *cell = [self.mainTable dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"SingleAppointmentCell" owner:nil options:nil]lastObject];
        }
        NSString *temp = @"";
        cell.setname.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"name"]];
        temp = @"姓名:";
        cell.name.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"appointName"]];
        temp = @"手机号:";
        cell.phone.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"appointPhone"]];
        temp = @"体检时间:";
        cell.time.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"appointTime"]];
        temp = @"体检地址:";
        cell.address.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"appointAddress"]];
        return cell;
    } else {
        static NSString *ID = @"OtherApp";
        OtherAppointmentCell *cell = [self.mainTable dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"OtherAppointmentCell" owner:nil options:nil]lastObject];
        }
        NSString *temp = @"姓名:";
        cell.name.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"appointName"]];
        temp = @"手机号:";
        cell.phone.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"appointPhone"]];
        temp = @"体检时间:";
        cell.time.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"appointTime"]];
        temp = @"体检地址:";
        cell.address.text = [temp stringByAppendingString:[self.array objectAtIndex:indexPath.row][@"appointAddress"]];
        if ([[self.array objectAtIndex:indexPath.row][@"appointType"] isEqualToString:@"1"]) {
            UIImage *type = [UIImage imageNamed:@"group_01"];
            UIImage *img = [UIImage imageNamed:@"group"];
            cell.type.image = type;
            cell.img.image = img;
        } else {
            UIImage *type = [UIImage imageNamed:@"individual_01"];
            UIImage *img = [UIImage imageNamed:@"individual"];
            cell.type.image = type;
            cell.img.image = img;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.array objectAtIndex:indexPath.row][@"appointType"] isEqualToString:@"0"]) {
//        [RequestServer fetchMethodName:@"getPackageById" parameters:@{@"package_id":[NSString stringWithFormat:@"%ld",(long)([self.array objectAtIndex:indexPath.row][@"package_id"])]} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiYW successHandler:^(NSMutableDictionary *responseDic) {
//            NSDictionary *dict = responseDic[@"data"];
//            SetModel *meals=[SetModel objectWithKeyValues:dict];
//            detailViewController *dv = [[detailViewController alloc] initWithData:meals];
//            dv.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:dv animated:YES];
//            [tableView cellForRowAtIndexPath:indexPath].selected = NO;
//        } failureHandler:^(NSString *errorInfo) {
//            NSLog(@"error :%@",errorInfo);
//        }];
    } else if ([[self.array objectAtIndex:indexPath.row][@"appointType"] isEqualToString:@"2"]) {
        PersonDetailViewController *pdvc = [[PersonDetailViewController alloc] initWithData:[self.array objectAtIndex:indexPath.row][@"itemList"]];
        [self.navigationController pushViewController:pdvc animated:YES];
        [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    } else {
        [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    }
}

-(void)rightTap{
    [self.navigationController popViewControllerAnimated:YES];
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
