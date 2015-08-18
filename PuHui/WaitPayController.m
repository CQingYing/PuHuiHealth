//
//  WaitPayController.m
//  PuHui
//
//  Created by administrator on 15/8/7.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "WaitPayController.h"
#import "Masonry.h"
#import "PersonInfoCell.h"
#import "MyOrderCell.h"
#import "MyOrderModel.h"
#import "SubMyOrderModel.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "MyOrderPayController.h"


@interface WaitPayController ()
@property (strong, nonatomic) UITableView *mainTable;
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic) NSMutableArray *subBigMuta;
@property (strong, nonatomic) NSMutableArray *subTempMuta;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@end

@implementation WaitPayController
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
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    // Do any additional setup after loading the view.
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:toolbar];
    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@50);
    }];
    UIButton *button = [[UIButton alloc] init];
    [toolbar addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toolbar.mas_left).offset(10);
        make.right.equalTo(toolbar.mas_right).offset(-10);
        make.top.equalTo(toolbar.mas_top).offset(7);
        make.bottom.equalTo(toolbar.mas_bottom).offset(-7);
    }];
    [button setBackgroundColor:[UIColor orangeColor]];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"确认支付" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(payTap) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100) style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTable];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(toolbar.mas_top);
    }];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    [self.mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self requestForDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.subTempMuta.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identify = @"personinfo";
        PersonInfoCell *cell = [self.mainTable dequeueReusableCellWithIdentifier:identify];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"PersonInfoCell" owner:nil options:nil]lastObject];
        }
       
        cell.name.text= [NSString stringWithFormat:@"真实姓名:%@",self.name];
        cell.phone.text= [NSString stringWithFormat:@"手机号码:%@",self.phone];
        cell.numbner.text= [NSString stringWithFormat:@"身份证号:%@",self.idCard];
        return cell;
    } else {
//        if (self.subTempMuta.count<1) {
//            static NSString *identify = @"settle";
//            MyOrderCell *cell = [self.mainTable dequeueReusableCellWithIdentifier:identify];
//            if (cell==nil)
//            {
//                cell=[[[NSBundle mainBundle]loadNibNamed:@"MyOrderCell" owner:nil options:nil]lastObject];
//            }
//            return cell;
//        }else
        {
            
            static NSString *identify = @"settle";
            MyOrderCell *cell = [self.mainTable dequeueReusableCellWithIdentifier:identify];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"MyOrderCell" owner:nil options:nil]lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SubMyOrderModel *infos=self.subTempMuta[indexPath.row];
        NSLog(@"#####%d",self.subTempMuta.count);
        cell.mealTypeLab.text=infos.name;
            
        cell.objLab.text=[NSString stringWithFormat:@"适用对象:%@",infos.age_type];
        cell.allPriLab.text=[NSString stringWithFormat:@"￥%@",infos.retail];
        cell.priceLab.text=[NSString stringWithFormat:@"￥%@",infos.cost];
        cell.codeLab.hidden=YES;
        cell.status.hidden=YES;
        NSString *tempStr=[PHQDRequestUrl stringByAppendingString:infos.pic];
            NSLog(@"dddzzz:%@",tempStr);
        [cell.iconImg sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"Zphoto_01"]];
        return cell;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"基本信息：";
    } else {
        return nil;
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 124.0;
    } else {
        return 106.0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    } else {
        return @"2015-6-26";
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 1) {
        if(self.arrysMuta.count<1){
            return nil;
        }else{
            MyOrderModel *info=self.arrysMuta[0];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16, 0, self.view.bounds.size.width-32, 20)];
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(16, 0, self.view.frame.size.width-32, 20)];
            lab.text= [NSString stringWithFormat:@"订单编号:%@",info.orderId];
            lab.font=[UIFont systemFontOfSize:12];
            lab.textColor=[UIColor grayColor];
            [view addSubview:lab];
            return view;
        }
    } else {
        return nil;
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        if(self.arrysMuta.count<1){
            return nil;
        }else
        {
        MyOrderModel *info=self.arrysMuta[0];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16, 0, self.view.bounds.size.width-32, 20)];
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 128, 20)];
        [view addSubview:time];
        time.text =info.createTime;
            
        UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-96-80, 0, 80, 20)];
        UILabel *numbers = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-96, 0, 80, 20)];
        numbers.text=[NSString stringWithFormat:@"合计:￥%@",info.discountAmount];
        numbers.textColor=[UIColor orangeColor];
        number.text=[NSString stringWithFormat:@"共%@件商品,",info.ordersCount];
        
        [view addSubview:number];
        [view addSubview:numbers];
        
        
        [time setTextColor:[UIColor grayColor]];
        [number setTextColor:[UIColor grayColor]];
        [number setTextAlignment:NSTextAlignmentRight];
        [numbers setTextAlignment:NSTextAlignmentRight];
        [time setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        [number setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        [numbers setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        return view;
        }
    } else {
        return nil;
    }
}
-(void)initDatas{


}
-(void)requestForDatas{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    
    NSLog(@"###%@##%@##%@##%@##%@##%@",self.phone,self.name,self.idCard,self.totalAmount,self.ordersCount,self.discountAmount);
    
    [RequestServer fetchMethodName:@"addOrder" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"name":self.name,@"phone":self.phone,@"idCard":self.idCard,@"ordersCount":self.ordersCount,@"totalAmount":self.totalAmount,@"discountAmount":self.discountAmount,@"data":self.datas} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
        
            MyOrderModel *infos=[MyOrderModel objectWithKeyValues:responseDic];
            [self.arrysMuta  addObject:infos];
            
            NSArray *subInforArys=responseDic[@"subData"];
            self.subTempMuta=nil;
            for (NSDictionary *subDict  in subInforArys)
            {
                SubMyOrderModel *subinfos=[SubMyOrderModel objectWithKeyValues:subDict];
                [self.subTempMuta  addObject:subinfos];
            }
        
        
        
        //调试检验数据是否正确
        MyOrderModel *info =self.arrysMuta[0];
        SubMyOrderModel *subinfosaaa= self.subTempMuta[0];
        NSLog(@"####测试数据：%@##%@###%@###%d###%@",info.name,info.phone,info.totalAmount,self.subTempMuta.count,subinfosaaa.name);
        
        [self.mainTable reloadData];
        NSLog(@"$$$$$$%@",self.datas);
        NSLog(@"^^^^^^^^%@",self.cartDatas);
        NSLog(@"^^^^^^^^%d",self.isCarts);
        
        
        
        if (self.isCarts==1) {
            [RequestServer fetchMethodName:@"deleteCart" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"data":self.cartDatas} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic)
                      {
             
                      }
                     failureHandler:^(NSString *errorInfo)
                      {
                         NSLog(@"error :%@",errorInfo);
                     }];
        }
    
    }

        failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];

}

