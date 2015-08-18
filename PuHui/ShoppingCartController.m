//
//  ShoppingCartController.m
//  PuHui
//
//  Created by administrator on 15/7/9.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "ShoppingCartController.h"
#import "detailViewController.h"

@interface ShoppingCartController ()
//@property(strong, nonatomic) NSArray *scm;
@property(strong, nonatomic) UILabel *number;
@property(strong, nonatomic) UILabel *cost;
@property(assign, nonatomic) int totalcost;
@property(assign, nonatomic) int totalnumber;
@property(strong, nonatomic) NSMutableArray *arrysMuta;
@property(strong, nonatomic) NSMutableArray *tempMuta;
@property(strong, nonatomic) UITableView *mainTable;
@property(strong, nonatomic) UIButton *settle;
@property(strong, nonatomic) UIButton *delete;


@end

@implementation ShoppingCartController
@synthesize number,cost,mutableArray;

- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}

- (NSMutableArray *)tempMuta
{
    if (!_tempMuta) {
        _tempMuta=[[NSMutableArray alloc]init];
    }
    return _tempMuta;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mutableArray = [NSMutableArray arrayWithCapacity:5];
    self.navigationController.toolbarHidden = YES;
    [self.view setBackgroundColor:[UIColor colorWithRed:235 green:235 blue:241 alpha:1]];
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTable];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-30);
    }];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    self.mainTable.rowHeight = 101.0;
    [self.mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UITabBar *tabbar = [[UITabBar alloc] init];
    [self.view addSubview:tabbar];
    [tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    number = [UILabel new];
    [tabbar addSubview:number];
    [number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabbar.mas_top).offset(5);
        make.left.equalTo(tabbar.mas_left).offset(10);
        make.bottom.equalTo(tabbar.mas_bottom).offset(-5);
        make.width.equalTo(tabbar.mas_width).multipliedBy(0.18);
    }];
    number.text = @"共0件商品";
    [number setTextAlignment:NSTextAlignmentCenter];
    [number setFont:[UIFont fontWithName:@"Helvetica" size:10.0]];
    
    cost = [UILabel new];
    [tabbar addSubview:cost];
    [cost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabbar.mas_top).offset(5);
        make.left.equalTo(number.mas_right).offset(5);
        make.bottom.equalTo(tabbar.mas_bottom).offset(-5);
        make.width.equalTo(tabbar.mas_width).multipliedBy(0.3);
    }];
    cost.text = @"合计:¥0";
    [cost setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [cost setTextColor:[UIColor orangeColor]];
    
    self.settle = [[UIButton alloc] init];
    [tabbar addSubview:self.settle];
    [self.settle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabbar.mas_bottom).offset(-5);
        make.right.equalTo(tabbar.mas_right).offset(-5);
        make.top.equalTo(tabbar.mas_top).offset(5);
        make.width.equalTo(tabbar.mas_width).multipliedBy(0.2);
    }];
    [self.settle setBackgroundColor:[UIColor redColor]];
    UILabel *settleLabel = [[UILabel alloc] init];
    [settleLabel setTextAlignment:NSTextAlignmentCenter];
    settleLabel.text = @"结算";
    [settleLabel setTextColor:[UIColor whiteColor]];
    [self.settle addSubview:settleLabel];
    [settleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.settle);
    }];
    self.settle.layer.cornerRadius = 5;
    self.settle.layer.masksToBounds = YES;
    
    self.delete = [[UIButton alloc] init];
    [tabbar addSubview:self.delete];
    [self.delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tabbar.mas_bottom).offset(-5);
        make.right.equalTo(self.settle.mas_left).offset(-5);
        make.top.equalTo(tabbar.mas_top).offset(5);
        make.width.equalTo(tabbar.mas_width).multipliedBy(0.2);
    }];
    [self.delete setBackgroundColor:[UIColor orangeColor]];
    UILabel *deleteLabel = [[UILabel alloc] init];
    [deleteLabel setTextAlignment:NSTextAlignmentCenter];
    deleteLabel.text = @"删除";
    [deleteLabel setTextColor:[UIColor whiteColor]];
    [self.delete addSubview:deleteLabel];
    [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.delete);
    }];
    self.delete.layer.cornerRadius = 5;
    self.delete.layer.masksToBounds = YES;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"确认填写订单";
    self.navigationItem.backBarButtonItem = backItem;

    [self.settle addTarget:self action:@selector(SettleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.delete addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = ((SetModel *)[self.tempMuta objectAtIndex:indexPath.row]).name;
    self.navigationItem.backBarButtonItem = backItem;
    detailViewController *dv = [[detailViewController alloc] initWithData:[self.tempMuta objectAtIndex:indexPath.row]];
    dv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dv animated:YES];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempMuta.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"sm";
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartCell" owner:nil options:nil] firstObject];
        [cell setDelegate:self];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    SetModel *mealInfor=self.tempMuta[indexPath.row];
    cell.nameLabel.text=mealInfor.name;
    cell.costLabel.text= [NSString stringWithFormat:@"¥%d",mealInfor.cost*mealInfor.buy_count];
    cell.priceLabel.text=[NSString stringWithFormat:@"金额:¥%d",mealInfor.retail];
    NSString *temp = @"适用对象:";
    cell.peopleLabel.text = [temp stringByAppendingString:mealInfor.age_type];
    cell.numberLabel.text=[NSString stringWithFormat:@"%d",mealInfor.buy_count];
    if (mealInfor.buy_count<=1) {
        cell.leftButton.hidden = YES;
    }
    NSString *tempStr=[PHQDRequestUrl stringByAppendingString:mealInfor.pic];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
    cell.model = mealInfor;
    return cell;
}

