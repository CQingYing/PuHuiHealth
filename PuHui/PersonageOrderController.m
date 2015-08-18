//
//  PersonageOrderController.m
//  PuHui
//
//  Created by rp.wang on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝 王超
//  最后修改者：朱贝贝

#import "PersonageOrderController.h"
#import "SelectBranchCourtsController.h"
#import "CityInfor.h"
#import "MJExtension.h"

@interface PersonageOrderController ()

@property (weak,nonatomic) IBOutlet UITableView *areaTableView;
@property (strong, nonatomic) IBOutlet UIImageView *footImgView;
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic)  UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heiCons;
@property (strong, nonatomic) IBOutlet UITableView *heiTotal;

@end

@implementation PersonageOrderController
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
    // Do any additional setup after loading the view.
    [self setAreaInfo];
    //@property (strong, nonatomic)  UIButton *leftBtn;
    self.navigationItem.title=@"个人预约";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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
    
    //self.heiCons.constant=self.view.frame.size.height-100-104;
    return self.arrysMuta.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    CityInfor *cityInfo=self.arrysMuta[indexPath.row];
    cell.textLabel.text = cityInfo.city;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       UIStoryboard *selectBranchCourtsSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
       SelectBranchCourtsController *selectBranchCourtsController=[selectBranchCourtsSB instantiateViewControllerWithIdentifier:@"SelectBranchCourtsController"];
    
    UITableViewCell *cell = [self.areaTableView cellForRowAtIndexPath:indexPath];
    selectBranchCourtsController.cityName=cell.textLabel.text;
    selectBranchCourtsController.signOrd=self.signOrd;
    selectBranchCourtsController.orderAry=self.orderAry;
    [self.navigationController pushViewController:selectBranchCourtsController animated:YES];
}

- (void)setAreaInfo
{
    //   http://124.114.200.98:8099/PHAppServer/getCityList.action
    [RequestServer fetchMethodName:@"getCityList" parameters:nil shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD  successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"cityList"];
        for (NSDictionary *dict  in inforArys) {
            CityInfor *meals=[CityInfor objectWithKeyValues:dict];
            [self.arrysMuta  addObject:meals];
        }
        [self.areaTableView reloadData];
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}

@end
