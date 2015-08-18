//
//  FavoriteViewController.m
//  PuHui
//
//  Created by administrator on 15/7/29.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "FavoriteViewController.h"
#import "RequestServer.h"
#import "Masonry.h"
#import "SetModel.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "FavoriteTableCell.h"
#import "detailViewController.h"


@interface FavoriteViewController ()
@property (strong, nonatomic) UITableView *mainTable;
@property(strong, nonatomic) NSMutableArray *tempMuta;
@property(strong, nonatomic) NSMutableArray *arrysMuta;

@end

@implementation FavoriteViewController
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
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.mainTable = [[UITableView alloc] init];
    [self.mainTable setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view addSubview:self.mainTable];
    [self.mainTable setDataSource:self];
    [self.mainTable setDelegate:self];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.mainTable.rowHeight = 101;
    [self.mainTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self getInfo];
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
    static NSString *identifier = @"ftc";
    FavoriteTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FavoriteTableCell" owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    SetModel *mealInfor=self.tempMuta[indexPath.row];
    cell.nameLabel.text = mealInfor.name;
    cell.costLabel.text = [NSString stringWithFormat:@"内部折扣价：¥%d",mealInfor.cost];
    cell.priceLabel.text = [NSString stringWithFormat:@"金额:¥%d",mealInfor.retail];
    NSString *temp = @"适用对象:";
    cell.peopleLabel.text = [temp stringByAppendingString:mealInfor.age_type];
    NSString *tempStr=[PHQDRequestUrl stringByAppendingString:mealInfor.pic];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
    [cell.editingAccessoryView setBackgroundColor:[UIColor blueColor]];
    return cell;
}

- (void)getInfo {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"myFavorites" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if ([tableView isEqual:self.mainTable]) {
        result = UITableViewCellEditingStyleDelete;
    }
    return result;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.mainTable setEditing:editing animated:animated];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row<[self.tempMuta count]) {
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSString *userId= [user objectForKey:@"userIdz"];
            NSString *userAccount = [user objectForKey:@"userAccountz"];
            NSString *userPwd = [user objectForKey:@"userPwdz"];
            [RequestServer fetchMethodName:@"cancelFavorites" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"package_id":((SetModel *)[self.tempMuta objectAtIndex:indexPath.row]).package_id,@"name":((SetModel *)[self.tempMuta objectAtIndex:indexPath.row]).name} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
                
            } failureHandler:^(NSString *errorInfo) {
                
                NSLog(@"error :%@",errorInfo);
                
            }];
            [self.tempMuta removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
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
