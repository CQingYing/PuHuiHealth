//
//  SelectBranchCourtsController.m
//  PuHui
//
//  Created by rp.wang on 15/7/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "SelectBranchCourtsController.h"
#import "SelectBranchCourtsCell.h"
#import "SelectSetMealController.h"
#import "BranchCourtsInfors.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "SureOrderController.h"

@interface SelectBranchCourtsController ()
@property (strong, nonatomic) IBOutlet UITableView *selectCourtsTableView;
@property (strong, nonatomic) NSMutableArray *arrMuta;
@property (assign,nonatomic) int temp;
@property (strong, nonatomic)  UIButton *leftBtn;
@end

@implementation SelectBranchCourtsController
- (NSMutableArray *)arrMuta
{
    if (!_arrMuta) {
        _arrMuta=[NSMutableArray array];
    }
    return _arrMuta;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectCourtsTableView.rowHeight=101;
    [self setAreaDetailInfo];
    self.navigationItem.title=@"个人预约";
    
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    
    //    [self.leftBtn setTitle:@"Back" forState:UIControlStateNormal];
    //    [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];

}
-(void)leftTap{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMuta.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"Cell";
    SelectBranchCourtsCell *cell = [self.selectCourtsTableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectBranchCourtsCell" owner:nil options:nil]lastObject];
    }
    BranchCourtsInfors *branchInfos=self.arrMuta[indexPath.row];
    cell.nameLabel.text=branchInfos.name;
    cell.phoneLabel.text=[NSString stringWithFormat:@"预约电话:%@",branchInfos.phone];
    cell.addLabel.text=[NSString stringWithFormat:@"详细地址:%@",branchInfos.addr];
    cell.timeLabel.text=[NSString stringWithFormat:@"营业时间:%@",branchInfos.serv_time];
    NSString *tempStr=[PHQDRequestUrl stringByAppendingString:branchInfos.pic];
    [cell.picIng sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectBranchCourtsCell  *selectCell=(SelectBranchCourtsCell *)[self.selectCourtsTableView cellForRowAtIndexPath:indexPath];
    
    
    if (self.signOrd==2) {
        
        UIStoryboard *selectSetMealSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
        SureOrderController *selectSetMealController=[selectSetMealSB instantiateViewControllerWithIdentifier:@"SureOrderController"];
        selectSetMealController.adContent=selectCell.addLabel.text;
        selectSetMealController.orderAry=self.orderAry;
        selectSetMealController.signOrd=self.signOrd;
        
        [self.navigationController pushViewController:selectSetMealController animated:YES];
        
    }else{
        UIStoryboard *selectSetMealSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
        SelectSetMealController *selectSetMealController=[selectSetMealSB instantiateViewControllerWithIdentifier:@"SelectSetMealController"];
        selectSetMealController.addContent=selectCell.addLabel.text;
        
        
        [self.navigationController pushViewController:selectSetMealController animated:YES];
    
    }
   
}

- (void)setAreaDetailInfo
{
    [RequestServer fetchMethodName:@"centerPreview" parameters:@{@"city":self.cityName}  shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD  successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"centerPreview"];
        for (NSDictionary *dict  in inforArys) {
            BranchCourtsInfors *branchCourtsInfor=[BranchCourtsInfors objectWithKeyValues:dict];
            [self.arrMuta  addObject:branchCourtsInfor];
        }
      [self.selectCourtsTableView reloadData];
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}

@end