-(void)selecteClicked:(id)sender WithModel:(SetModel *)_model
{
    UIButton *b1 = (UIButton *)sender;
    if (b1.selected == YES) {
        self.totalnumber += _model.buy_count;
        self.number.text = [NSString stringWithFormat:@"共%d件商品",self.totalnumber];
        self.totalcost += _model.cost*_model.buy_count;
        self.cost.text = [NSString stringWithFormat:@"合计:¥%d",self.totalcost];
        [mutableArray addObject:_model];
        [self.settle setEnabled:YES];
        [self.settle setAlpha:1];
        [self.delete setEnabled:YES];
        [self.delete setAlpha:1];
    }
    else
    {
        self.totalnumber -= _model.buy_count;
        self.number.text = [NSString stringWithFormat:@"共%d件商品",self.totalnumber];
        self.totalcost -= _model.cost*_model.buy_count;
        self.cost.text = [NSString stringWithFormat:@"合计:¥%d",self.totalcost];
        for (int i = 0;i < mutableArray.count;i++) {
            SetModel *tempSet = [mutableArray objectAtIndex:i];
            if ([tempSet.name isEqualToString:_model.name]) {
                [mutableArray removeObjectAtIndex:i];
            }
        }
        if (mutableArray.count == 0) {
            [self.settle setEnabled:NO];
            [self.settle setAlpha:0.4];
            [self.delete setEnabled:NO];
            [self.delete setAlpha:0.4];
        }
    }
}

-(void)rightPlus:(id)sender Percost:(int)percost Name:(NSString *)name Number:(int)Mynumber
{
    UIButton *b1 = (UIButton *)sender;
    if (b1.selected) {
        self.totalnumber ++;
        self.number.text = [NSString stringWithFormat:@"共%d件商品",self.totalnumber];
        self.totalcost += percost;
        self.cost.text = [NSString stringWithFormat:@"合计:¥%d",self.totalcost];
    }
}

-(void)leftReduction:(id)sender Percost:(int)percost Name:(NSString *)name Number:(int)Mynumber
{
    UIButton *b1 = (UIButton *)sender;
    if (b1.selected) {
        self.totalnumber --;
        self.number.text = [NSString stringWithFormat:@"共%d件商品",self.totalnumber];
        self.totalcost -= percost;
        self.cost.text = [NSString stringWithFormat:@"合计:¥%d",self.totalcost];
    }
}

-(void)SettleButtonClicked
{
    
    
    SettleShoppingController *ssc = [[SettleShoppingController alloc] initwithArray:mutableArray];
    ssc.isCarts=1;
    [self.navigationController pushViewController:ssc animated:YES];
}

-(void)getShoppingCart
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"myCart" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            SetModel *meals=[SetModel objectWithKeyValues:dict];
            [self.arrysMuta  addObject:meals];
        }
        for (SetModel * info in self.arrysMuta)
        {
            [self.tempMuta addObject:info];
        }
        [self.mainTable reloadData];
        
    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}

-(void)deleteButtonClicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"是否确认删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSMutableArray *mua = [NSMutableArray array];
    for (SetModel *tempmodel in self.tempMuta) {
        NSDictionary *temp = @{@"package_id":tempmodel.package_id,@"name":tempmodel.name,@"buy_count":[NSString stringWithFormat:@"%d",tempmodel.buy_count]};
        [mua addObject:temp];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"modifyCart" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"data":mua} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {

    } failureHandler:^(NSString *errorInfo) {
        
        NSLog(@"error :%@",errorInfo);
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.totalcost = 0;
    self.totalnumber = 0;
    [self.settle setEnabled:NO];
    [self.settle setAlpha:0.4];
    [self.delete setEnabled:NO];
    [self.delete setAlpha:0.4];
    self.number.text = @"共0件商品";
    self.cost.text = @"合计:¥0";
    [self.tempMuta removeAllObjects];
    [self.arrysMuta removeAllObjects];
    [mutableArray removeAllObjects];
    [self getShoppingCart];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSMutableArray *mua = [NSMutableArray array];
        for (SetModel *tempmodel in mutableArray) {
            NSDictionary *temp = @{@"package_id":tempmodel.package_id,@"name":tempmodel.name};
            [mua addObject:temp];
            [self.tempMuta removeObject:tempmodel];
        }
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *userId= [user objectForKey:@"userIdz"];
        NSString *userAccount = [user objectForKey:@"userAccountz"];
        NSString *userPwd = [user objectForKey:@"userPwdz"];
        [RequestServer fetchMethodName:@"deleteCart" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"data":mua} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
            self.number.text = @"共0件商品";
            self.totalcost = 0;
            self.totalnumber = 0;
            self.cost.text = @"合计:¥0";
            [self.mainTable reloadData];
            [mutableArray removeAllObjects];
            [self.settle setEnabled:NO];
            [self.settle setAlpha:0.4];
            [self.delete setEnabled:NO];
            [self.delete setAlpha:0.4];
        } failureHandler:^(NSString *errorInfo) {
            
            NSLog(@"error :%@",errorInfo);
            
        }];
    }
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
