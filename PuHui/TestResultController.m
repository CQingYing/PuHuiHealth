//
//  TestResultController.m
//  PuHui
//
//  Created by rp.wang on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "TestResultController.h"
#import "BBRim.h"
#import "TestResultCell.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "MealInfor.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "TestResultModel.h"
#import "PersonageOrderController.h"

@interface TestResultController ()
@property (strong, nonatomic) UIButton *orderBtn;
@property (strong, nonatomic)  UILabel *lpriceLab;

@property (strong, nonatomic)  UILabel *priceLab;

@property (strong, nonatomic)  UILabel *lrealpriceLab;

@property (strong, nonatomic)  UILabel *realpriceLab;

@property (strong, nonatomic)  UILabel *allpriceLab;
@property (strong, nonatomic)  UIImageView *lineImgView;

@property (strong, nonatomic) UIView *footView;
@property (strong, nonatomic) IBOutlet UITableView *tabView;
@property (assign,nonatomic)  int totalPrice ;
@property (assign,nonatomic)  int realPrice ;
@property (strong, nonatomic)   NSMutableArray *ary;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic) NSMutableArray *arrysMuta;

@end

@implementation TestResultController

//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
//懒加载  255 73  10
- (UILabel *)priceLab
{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-88, 50, 80, 25)];
        _priceLab.text=@"￥0";
        _priceLab.font=[UIFont systemFontOfSize:22];
        _priceLab.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
    }
    return _priceLab;
}
//懒加载
- (UILabel *)realpriceLab
{
    if (!_realpriceLab) {
        _realpriceLab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-88, 80, 80, 25)];
        _realpriceLab.text=@"￥0";
        _realpriceLab.font=[UIFont systemFontOfSize:22];
        _realpriceLab.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
    }
    return _realpriceLab;
}
//懒加载
- (UILabel *)lpriceLab
{
    if (!_lpriceLab) {
        _lpriceLab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-130, 52, 42, 22)];
        _lpriceLab.text=@"原价:";
        _lpriceLab.font=[UIFont systemFontOfSize:16];
        [_lpriceLab setTextAlignment:NSTextAlignmentRight];
        _lpriceLab.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
    }
    return _lpriceLab;
}
//懒加载
- (UILabel *)lrealpriceLab
{
    if (!_lrealpriceLab) {
        _lrealpriceLab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-145, 82, 57, 22)];
        _lrealpriceLab.text=@"折扣价:";
        _lrealpriceLab.font=[UIFont systemFontOfSize:16];
        [_lrealpriceLab setTextAlignment:NSTextAlignmentRight];
        _lrealpriceLab.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
    }
    return _lrealpriceLab;
}
- (UILabel *)allpriceLab
{
    if (!_allpriceLab) {
        _allpriceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width-155, 30)];
        _allpriceLab.text=@"合计金额:";
        _allpriceLab.font=[UIFont systemFontOfSize:22];
        _allpriceLab.textColor=[UIColor colorWithRed:255.0/255.0 green:73.0/255.0 blue:10.0/255.0 alpha:1.0];
        [_allpriceLab setTextAlignment:NSTextAlignmentRight];
    }
    return _allpriceLab;
}
- (UIButton *)orderBtn
{
    if (!_orderBtn) {
        _orderBtn= [[UIButton alloc] initWithFrame:CGRectMake(16,115, self.view.frame.size.width-32, 45)];
        [_orderBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    }
    return _orderBtn;
}
- (UIView *)footView
{
    if (!_footView) {
        _footView= [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 170)];
        //_footView.backgroundColor=[UIColor redColor];
    }
    return _footView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置基础属性
    [self initBase];
    
    for (int i=0; i<self.mutaArrs.count; i++) {
        NSLog(@"!!!!!!%@",self.mutaArrs[i]);
    }
    
    [self loadDatas];
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
    return self.arrysMuta.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"Cell";
    

    TestResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
  
    if (cell==nil) {
        //注意：cell的xib文件必须设定Identifier为Cell，即为ID
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TestResultCell" owner:nil options:nil]lastObject];
    }
    if([self.ary[indexPath.row] isEqualToString:@"1"]){
        
        cell.isCheckBox.image=[UIImage imageNamed:@"personcheckbox"];
    }else{
        
        cell.isCheckBox.image=[UIImage imageNamed:@"personnotcheckbox"];
    }
    
    TestResultModel *info=self.arrysMuta[indexPath.row];
    //priceLab,realPriceLab nameLab
    cell.priceLab.text=info.itemRetail;
    cell.realPriceLab.text=info.itemCost;
    cell.nameLab.text=info.itemName;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TestResultCell *cell = (TestResultCell * )[tableView cellForRowAtIndexPath:indexPath];
    if([cell.isSele.text isEqualToString:@"未选中"]){
        self.totalPrice=0;
        self.realPrice=0;
        self.ary[indexPath.row]=@"1";
        cell.isCheckBox.image=[UIImage imageNamed:@"personcheckbox"];
        cell.isSele.text=@"选中";
        NSLog(@"$$$$$%@",self.ary);
       // 计算总价
        NSLog(@"$$$$$%d",self.ary.count);
        for (int i=0; i<self.arrysMuta.count; i++) {
            if ([self.ary[i] isEqualToString:@"1"]) {
                //第i行的价钱加到总价  （用真实数据操作）  4处要改
                TestResultModel *info=self.arrysMuta[i];
                self.realPrice+=[info.itemCost intValue];
                self.totalPrice+=[info.itemRetail intValue];
            }
        }
        self.priceLab.text=[NSString stringWithFormat:@"%d",self.totalPrice];
        self.realpriceLab.text=[NSString stringWithFormat:@"%d",self.realPrice];
        
        return;
    }
    else if([cell.isSele.text isEqualToString:@"选中"]){
        self.totalPrice=0;
        self.realPrice=0;
        self.ary[indexPath.row]=@"0";
        cell.isCheckBox.image=[UIImage imageNamed:@"personnotcheckbox"];
        cell.isSele.text=@"未选中";
        NSLog(@"%@",self.ary);
        // 计算总价
        for (int i=0; i<self.arrysMuta.count; i++) {
            if ([self.ary[i] isEqualToString:@"1"]) {
                //第i行的价钱加到总价
                TestResultModel *info=self.arrysMuta[i];
                self.realPrice+=[info.itemCost intValue];
                self.totalPrice+=[info.itemRetail intValue];
            }
        }
        self.priceLab.text=[NSString stringWithFormat:@"%d",self.totalPrice];
        self.realpriceLab.text=[NSString stringWithFormat:@"%d",self.realPrice];
        return;
    }

}