-(void)payTap{

    [self payMeal];
}


/**
 *业务：支付功能
 *开发者：朱贝贝
 *
 *
 */
-(void)payMeal{
    /*=======================需要填写商户信息===================================*/
    /*============================================================================*/
    NSString *partner = @"2088211558696694";
    NSString *seller = @"ipuhui@sina.cn";
    //转后
    NSString   *privateKey=@"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMwrpXbXULiWe7ttFyTY6HULMnTWJP2GZ+yeGTPMN7WkoV/Wmv/LZs4/1+DuAgZmqzBiNG6rCDi+VMtT1cVvDOtzpnwqcN2PWKwRQnsesRCtnffPqDonHaE4n8Ajs/2PzAr3q7WWkt4vUJghqcxrlQawBrX3Fwc3F/2cxp9js90jAgMBAAECgYBztQSX3hyED9xdcsyb+EV9F3Rn3HioKUS6Rzr3LPQhgARogQHkl0xS9MGOWrRRFlxMFkuqsEj/h3YcqQ1MT8wcm6zrZ3eP5/gZT/4Fhgc3ws3OUvvcjobJWhJ/ZvcrzNQXIacIJmXYoBh7PMLa/lgOMbD3OoSy2dNhabmP5fYVYQJBAPh+ygHk3cUeuOlaG4+KEERUr2yku9zYLmy75IsevhpKhCn+iGMfco88xgHn8KN2RAcePe3S8yMdxmG0R68nBtMCQQDSVipnqcJTErN84ondrp91hhF0Kw2s4A0sEjitmEEz7hYMXTBOfaKZ+8wwFBNlrAyV0jvW3gtAd8cNVs2Sqn5xAkA6eLMV4QGiCYmfNxm3G9iaC4c/vD+MRr4dzdSIO9KloxUYQJFdKaAuPjGlbys7e2+kcSRHWtTlVXNBuEcJ2tgLAkEAlMXzmn0dgQriP7wwjcdc7JCWuddWBeg4COsegdMGk4ecusQTTgFZSJcsdvlMOwb1o+cfAjzuMnxGI+4427uSUQJAEUaqzHUbGtASU08expGjhC6MH4Ebxh1nukqYBSj8fznDM5mHykuYCV9T7PatZm2remXvADFdbMrXvOH9P1X4rw==";
    
    
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    NSString *names=@"";
    int  money;
    int  totalMoney = 0;
    int  cout = 0;
    for (int i=0; i<self.subTempMuta.count; i++) {
        SubMyOrderModel *info=self.subTempMuta[i];
        names=[NSString stringWithFormat:@"%@%@|",names,info.name];
        NSLog(@"###%@",names);
    }
    
    MyOrderModel *ord=self.arrysMuta[0];
    
    NSLog(@"cost^^^%@",ord.discountAmount);
    NSLog(@"buy_count^^^%@",ord.ordersCount);
    totalMoney=[ord.discountAmount intValue];;
    cout=[ord.ordersCount intValue];
    //    /**适用对象*/
    //    @property (copy, nonatomic)  NSString  * age_type;
    //    /**购买数量*/
    //    @property (assign,nonatomic)   int buy_count;
    //    /**折扣价格*/
    //    @property (assign,nonatomic)   int cost;
    //    /**适用性别 1: 男2：女*/
    //    @property (assign,nonatomic)   int gender;
    //    //**套餐详情图片*/
    //    @property (copy, nonatomic)  NSString  * info_pic;
    //    /**套餐名称*/
    //    @property (copy, nonatomic)  NSString * name;
    //    /**套餐项目*/
    //    @property (copy, nonatomic)  NSString * pack_info;
    //    /**套餐列表图片*/
    //    @property (copy, nonatomic)  NSString * pic;
    //    /**销售价*/
    //    @property  (assign,nonatomic)   int retail;
    //    /**套餐简介*/
    //    @property  (copy, nonatomic)  NSString * serv_info;
    //    /**套餐类型*/
    //    @property (strong, nonatomic)  NSString * type ;
    //    /**套餐id*/
    //    @property (strong, nonatomic)  NSString * package_id ;
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    //    NSString *names=@"";
    //    int  money;
    //    int  totalMoney = 0;
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = ord.orderId; //订单ID（由商家自行制定）
    order.productName =names; //商品标题
    //    order.productDescription = product.body; //商品描述
    // order.amount =  [NSString stringWithFormat:@"%d",totalMoney];//totalMoney; //商品价格
    order.amount =  [NSString stringWithFormat:@"%f",0.01];
    order.amount =[order.amount  substringToIndex:4];
    // order.notifyURL =  @"http://www.hao123.com"; //HDURL  这个是异步通知地址；支付之后通过这个地址发送通知给您们服务端
    order.showUrl=@"http://www.hao123.com";
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //URL types
    NSString *appScheme = @"puhui";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [self.view endEditing:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"reslut = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                
                [self  setPayInfo];
                //                MyOrderController *myOrder=[[MyOrderController alloc]init];
                //                myOrder.hidesBottomBarWhenPushed=YES;
                //                [self.navigationController pushViewController:myOrder animated:YES];
            }
        }];
    }
    
}



/**
 *  支付成功调用
 *
 *
 */
- (void)setPayInfo
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userPwdz=[user objectForKey:@"userPwdz"];
    NSString *userAccountz=[user objectForKey:@"userAccountz"];
    NSString *userIdz=[user objectForKey:@"userIdz"];
    NSString *userNamez=[user objectForKey:@"userNamez"];
    MyOrderModel *orderM=self.arrysMuta[0];
    NSString  * orderI=orderM.orderId;
    
    [RequestServer fetchMethodName:@"paymentOrders" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userName":userNamez,@"userPwd":userPwdz,@"orderId":orderI} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
        if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
            MyOrderPayController *myOrder=[[MyOrderPayController alloc]init];
            myOrder.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:myOrder animated:YES];
            [self showAllTextDialog:responseDic[@"retMsg"]];
        }
        else{
            [self showAllTextDialog:responseDic[@"retMsg"]];
        }
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
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

@end
