//
//  SelectSetMealController.m
//  PuHui
//
//  Created by rp.wang on 15/7/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "SelectSetMealController.h"
#import "BBRim.h"
#import "SelectSetMealCell.h"
#import "OrderInforController.h"
#import "AFNetworking.h"
#import "MealInfor.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@interface SelectSetMealController ()
@property (strong, nonatomic) IBOutlet UIButton *selemeal;
@property (strong, nonatomic) IBOutlet UITableView *selectMeal;
@property (strong, nonatomic)  UITableView *spinnerTabView;
@property (strong, nonatomic)  NSArray *spinContentAry;
@property (assign,nonatomic) int temp;
@property (strong, nonatomic) IBOutlet UIImageView *maleImgView;
@property (strong, nonatomic) IBOutlet UIImageView *femaleImgView;
@property (strong, nonatomic) IBOutlet UIImageView *allImgView;
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic) NSMutableArray *tempMuta;
@property (assign,nonatomic)  int ismael;
@property (strong, nonatomic)  UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *heiCons;
@end

@implementation SelectSetMealController
//懒加载
//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
//*筛选临时的模型数据*/
- (NSMutableArray *)tempMuta
{
    if (!_tempMuta) {
        _tempMuta=[[NSMutableArray alloc]init];
    }
    return _tempMuta;
}

