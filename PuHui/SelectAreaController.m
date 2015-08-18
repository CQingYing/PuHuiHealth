//
//  SelectAreaController.m
//  PuHui
//
//  Created by rp.wang on 15/7/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "SelectAreaController.h"
#import "SelectCourtController.h"
#import "CityInfor.h"
#import "MJExtension.h"

@interface SelectAreaController ()

@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic) IBOutlet UITableView *areaTableView;
@property (strong, nonatomic)  UIButton *leftBtn;
@end

@implementation SelectAreaController
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
    //@property (strong, nonatomic)  UIButton *leftBtn;
    self.navigationItem.title=@"团体预约";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self setAreaInfo];
}
-(void)leftTap{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
   CityInfor *area=self.arrysMuta[indexPath.row];
    cell.textLabel.text=area.city;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selCell=[self.areaTableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    SelectCourtController *selectCourtController=[sb instantiateViewControllerWithIdentifier:@"SelectCourtController"];
    
    
    selectCourtController.contractName=self.contractName;
    selectCourtController.groupName=self.groupName;
    selectCourtController.userName=self.userName;
    selectCourtController.userPhone=self.userPhone;
    selectCourtController.codesCon=self.codesCon;
    
    selectCourtController.cityContent=selCell.textLabel.text;
    [self.navigationController pushViewController:selectCourtController animated:YES];
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
