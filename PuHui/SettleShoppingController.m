//
//  SettleShoppingController.m
//  PuHui
//
//  Created by administrator on 15/7/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "SettleShoppingController.h"
#import "detailViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "MyOrderController.h"
#import "MBProgressHUD.h"
#import "MyOrderPayController.h"
#import "WaitPayController.h"

@interface SettleShoppingController ()
@property (strong, nonatomic)  NSString *orderId;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@end

@implementation SettleShoppingController
@synthesize dataArray,cost,numberText,phoneText,nameText;

- (id)initwithArray:(NSArray *)_array
{
    if ([self init]) {
        dataArray = [NSArray arrayWithArray:_array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    costMoney = 0;
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userName=[user objectForKey:@"userNamez"];
    NSString *userAccount=[user objectForKey:@"userAccountz"];
    UILabel *bottomTitle = [[UILabel alloc] init];
    bottomTitle.numberOfLines = 0;
    [bottomTitle setText:@"温馨提示：请正确输入手机号，购买成功后我们会将数字密码发送至您的手机"];
    [bottomTitle setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [self.view addSubview:bottomTitle];
    [bottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    [bottomTitle setTextAlignment:NSTextAlignmentCenter];
    UIButton *configButton = [UIButton new];
    [self.view addSubview:configButton];
    [configButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomTitle.mas_top).offset(-5);
        make.left.right.equalTo(bottomTitle);
        make.height.mas_equalTo(@30);
    }];
    [configButton setBackgroundColor:[UIColor orangeColor]];
    UILabel *buttonlabel = [UILabel new];
    [configButton addSubview:buttonlabel];
    [buttonlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(configButton);
    }];
    buttonlabel.text = @"确认结算";
    buttonlabel.textColor = [UIColor whiteColor];
    [buttonlabel setTextAlignment:NSTextAlignmentCenter];
    configButton.layer.cornerRadius = 5;
    configButton.layer.masksToBounds = YES;

    UIView *bottomLine1 = [[UIView alloc] init];
    [bottomLine1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:bottomLine1];
    [bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(configButton);
        make.bottom.equalTo(configButton.mas_top).offset(-3);
        make.height.mas_equalTo(@1);
    }];
    
    UILabel *label1 = [UILabel new];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomLine1.mas_top);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@20);
    }];
    label1.textColor = [UIColor redColor];
    label1.text = @"合计金额:";
    [label1 setTextAlignment:NSTextAlignmentRight];
    [label1 setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    cost = [UILabel new];
    [self.view addSubview:cost];
    [cost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(configButton.mas_right);
        make.bottom.equalTo(bottomLine1.mas_top);
        make.left.equalTo(label1.mas_right).offset(5);
        make.height.mas_equalTo(@30);
    }];
    for (SetModel *sm in dataArray) {
        costMoney += sm.buy_count*sm.cost;
    }
    cost.text = [NSString stringWithFormat:@"¥%d",costMoney];
    cost.textColor = [UIColor redColor];
    [cost setTextAlignment:NSTextAlignmentRight];
    
    UIView *bottomLine2 = [[UIView alloc] init];
    [bottomLine2 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(configButton);
        make.bottom.equalTo(cost.mas_top);
        make.height.mas_equalTo(@1);
    }];
    
    UIImage *image2 = [UIImage imageNamed:@"Icon_03"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    [self.view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(configButton.mas_left).offset(15);
        make.bottom.equalTo(bottomLine2.mas_top).offset(-7);
        make.height.mas_equalTo(image2.size.height);
        make.width.mas_equalTo(image2.size.width);
    }];
//    UILabel *label2 = [UILabel new];
//    label2.text = @"身份证号：";
//    [label2 setTextColor:[UIColor lightGrayColor]];
//    [self.view addSubview:label2];
//    [label2 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(imageView2);
//        make.left.equalTo(imageView2.mas_right).offset(3);
//        make.width.mas_equalTo(@70);
//    }];
    numberText = [UITextField new];
    [self.view addSubview:numberText];
    [numberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView2.mas_right).offset(10);
        make.bottom.equalTo(imageView2.mas_bottom);
        make.right.equalTo(configButton.mas_right);
        make.top.equalTo(imageView2.mas_top);
    }];
    numberText.placeholder = @"身份证号码";
    [numberText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    UIView *bottomLine3 = [[UIView alloc] init];
    [bottomLine3 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:bottomLine3];
    [bottomLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(configButton);
        make.bottom.equalTo(numberText.mas_top).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    UIImage *image3 = [UIImage imageNamed:@"Icon_02"];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:image3];
    [self.view addSubview:imageView3];
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView2.mas_centerX);
        make.bottom.equalTo(bottomLine3.mas_top).offset(-7);
        make.height.mas_equalTo(image3.size.height);
        make.width.mas_equalTo(image3.size.width);
    }];
