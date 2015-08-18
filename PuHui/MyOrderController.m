//
//  MyOrderController.m
//  PuHui
//
//  Created by rp.wang on 15/7/8.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "MyOrderController.h"
#import "MyOrderCell.h"
#import "HeadSectionView.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MyOrderModel.h"
#import "SubMyOrderModel.h"
#import "MBProgressHUD.h"

@interface MyOrderController ()  

@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic) NSMutableArray *subBigMuta;
@property (strong, nonatomic) NSMutableArray *subTempMuta;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic)  UIButton *leftBtn;

@end

@implementation MyOrderController
//懒加载
//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
- (NSMutableArray *)subBigMuta
{
    if (!_subBigMuta) {
        _subBigMuta=[[NSMutableArray alloc]init];
    }
    return _subBigMuta;
}
- (NSMutableArray *)subTempMuta
{
    if (!_subTempMuta) {
        _subTempMuta=[[NSMutableArray alloc]init];
    }
    return _subTempMuta;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    // 网络请求
    [self myOrder];
   }
-(void)initData{
    self.tableView.rowHeight=105;
    //导航栏右边按钮
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    
    self.navigationItem.title=@"我的订单";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(rightTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    
//    self.navigationItem.hidesBackButton = YES;
//    UIButton* backButton = [UIButton buttonWithType:101];//UIButtonType，其实101和系统返回按钮一样
//    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    //[backButton setTitle:@"返回" forState:UIControlStateNormal];
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem = leftBtn;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.arrysMuta.count;
}
/*设置标题头的宽度*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
/*设置标题尾的宽度*/
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 36;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    HeadSectionView *vi=[[HeadSectionView alloc]init];
    UIView *CusView=[[UIView alloc]init];
    for (int i=0; i<self.arrysMuta.count; i++) {
        if (section==i) {
           MyOrderModel *info= self.arrysMuta[i];
             CusView=[vi objFootViewX:self.view.frame.size.width viewY:36 timeTxt:info.createTime countTxt:[NSString stringWithFormat:@"共%@件商品，",info.ordersCount] totalTxt:[NSString stringWithFormat:@"合计：￥%@",info.discountAmount]];
        }
    }
    
        return CusView ;
    
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
        
    HeadSectionView *vi=[[HeadSectionView alloc]init];
    UIView *CusView=[[UIView alloc]init];
    for (int i=0; i<self.arrysMuta.count; i++) {
        if (section==i) {
            MyOrderModel *info= self.arrysMuta[i];
            NSString *sta=[NSString string];
            if ([info.orderStatus isEqualToString:@"0"]) {
                sta=@"全部";
            }else if([info.orderStatus isEqualToString:@"1"]){
                sta=@"待付款";
            }else if([info.orderStatus isEqualToString:@"2"]){
                sta=@"支付成功";
            }else if([info.orderStatus isEqualToString:@"3"]){
                sta=@"订单关闭";
            }
            CusView=[vi objHeadViewX:self.view.frame.size.width viewY:30 codeTxt:[NSString stringWithFormat:@"订单编号:%@",info.orderId] tradeTxt:[NSString stringWithFormat:@"%@",sta]];
        }
    }
        return CusView ;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *ary=[self.subBigMuta objectAtIndex:section];
    return  ary.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID=@"CellMyOrder";
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyOrderCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (int i=0; i<self.arrysMuta.count; i++) {
        if (indexPath.section==i) {
            NSArray *arys=self.subBigMuta[i];
            SubMyOrderModel *inf= arys[indexPath.row];
            cell.mealTypeLab.text=inf.name;
            cell.allPriLab.text=[NSString stringWithFormat:@"￥%@",inf.retail];
            cell.priceLab.text=[NSString stringWithFormat:@"￥%@",inf.cost];
            cell.status.text=inf.subOrderStatus;
            if ([inf.subOrderStatus isEqualToString:@"0"]) {
                cell.status.text=@"未支付";
            }else if([inf.subOrderStatus isEqualToString:@"1"]){
                cell.status.text=@"待销费";
            }else if([inf.subOrderStatus isEqualToString:@"2"]){
                cell.status.text=@"已消费";
            }
            cell.codeLab.text=[NSString stringWithFormat:@"凭证码:%@",inf.voucherCode];
            cell.objLab.text=[NSString stringWithFormat:@"适用对象:%@",inf.age_type];
            
            NSString *tempStr=[PHQDRequestUrl stringByAppendingString:inf.pic];
            [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
        }
    }
    return cell;
}

-(void)rightTap{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)myOrder{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *userIdz=[user objectForKey:@"userIdz"];
    NSString *userAccountz=[user objectForKey:@"userAccountz"];
    NSString *userPwdz=[user objectForKey:@"userPwdz"];
    
    [RequestServer fetchMethodName:@"myOrder" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userPwd":userPwdz,@"orderStatus":@"1",@"orderDate":@""} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {

        NSArray *inforArys=responseDic[@"data"];
        if (inforArys.count==0) {
            [self showAllTextDialog:@"当前无订单！"];
            return ;
        }
        //方式1
        for (NSDictionary *dict  in inforArys) {
            MyOrderModel *infos=[MyOrderModel objectWithKeyValues:dict];
            [self.arrysMuta  addObject:infos];
            
            NSArray *subInforArys=dict[@"subData"];
            self.subTempMuta=nil;
            for (NSDictionary *subDict  in subInforArys)
            {
                SubMyOrderModel *subinfos=[SubMyOrderModel objectWithKeyValues:subDict];
                [self.subTempMuta  addObject:subinfos];
            }
            [self.subBigMuta  addObject:self.subTempMuta];
        }
        
        
        //调试检验数据是否正确
        MyOrderModel *info =self.arrysMuta[0];
        NSArray *ary= self.subBigMuta[0];
        SubMyOrderModel *subinfosaaa= ary[0];
        NSLog(@"####%@##%@###%@###%d###%@",info.name,info.phone,info.totalAmount,ary.count,subinfosaaa.name);
        
        [self.tableView reloadData];
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}

- (CGRect)rectForHeaderInSection:(NSInteger)section{
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, 100);
    return frame;
}
- (CGRect)rectForFooterInSection:(NSInteger)section{
    CGRect frame=CGRectMake(0, 0, self.view.frame.size.width, 100);
    return frame;
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
