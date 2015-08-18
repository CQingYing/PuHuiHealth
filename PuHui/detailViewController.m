//
//  detailViewController.m
//  PuHui
//
//  Created by administrator on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "detailViewController.h"
#import "AppDelegate.h"
#import "WaitPayController.h"
#import "HKTableViewController.h"
#import "PersonalCenterLoginController.h"

@interface detailViewController ()
@property(strong, nonatomic) SetModel *_model;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic) UIImageView *footImage1;
@property (copy, nonatomic) NSString *key;
@property (strong, nonatomic) UIButton *footButton1;
@end

@implementation detailViewController

-(id)initWithData:(SetModel *)model
{
    self = [super init];
    if (self) {
        self._model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    UIScrollView *detailView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:detailView];
    detailView.showsVerticalScrollIndicator = NO;
    UIView *container = [[UIView alloc] init];
    [detailView addSubview:container];
    [container setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    NSString *tempStr=[PHQDRequestUrl stringByAppendingString:self._model.info_pic];
    UIImageView *iv = [[UIImageView alloc] init];
    [iv sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
    [iv setContentMode:UIViewContentModeScaleAspectFit];
    [container addSubview:iv];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(detailView.mas_centerX);
        make.top.equalTo(container.mas_top).offset(10);
        make.width.equalTo(container.mas_width).multipliedBy(0.8);
        make.height.mas_equalTo(iv.mas_width).multipliedBy(0.5);
    }];
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"适用对象:";
    [container addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container.mas_left).offset(30);
        make.top.equalTo(iv.mas_bottom).offset(10);
    }];
    UITextField *object = [[UITextField alloc] init];     //适用对象文本
    [object setEnabled:NO];
    object.text = self._model.age_type;
    [object setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [container addSubview:object];
    [object mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.left.equalTo(label1.mas_left).offset(14);
    }];
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"套餐介绍:";
    [container addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container.mas_left).offset(30);
        make.top.equalTo(object.mas_bottom).offset(10);
    }];
    UILabel *introduction = [[UILabel alloc] init];   //套餐介绍
    introduction.text = self._model.serv_info;
    [container addSubview:introduction];
    introduction.numberOfLines = 0;
    [introduction setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [introduction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(5);
        make.left.equalTo(label2.mas_left).offset(14);
        make.right.equalTo(container.mas_right).offset(-30);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"套餐项目:";
    [container addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container.mas_left).offset(30);
        make.top.equalTo(introduction.mas_bottom).offset(10);
    }];
    
    UILabel *detail = [[UILabel alloc] init];
    detail.text = self._model.pack_info;
    [container addSubview:detail];
    detail.numberOfLines = 0;
    [detail setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom);
        make.left.equalTo(label3.mas_left).offset(14);
        make.right.equalTo(container.mas_right).offset(-30);
    }];
    
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [self.view addSubview:toolBar];
    
    self.footButton1 = [[UIButton alloc] init];
    [toolBar addSubview:self.footButton1];
    UILabel *footLabel1 = [[UILabel alloc] init];
    [self.footButton1 addSubview:footLabel1];
    footLabel1.text = @"收藏";
    [footLabel1 setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [footLabel1 setTextColor:[UIColor orangeColor]];
    [footLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.footButton1.mas_left);
        make.bottom.equalTo(self.footButton1.mas_bottom);
    }];
    self.footImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_011"]];
    [self.footButton1 addSubview:self.footImage1];
    [self.footImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footLabel1.mas_top);
        make.centerX.equalTo(footLabel1.mas_centerX);
    }];
    [self.footButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(footLabel1.mas_width);
        make.top.equalTo(self.footImage1.mas_top);
        make.bottom.equalTo(toolBar.mas_bottom).offset(-5);
        make.left.equalTo(toolBar.mas_left).offset(50);
    }];
    
    
    UIButton *footButton2 = [[UIButton alloc] init];
    [toolBar addSubview:footButton2];
    UILabel *footLabel2 = [[UILabel alloc] init];
    [footButton2 addSubview:footLabel2];
    footLabel2.text = @"加入购物车";
    [footLabel2 setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [footLabel2 setTextColor:[UIColor orangeColor]];
    [footLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footButton2.mas_left);
        make.bottom.equalTo(footButton2.mas_bottom);
    }];
    UIImageView *footImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopping-cart-2"]];
    [footButton2 addSubview:footImage2];
    [footImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footLabel2.mas_top);
        make.centerX.equalTo(footLabel2.mas_centerX);
    }];
    [footButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(footLabel2.mas_width);
        make.top.equalTo(footImage2.mas_top);
        make.bottom.equalTo(toolBar.mas_bottom).offset(-5);
        make.centerX.equalTo(toolBar.mas_centerX);
    }];
    
    UIButton *footButton3 = [[UIButton alloc] init];
    [toolBar addSubview:footButton3];
    UILabel *footLabel3 = [[UILabel alloc] init];
    [footButton3 addSubview:footLabel3];
    footLabel3.text = @"购买";
    [footLabel3 setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [footLabel3 setTextColor:[UIColor orangeColor]];
    [footLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footButton3.mas_left);
        make.bottom.equalTo(footButton3.mas_bottom);
    }];
    UIImageView *footImage3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ph3"]];
    [footButton3 addSubview:footImage3];
    [footImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footLabel3.mas_top);
        make.centerX.equalTo(footLabel3.mas_centerX);
    }];
    [footButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(footLabel3.mas_width);
        make.top.equalTo(footImage3.mas_top);
        make.bottom.equalTo(toolBar.mas_bottom).offset(-5);
        make.right.equalTo(toolBar.mas_right).offset(-50);
    }];
    
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.footButton1.mas_top).offset(-5);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(detailView);
        make.width.equalTo(detailView);
        make.bottom.equalTo(detail.mas_bottom).offset(100);
    }];

    UIImage *cartImage = [UIImage imageNamed:@"shopping-cart-2"];
    UIButton *CartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [CartButton setFrame:CGRectMake(0, 0, cartImage.size.width, cartImage.size.height)];
    [CartButton setImage:cartImage forState:UIControlStateNormal];
    [CartButton addTarget:self action:@selector(clickShoppingCartButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shoppingCart = [[UIBarButtonItem alloc] initWithCustomView:CartButton];
    self.navigationItem.rightBarButtonItem = shoppingCart;
    
    [self.footButton1 addTarget:self action:@selector(clickFavoriteButton) forControlEvents:UIControlEventTouchUpInside];
    [footButton2 addTarget:self action:@selector(clickeAddButton) forControlEvents:UIControlEventTouchUpInside];
    [footButton3 addTarget:self action:@selector(clickBuyButton) forControlEvents:UIControlEventTouchUpInside];
    [self.footButton1 setShowsTouchWhenHighlighted:YES];
    [footButton2 setShowsTouchWhenHighlighted:YES];
    [footButton3 setShowsTouchWhenHighlighted:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    if (userAccount == nil) {
        [self.footImage1 setImage:[UIImage imageNamed:@"collection-1"]];
    } else {
        [RequestServer fetchMethodName:@"favoritesStatus" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"package_id":self._model.package_id,@"name":self._model.name} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
                self.key = responseDic[@"favStatus"];
                if ([self.key isEqualToString:@"0"]) {
                    [self.footImage1 setImage:[UIImage imageNamed:@"icon_011"]];
                    self.footButton1.selected = NO;
                } else {
                    self.footButton1.selected = YES;
                    [self.footImage1 setImage:[UIImage imageNamed:@"icon"]];
                }
            }
        } failureHandler:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickBuyButton                            //点击购买按钮
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    if (userIdz==nil||[userIdz isEqualToString:@""]) {
        UIStoryboard  *LoginSB=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
        PersonalCenterLoginController *loginController=[LoginSB instantiateViewControllerWithIdentifier:@"PersonalCenterLoginController"];
        //        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        //        backItem.title = @"返回";
        //        loginController.navigationItem.rightBarButtonItem = backItem;
        loginController.flag = @"0";
        [self.navigationController pushViewController:loginController animated:NO];
        return;
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"确认填写订单";
    self.navigationItem.backBarButtonItem = backItem;
    self._model.buy_count = 1;
    NSArray *array = [NSArray arrayWithObjects:self._model, nil];
    SettleShoppingController *scc = [[SettleShoppingController alloc] initwithArray:array];
    scc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:scc animated:YES];
}

-(void)clickFavoriteButton                      //点击收藏按钮
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    if (userIdz==nil||[userIdz isEqualToString:@""]) {
        UIStoryboard  *LoginSB=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
        PersonalCenterLoginController *loginController=[LoginSB instantiateViewControllerWithIdentifier:@"PersonalCenterLoginController"];
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//        backItem.title = @"返回";
//        loginController.navigationItem.rightBarButtonItem = backItem;
        loginController.flag = @"0";
        [self.navigationController pushViewController:loginController animated:NO];
        return;
    }
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    if (self.footButton1.selected == NO) {
        [RequestServer fetchMethodName:@"addToFavorites" parameters:@{@"userId":userIdz,@"userAccount":userAccount,@"userPwd":userPwd,@"serv_info":self._model.serv_info,@"pack_info":self._model.pack_info,@"info_pic":self._model.info_pic,@"age_type":self._model.age_type,@"package_id":self._model.package_id,@"name":self._model.name,@"gender":[NSString stringWithFormat:@"%d",self._model.gender],@"pic":self._model.pic,@"cost":[NSString stringWithFormat:@"%d",self._model.cost],@"retail":[NSString stringWithFormat:@"%d",self._model.retail]} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            NSString *str = [responseDic objectForKey:@"retMsg"];
            [self showAllTextDialog:str];
            self.footButton1.selected = YES;
            [self.footImage1 setImage:[UIImage imageNamed:@"icon"]];
        } failureHandler:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
            [self showAllTextDialog:@"传输数据失败"];
        }];
    } else {
        [RequestServer fetchMethodName:@"cancelFavorites" parameters:@{@"userId":userIdz,@"userAccount":userAccount,@"userPwd":userPwd,@"package_id":self._model.package_id,@"name":self._model.name} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
                NSString *str = [responseDic objectForKey:@"retMsg"];
                [self showAllTextDialog:str];
                [self.footImage1 setImage:[UIImage imageNamed:@"icon_011"]];
                self.footButton1.selected = NO;
            }
        } failureHandler:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
        }];
    }
}