-(void)initBase{
    //设置按钮属性
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.orderBtn radius:6 width:1 color:[UIColor orangeColor]];
    self.orderBtn.backgroundColor=[UIColor orangeColor];
    [self.orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.orderBtn addTarget:self action:@selector(orderTap) forControlEvents:UIControlEventTouchUpInside];
    //设置tabView属性
   
    
   // [self.tabView setTableFooterView:self.footView];
    
    [self.view addSubview:self.footView];
    
    self.tabView.rowHeight=80;
    [self.footView addSubview:self.priceLab];
    [self.footView addSubview:self.realpriceLab];
    [self.footView addSubview:self.lpriceLab];
    [self.footView addSubview:self.lrealpriceLab];
    [self.footView addSubview:self.allpriceLab];
    [self.footView addSubview:self.orderBtn];
    self.totalPrice=0;
    self.realPrice=0;
    self.ary=[[NSMutableArray alloc]init];
    for (int i=0; i<self.arrysMuta.count; i++)
    {
        [self.ary addObject:@"0"];
    }
}
-(void)aryInit{
    self.ary=[[NSMutableArray alloc]init];
    NSLog(@"####%d",self.arrysMuta.count);
    for (int i=0; i<self.arrysMuta.count; i++)
    {
        [self.ary addObject:@"0"];
    }
    
    NSLog(@"####%d",self.ary.count);

}
-(void)loadDatas{


    /**
     *  获得套餐列表信息
     *
     */
    //"肝功10项","血脂二项","胃蛋白酶原"   //self.endmutaArrs
        [RequestServer fetchMethodName:@"health_appserv_itemDetail" parameters:@{@"itemList":self.endmutaArrs} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiYW successHandler:^(NSMutableDictionary *responseDic) {
            if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
                 NSArray *inforArys=responseDic[@"data"];
                  //方式1
                 for (NSDictionary *dict  in inforArys) {
                     TestResultModel *meals=[TestResultModel objectWithKeyValues:dict];
                     [self.arrysMuta  addObject:meals];
                 }

            }else{
                [self showAllTextDialog:responseDic[@"retMsg"]];
            }
            [self aryInit];
            [self.tabView reloadData];
        } failureHandler:^(NSString *errorInfo) {
            NSLog(@"error :%@",errorInfo);
        }];
}
//立即预约
-(void)orderTap{
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    PersonageOrderController *selectCourtController=[sb instantiateViewControllerWithIdentifier:@"PersonageOrderController"];
    
    NSMutableArray *teamp=[[NSMutableArray alloc]init];
    int k=0;
    for (int j=0 ; j<self.ary.count; j++) {
        if([self.ary[j] isEqualToString:@"1"]){
            [teamp addObject:self.arrysMuta[j]];
        }
    }
    
    NSLog(@"####%@",teamp);
    if(teamp.count<1){
        [self showAllTextDialog:@"请选择体检项目来进行预约!"];
        return;
    }
    selectCourtController.orderAry=teamp;
    selectCourtController.signOrd=2;
    [self.navigationController pushViewController:selectCourtController animated:YES];
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
@end