- (UITableView *)spinnerTabView
{
    if (!_spinnerTabView) {
        _spinnerTabView= [[UITableView alloc] init];
        _spinnerTabView.frame = CGRectMake(self.view.frame.size.width-98,CGRectGetMaxY(self.selemeal.frame)+15, 90, 101);
    }
    return _spinnerTabView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置下拉按钮属性
    self.navigationItem.title=@"个人预约";
    
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    
    //    [self.leftBtn setTitle:@"Back" forState:UIControlStateNormal];
    //    [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];

    self.selemeal.backgroundColor=[UIColor whiteColor];
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.selemeal radius:4 width:1 color:[UIColor whiteColor]];
    [self.selemeal setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -125)];
    [self.selemeal setTitleEdgeInsets:UIEdgeInsetsMake(0, -26, 0, 0)];
    self.selectMeal.rowHeight=101;
    self.spinnerTabView.userInteractionEnabled=YES;
    self.spinnerTabView.delegate=self;
    self.spinnerTabView.dataSource=self;
    self.spinnerTabView.rowHeight=25;
    [self.spinnerTabView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.spinContentAry=@[@"全部套餐",@"标准套餐",@"特色套餐",@"免费套餐"];
    //选择点击时间
    [self setImageTap];
    //加载数据
    [self setMealInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftTap{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectMeal:(id)sender {
    if (self.temp==0) {
        [self.spinnerTabView reloadData];
        [self.view addSubview:self.spinnerTabView];
        self.temp=1;
        return;
    }
    if (self.temp==1) {
        [self.spinnerTabView removeFromSuperview];
        self.temp=0;
        return;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==self.selectMeal){
    return 1;
    }else{
    return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.selectMeal){
        return self.tempMuta.count;
    }else{
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.selectMeal)
    {
       static NSString *ID=@"CellSeleMeal";
       SelectSetMealCell *cell = [self.selectMeal dequeueReusableCellWithIdentifier:ID];
       if (cell==nil)
       {
          cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectSetMealCell" owner:nil options:nil]lastObject];
       }
        MealInfor *mealInfor=self.tempMuta[indexPath.row];
        cell.mealType.text=mealInfor.name;
        cell.inPrice.text= [NSString stringWithFormat:@"内部折扣价:%d", mealInfor.cost];
        cell.allPrice.text=[NSString stringWithFormat:@"金额:%d",mealInfor.retail];
        cell.adjusObj.text=mealInfor.age_type;
        cell.purchaseCount.text=[NSString stringWithFormat:@"%d人已经购买",mealInfor.buy_count];
        cell.mealInfoLabel.text=mealInfor.pack_info;
        cell.mealSimLabel.text=mealInfor.serv_info;
        cell.picInfoLabel.text=mealInfor.info_pic;
        cell.pagID.text=mealInfor.package_id;
        NSString *tempStr=[PHQDRequestUrl stringByAppendingString:mealInfor.pic];
        [cell.cellImg sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
        return cell;
    }else
    {
        
         static NSString *ID=@"Cell";
         UITableViewCell *cell = [self.spinnerTabView dequeueReusableCellWithIdentifier:ID];
             if (cell==nil)
             {
                 cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            }
        cell.textLabel.text=self.spinContentAry[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        return cell;
     }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.selectMeal)
    {
    SelectSetMealCell  *selectCell=(SelectSetMealCell *)[self.selectMeal cellForRowAtIndexPath:indexPath];
    UIStoryboard *orderInforSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    OrderInforController *orderInforController=[orderInforSB instantiateViewControllerWithIdentifier:@"OrderInforController"];
        orderInforController.mealInfoContent=selectCell.mealInfoLabel.text;
        orderInforController.mealSimContent=selectCell.mealSimLabel.text;
        orderInforController.ageTypeContent=selectCell.adjusObj.text;
        orderInforController.addrContent=self.addContent;
        orderInforController.mealTypeContent=selectCell.mealType.text;
        orderInforController.infoPicContent=selectCell.picInfoLabel.text;
        orderInforController.pagIDContent=selectCell.pagID.text;
    [self.navigationController pushViewController:orderInforController animated:YES];
    }else
    {   self.temp=0;
        //此刻的界面数据是self.tempMuta 在这个里面筛选
        UITableViewCell *cell = [self.spinnerTabView cellForRowAtIndexPath:indexPath];
        [self.selemeal setTitle:cell.textLabel.text forState:UIControlStateNormal];
        //cell.textLabel.text
        //将符合帅选条件的数据放进self.twoMuta中
        self.tempMuta=nil;
        if (self.ismael==1) {
            for (MealInfor * info in self.arrysMuta) {
                if(info.gender!=2&&([info.type isEqualToString:cell.textLabel.text]||[@"全部套餐" isEqualToString:cell.textLabel.text])){
                    [self.tempMuta addObject:info];
                }
            }
        }
        if (self .ismael==2) {
            for (MealInfor * info in self.arrysMuta) {
                if(info.gender!=1&&([info.type isEqualToString:cell.textLabel.text]||[@"全部套餐"isEqualToString:cell.textLabel.text])){
                        [self.tempMuta addObject:info];
                    }
                }
        }
        if (self.ismael==0) {
            for (MealInfor * info in self.arrysMuta) {
                    if([info.type isEqualToString:cell.textLabel.text]||[@"全部套餐" isEqualToString:cell.textLabel.text]){
                        [self.tempMuta addObject:info];
                    }
            }
        }
        [self.spinnerTabView removeFromSuperview];
        [self.selectMeal reloadData];
    }
}

/**
 *  获得套餐列表信息
 *
 */
- (void)setMealInfo
{
    [RequestServer fetchMethodName:@"get_serv_price_by_orgId" parameters:@{@"serv_price.org_id":@"4"} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"serv_price_list"];
        
        //方式1
        for (NSDictionary *dict  in inforArys) {
            MealInfor *meals=[MealInfor objectWithKeyValues:dict];
            [self.arrysMuta  addObject:meals];
        }
        for (MealInfor * info in self.arrysMuta)
        {
            [self.tempMuta addObject:info];
        }
        [self.selectMeal reloadData];
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{   self.temp=0;
    [self.spinnerTabView removeFromSuperview];
}
-(void)setImageTap{
    self.maleImgView.userInteractionEnabled=YES;
    self.femaleImgView.userInteractionEnabled=YES;
    self.allImgView.userInteractionEnabled=YES;
    //手势
    UITapGestureRecognizer *maleSingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maleImgViewTap)];
    UITapGestureRecognizer *femaleSingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(femaleImgViewTap)];
    UITapGestureRecognizer *allSingleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allImgViewTap)];
    //添加手势
    [self.maleImgView addGestureRecognizer:maleSingleTap];
    [self.femaleImgView addGestureRecognizer:femaleSingleTap];
    [self.allImgView addGestureRecognizer:allSingleTap];
}
-(void)maleImgViewTap{
    self.ismael=1;
    [self.maleImgView setImage:[UIImage imageNamed:@"per_selected"]];
    [self.femaleImgView setImage:[UIImage imageNamed:@"not_selected"]];
    [self.allImgView setImage:[UIImage imageNamed:@"not_selected"]];
    self.tempMuta=nil;
    //self.twoMuta=nil;
    for (MealInfor * info in self.arrysMuta) {
        if(info.gender!=2&&([info.type isEqualToString:self.selemeal.titleLabel.text]||[@"全部套餐" isEqualToString:self.selemeal.titleLabel.text])){
            [self.tempMuta addObject:info];
        }
    }
    [self.selectMeal reloadData];
}
-(void)femaleImgViewTap{
    self.ismael=2;
    [self.maleImgView setImage:[UIImage imageNamed:@"not_selected"]];
    [self.femaleImgView setImage:[UIImage imageNamed:@"per_selected"]];
    [self.allImgView setImage:[UIImage imageNamed:@"not_selected"]];
    self.tempMuta=nil;
    for (MealInfor * info in self.arrysMuta) {
        if(info.gender!=1&&([info.type isEqualToString:self.selemeal.titleLabel.text]||[@"全部套餐" isEqualToString:self.selemeal.titleLabel.text])){
            [self.tempMuta addObject:info];
        }
    }
    [self.selectMeal reloadData];
}
-(void)allImgViewTap{
    self.ismael=0;
    [self.maleImgView setImage:[UIImage imageNamed:@"not_selected"]];
    [self.femaleImgView setImage:[UIImage imageNamed:@"not_selected"]];
    [self.allImgView setImage:[UIImage imageNamed:@"per_selected"]];
    self.tempMuta=nil;
    for (MealInfor * info in self.arrysMuta)
    {
    if([info.type isEqualToString:self.selemeal.titleLabel.text]||[@"全部套餐" isEqualToString:self.selemeal.titleLabel.text]){
       [self.tempMuta addObject:info];
        }
    }
    [self.selectMeal reloadData];
}
@end
