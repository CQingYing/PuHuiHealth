//
//  HealthStoreController.m
//  PuHui
//
//  Created by rp.wang on 15/7/2.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "HealthStoreController.h"
#import "HealthStoreCell.h"
#import "detailViewController.h"

@interface HealthStoreController ()

@property(strong, nonatomic) NSMutableArray *sm;
@property(assign, nonatomic) float hight;
@property(strong, nonatomic) UITableView *mainTable;
@property(strong, nonatomic) NSMutableArray *tempMuta;
@property(assign,nonatomic) int temp;
@property(strong, nonatomic) NSMutableArray *arrysMuta;
@property(strong, nonatomic) UIView *myview;


@end

@implementation HealthStoreController
@synthesize header,headhigh;
//懒加载
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
    
    UIImage *test = [UIImage imageNamed:@"ph_01"];
    self.hight = test.size.height;

    header = [[HealthStoreHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [header setDelegate:self];
    headhigh = header.height;
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStyleGrouped];
    self.mainTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.mainTable];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(65);
    }];
    [self.mainTable setDelegate:self];
    [self.mainTable setDataSource:self];
    self.mainTable.rowHeight = 101.0;
    [self.mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.mainTable.canCancelContentTouches = YES;
    [self setMealInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return headhigh;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return header;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempMuta.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"sm";
    HealthStoreCell *cell = [self.mainTable dequeueReusableCellWithIdentifier:ID];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HealthStoreCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    SetModel *mealInfor=self.tempMuta[indexPath.row];
    cell.nameLabel.text=mealInfor.name;
    cell.costLabel.text= [NSString stringWithFormat:@"内部折扣价:¥%d", mealInfor.cost];
    cell.priceLabel.text=[NSString stringWithFormat:@"金额:¥%d",mealInfor.retail];
    NSString *temp = @"适用对象:";
    cell.peopleLabel.text = [temp stringByAppendingString:mealInfor.age_type];
    cell.sellLabel.text=[NSString stringWithFormat:@"%d人已经购买",mealInfor.buy_count];
    NSString *tempStr=[PHQDRequestUrl stringByAppendingString:mealInfor.pic];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
    return cell;
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

-(void)setMealInfo
{
    [RequestServer fetchMethodName:@"get_serv_price_by_orgId" parameters:@{@"serv_price.org_id":@"4"} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiQD successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"serv_price_list"];
        
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

-(void)ClickedChooseButtonWithTag:(long)tag
{
    if (tag == 1) {
        self.tempMuta=nil;
        for (SetModel * info in self.arrysMuta) {
            if((info.gender!=self.header.sexTag)&&([info.type isEqualToString:self.header.chooseLabel.text]||[@"全部套餐" isEqualToString:self.header.chooseLabel.text])){
                [self.tempMuta addObject:info];
            }
        }
        [self.mainTable reloadData];
    }else if(tag == 2) {
        self.tempMuta=nil;
        for (SetModel * info in self.arrysMuta) {
            if((info.gender!=self.header.sexTag)&&([info.type isEqualToString:self.header.chooseLabel.text]||[@"全部套餐" isEqualToString:self.header.chooseLabel.text])){
                [self.tempMuta addObject:info];
            }
        }
        [self.mainTable reloadData];
    }else if(tag == 3) {
        self.tempMuta=nil;
        for (SetModel * info in self.arrysMuta) {
            if(info.gender!=self.header.sexTag&&([info.type isEqualToString:self.header.chooseLabel.text]||[@"全部套餐" isEqualToString:self.header.chooseLabel.text])){
                [self.tempMuta addObject:info];
            }
        }
        [self.mainTable reloadData];
    }else if(tag == 4) {
        self.tempMuta=nil;
        for (SetModel * info in self.arrysMuta) {
            if(info.gender!=self.header.sexTag&&([info.type isEqualToString:self.header.chooseLabel.text]||[@"全部套餐" isEqualToString:self.header.chooseLabel.text])){
                [self.tempMuta addObject:info];
            }
        }
        [self.mainTable reloadData];
    }
}

-(void)ClickedManOrWomanWithTag:(long)tag
{
    if (tag == 1) {
        self.tempMuta=nil;
        for (SetModel * info in self.arrysMuta) {
            if(info.gender!=2&&([info.type isEqualToString:self.header.chooseLabel.text]||[@"全部套餐" isEqualToString:self.header.chooseLabel.text])){
                [self.tempMuta addObject:info];
            }
        }
        [self.mainTable reloadData];
    }else if(tag == 2) {
        self.tempMuta=nil;
        for (SetModel * info in self.arrysMuta) {
            if(info.gender!=1&&([info.type isEqualToString:self.header.chooseLabel.text]||[@"全部套餐" isEqualToString:self.header.chooseLabel.text])){
                [self.tempMuta addObject:info];
            }
        }
        [self.mainTable reloadData];
    }else if(tag == 3) {
        self.tempMuta=nil;
        for (SetModel * info in self.arrysMuta) {
            if ([info.type isEqualToString:self.header.chooseLabel.text]||[@"全部套餐" isEqualToString:self.header.chooseLabel.text]) {
                [self.tempMuta addObject:info];
            }
        }
        [self.mainTable reloadData];
    }
}

-(void)ClickedImageViewWithModel:(SetModel *)sm
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = sm.name;
    self.navigationItem.backBarButtonItem = backItem;
    detailViewController *dv = [[detailViewController alloc] initWithData:sm];
    dv.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dv animated:YES];
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