//    UILabel *label3 = [UILabel new];
//    label3.text = @"手机号码：";
//    [label3 setTextColor:[UIColor lightGrayColor]];
//    [self.view addSubview:label3];
//    [label3 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(imageView3);
//        make.left.equalTo(label2.mas_left);
//        make.width.mas_equalTo(@70);
//    }];
    phoneText = [UITextField new];
    [self.view addSubview:phoneText];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberText.mas_left);
        make.bottom.equalTo(imageView3.mas_bottom);
        make.right.equalTo(configButton.mas_right);
        make.top.equalTo(imageView3.mas_top);
    }];
    phoneText.placeholder = @"手机号码";
    [phoneText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];

    
    UIView *bottomLine4 = [[UIView alloc] init];
    [bottomLine4 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:bottomLine4];
    [bottomLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(configButton);
        make.bottom.equalTo(phoneText.mas_top).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    UIImage *image4 = [UIImage imageNamed:@"Icon_01"];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:image4];
    [self.view addSubview:imageView4];
    [imageView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(configButton.mas_left).offset(15);
        make.bottom.equalTo(bottomLine4.mas_top).offset(-7);
        make.height.mas_equalTo(image4.size.height);
        make.width.mas_equalTo(image4.size.width);
    }];
//    UILabel *label4 = [UILabel new];
//    label4.text = @"真实姓名：";
//    [label4 setTextColor:[UIColor lightGrayColor]];
//    [self.view addSubview:label4];
//    [label4 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
//    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(imageView4);
//        make.left.equalTo(label2.mas_left);
//        make.width.mas_equalTo(@70);
//    }];
    nameText = [UITextField new];
    [self.view addSubview:nameText];
    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numberText.mas_left);
        make.bottom.equalTo(imageView4.mas_bottom);
        make.right.equalTo(configButton.mas_right);
        make.top.equalTo(imageView4.mas_top);
    }];
    nameText.placeholder = @"真实姓名";
    
    UITableView *mainTable= [[UITableView alloc] init];
    [self.view addSubview:mainTable];
    [mainTable setDelegate:self];
    [mainTable setDataSource:self];
    [mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.bottom.equalTo(nameText.mas_top).offset(-7);
    }];
    [mainTable setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    mainTable.rowHeight = 101.0;
    [mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [numberText setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneText setKeyboardType:UIKeyboardTypeNumberPad];
    [configButton addTarget:self action:@selector(SettleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ssc";
    SettleShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettleShoppingCell" owner:nil options:nil] firstObject];
        NSString *tempStr=[PHQDRequestUrl stringByAppendingString:((SetModel *)[dataArray objectAtIndex:indexPath.row]).pic];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
        cell.nameLabel.text =((SetModel *)[dataArray objectAtIndex:indexPath.row]).name;
        NSString *temp1 = @"适用对象:";
        cell.peopleLabel.text = [temp1 stringByAppendingString:((SetModel *)[dataArray objectAtIndex:indexPath.row]).age_type];
        cell.priceLabel.text = [NSString stringWithFormat:@"金额：¥%d",((SetModel *)[dataArray objectAtIndex:indexPath.row]).retail];
        NSString *temp = [NSString stringWithFormat:@"%d",((SetModel *)[dataArray objectAtIndex:indexPath.row]).cost*((SetModel *)[dataArray objectAtIndex:indexPath.row]).buy_count];
        cell.costLabel.text = [@"¥" stringByAppendingString:temp];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = ((SetModel *)[self.dataArray objectAtIndex:indexPath.row]).name;
    self.navigationItem.backBarButtonItem = backItem;
    detailViewController *dv = [[detailViewController alloc] initWithData:[self.dataArray objectAtIndex:indexPath.row]];
    dv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dv animated:YES];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

-(void)getData:(NSMutableArray *)mutableArray andCostMoney:(int)money
{
    costMoney = money;
    dataArray = [[NSArray alloc] initWithArray:mutableArray];
    cost.text = [NSString stringWithFormat:@"¥%d",costMoney];
}

-(void)SettleButtonClicked
{
    if ([nameText.text isEqualToString:@""]||[phoneText.text isEqualToString:@""]||[numberText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请输入完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    if (phoneText.text.length != 11) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请输入正确的手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    
    NSString * regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";                  //身份证正则表达式
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:numberText.text];
    if (isMatch) {
        if (numberText.text.length == 18) {
            int idCardWi[17] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
            int idCardY[11] = {1,0,10,9,8,7,6,5,4,3,2};
            int idCardWiSum = 0;
            for (int i = 0; i < 17; i++) {
                idCardWiSum += ([numberText.text characterAtIndex:i]-48)*idCardWi[i];
            }
            int idCardMod = idCardWiSum%11;
            int idCardLast = [numberText.text characterAtIndex:17]-48;
            if (idCardMod == 2) {
                if (idCardLast == ('X'-48)||idCardLast == ('x'-48)) {
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"身份证错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    alert.tag = 1;
                    [alert show];
                    return;
                }
            } else {
                if (idCardLast == idCardY[idCardMod]) {
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"身份证错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    alert.tag = 1;
                    [alert show];
                    return;
                }
            }
        }
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"身份证格式错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    
    int orderCountInt = 0;
    int totalAmountInt = 0;
    int discountAmount = 0;
    for (SetModel *sm in dataArray) {
        orderCountInt += sm.buy_count;
        totalAmountInt += (sm.buy_count*sm.retail);
        discountAmount += (sm.buy_count*sm.cost);
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    NSMutableArray *temparray = [NSMutableArray array];
    for (int i = 0;i<dataArray.count;i++) {
        NSDictionary *tempdic = @{@"serv_info":((SetModel *)[dataArray objectAtIndex:i]).serv_info,@"pack_info":((SetModel *)[dataArray objectAtIndex:i]).pack_info,@"info_pic":((SetModel *)[dataArray objectAtIndex:i]).info_pic,@"buy_count":[NSString stringWithFormat:@"%d",((SetModel *)[dataArray objectAtIndex:i]).buy_count],@"age_type":((SetModel *)[dataArray objectAtIndex:i]).age_type,@"package_id":((SetModel *)[dataArray objectAtIndex:i]).package_id,@"name":((SetModel *)[dataArray objectAtIndex:i]).name,@"gender":[NSString stringWithFormat:@"%d",((SetModel *)[dataArray objectAtIndex:i]).gender],@"pic":((SetModel *)[dataArray objectAtIndex:i]).pic,@"cost":[NSString stringWithFormat:@"%d",((SetModel *)[dataArray objectAtIndex:i]).cost],@"retail":[ NSString stringWithFormat:@"%d",((SetModel *)[dataArray objectAtIndex:i]).retail]};
        [temparray addObject:tempdic];
    }
    
    NSMutableArray *cartAry = [NSMutableArray array];
    for (int i = 0;i< dataArray.count;i++) {
        NSDictionary *tempdic = @{@"package_id":((SetModel *)[dataArray objectAtIndex:i]).package_id,@"name":((SetModel *)[dataArray objectAtIndex:i]).name};
            [cartAry addObject:tempdic];
    }
    if(userId==nil||[userId isEqualToString:@""]){
        [self showAllTextDialog:@"请前往个人中心登陆！"];
        return;
    }
    WaitPayController *waitPayCon=[[WaitPayController alloc]init];
    waitPayCon.name=nameText.text;
    waitPayCon.phone=phoneText.text;
    waitPayCon.idCard=numberText.text;
    waitPayCon.ordersCount=[NSString stringWithFormat:@"%d",orderCountInt];
    waitPayCon.totalAmount=[NSString stringWithFormat:@"%d",totalAmountInt];
    waitPayCon.discountAmount=[NSString stringWithFormat:@"%d",discountAmount];
    waitPayCon.datas=temparray;
    waitPayCon.cartDatas=cartAry;
    waitPayCon.isCarts=self.isCarts;
    [self.navigationController pushViewController:waitPayCon animated:YES];
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
    for (int i=0; i<self.dataArray.count; i++) {
        SetModel *info=self.dataArray[i];
        names=[NSString stringWithFormat:@"%@%@|",names,info.name];
        NSLog(@"###%@",names);
        
        
        
        NSLog(@"cost^^^%d",info.cost);
        NSLog(@"buy_count^^^%d",info.buy_count);
        money=info.cost*info.buy_count;
        
        totalMoney=totalMoney+money;
        NSLog(@"###%d,%d",money,totalMoney);
        
    }

    
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
    order.tradeNO = self.orderId; //订单ID（由商家自行制定）
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
 *  注册信息接口
 *
 *  注册成功账号信息：手机号:18706898856,密码:zbb1234,用户名:zbb
 */
- (void)setPayInfo
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userPwdz=[user objectForKey:@"userPwdz"];
    NSString *userAccountz=[user objectForKey:@"userAccountz"];
    NSString *userIdz=[user objectForKey:@"userIdz"];
    NSString *userNamez=[user objectForKey:@"userNamez"];

    
    [RequestServer fetchMethodName:@"paymentOrders" parameters:@{@"userId":userIdz,@"userAccount":userAccountz,@"userName":userNamez,@"userPwd":userPwdz,@"orderId":self.orderId} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
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