-(void)clickeAddButton                          //点击加入购物车按钮
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    if (userIdz==nil||[userIdz isEqualToString:@""]) {
        UIStoryboard  *LoginSB=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
        PersonalCenterLoginController *loginController=[LoginSB instantiateViewControllerWithIdentifier:@"PersonalCenterLoginController"];
        //        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        //        backItem.title = @"返回";
        //        loginController.navigationItem.rightBarButtonItem = backItem;
        loginController.flag = @"0";
        [self.navigationController pushViewController:loginController animated:NO];
        return;
    }
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"addToCart" parameters:@{@"userId":userIdz,@"userAccount":userAccount,@"userPwd":userPwd,@"serv_info":self._model.serv_info,@"pack_info":self._model.pack_info,@"info_pic":self._model.info_pic,@"age_type":self._model.age_type,@"package_id":self._model.package_id,@"name":self._model.name,@"gender":[NSString stringWithFormat:@"%d",self._model.gender],@"pic":self._model.pic,@"cost":[NSString stringWithFormat:@"%d",self._model.cost],@"retail":[NSString stringWithFormat:@"%d",self._model.retail]} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        NSString *str = [responseDic objectForKey:@"retMsg"];
        [self showAllTextDialog:str];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
        [self showAllTextDialog:@"传输数据失败"];
    }];
}

-(void)clickShoppingCartButton                  //点击购物车按钮
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"购物车";
    self.navigationItem.backBarButtonItem = backItem;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userIdz= [user objectForKey:@"userIdz"];
    if (userIdz==nil||[userIdz isEqualToString:@""]) {
        UIStoryboard  *LoginSB=[UIStoryboard storyboardWithName:@"Login" bundle:nil];
        PersonalCenterLoginController *loginController=[LoginSB instantiateViewControllerWithIdentifier:@"PersonalCenterLoginController"];
        //        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        //        backItem.title = @"返回";
        //        loginController.navigationItem.rightBarButtonItem = backItem;
        loginController.flag = @"0";
        [self.navigationController pushViewController:loginController animated:NO];
        return;
    }
    ShoppingCartController *scc = [[ShoppingCartController alloc] init];
    [self.navigationController pushViewController:scc animated:YES];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
