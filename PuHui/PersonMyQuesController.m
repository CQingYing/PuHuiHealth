//
//  PersonMyQuesController.m
//  PuHui
//
//  Created by rp.wang on 15/7/30.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonMyQuesController.h"
#import "AlreadyQuestionController.h"
#import "AlreadyAcceptController.h"
#import "QuestionsController.h"
#import "AlreadyQuestionCell.h"
#import "AlreadyAcceptCell.h"
#import "QuestionDetailController.h"
#import "MJRefresh.h"
#import "RequestServer.h"
#import "MJExtension.h"
#import "QuestionModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"


@interface PersonMyQuesController ()
@property (strong, nonatomic) UISegmentedControl *queSeg;
@property (strong, nonatomic)  AlreadyQuestionController * quesController;
@property (strong, nonatomic)  AlreadyAcceptController *acceptController;
@property (strong, nonatomic)  UIView *askView;
@property (strong, nonatomic)  UIView *acceiptView;
@property (strong, nonatomic)  UIView *doneView;
@property (strong, nonatomic)  UITableView *askTabView;
@property (strong, nonatomic)  UITableView *acceiptTabView;
@property (strong, nonatomic)  UITableView *doneTabView;
@property (strong, nonatomic)  NSMutableArray *askData;
@property (strong, nonatomic)  NSMutableArray *acceptData;
@property (strong, nonatomic)  NSMutableArray *doneData;
@property (assign, nonatomic) int askCurrentPage;
@property (assign, nonatomic) int accCurrentPage;
@property (assign, nonatomic) int doneCurrentPage;
@property (strong, nonatomic)  UIButton *leftBtn;
@end

@implementation PersonMyQuesController

- (NSMutableArray *)askData
{
    if (!_askData) {
        _askData=[[NSMutableArray alloc]init];
    }
    return _askData;
}

- (NSMutableArray *)acceptData
{
    if (!_acceptData) {
        _acceptData=[[NSMutableArray alloc]init];
    }
    return _acceptData;
}

- (NSMutableArray *)doneData
{
    if (!_doneData) {
        _doneData = [[NSMutableArray alloc] init];
    }
    return _doneData;
}

- (AlreadyQuestionController *)quesController
{
    if (!_quesController) {
        _quesController = [[AlreadyQuestionController alloc] init];
        _quesController.view.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40) ;
    }
    return _quesController;
}
- (AlreadyAcceptController *)acceptController
{
    if (!_acceptController) {
        _acceptController = [[AlreadyAcceptController alloc] init];
        _acceptController.view.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-40) ;
    }
    return _acceptController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(tagHome) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.queSeg = [[UISegmentedControl alloc] initWithItems:@[@"已提问",@"已受理",@"已完成"]];
    self.queSeg.selectedSegmentIndex=0;
    [self.queSeg setTintColor:[UIColor grayColor]];
    //queSeg的切换
    [self.queSeg addTarget:self action:@selector(tapSeg) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.queSeg];
    [self.queSeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(70);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.height.mas_equalTo(@28);
    }];
    //设置rightBarButtonItem
    UIButton *qstBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [qstBtn setTitle:@"提问" forState:UIControlStateNormal];
    [qstBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [qstBtn addTarget:self action:@selector(qstTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:qstBtn];
    //设置两个tableView的属性 44
    self.askView=[[UIView alloc]init];
    self.acceiptTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-103)];
    self.askTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-103)];
    self.acceiptView=[[UIView alloc]init];
    self.doneView=[[UIView alloc]init];
    self.doneTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-103)];
    self.acceiptTabView.dataSource=self;
    self.acceiptTabView.delegate=self;
    self.askTabView.dataSource=self;
    self.askTabView.delegate=self;
    self.askTabView.rowHeight=88;
    self.doneTabView.dataSource=self;
    self.doneTabView.delegate=self;
    self.doneTabView.rowHeight=88;
    self.acceiptTabView.rowHeight=88;
    [self.askView addSubview:self.askTabView];
    //添加view到根view上
    [self.view addSubview:self.askView];
    [self.askView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.queSeg.mas_bottom).offset(5);
    }];
}
-(void)tagHome
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"AAA",@"MIMA", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"unreadLogin" object:self userInfo:dic];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupRefresh:self.askTabView];
    [self setupRefresh:self.acceiptTabView];
    [self setupRefresh:self.doneTabView];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==self.askTabView){
        return 1;
    }else{
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==self.askTabView){
        return self.askData.count;
    }else if(tableView==self.acceiptTabView){
        return self.acceptData.count;
    } else {
        return self.doneData.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.askTabView)
    {
        static NSString *ID=@"Cell";
        AlreadyQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"AlreadyQuestionCell" owner:nil options:nil]lastObject];
        }
        cell.nainTiltle.text = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).content;
        cell.dateLabel.text = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).create_date;
        NSString *tempStr=[PHJKRequestUrl stringByAppendingString:((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).pic];
        [cell.photoIcon sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
        return cell;
    }else if(tableView==self.acceiptTabView)
    {
        static NSString *ID=@"CellAccept";
        AlreadyAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"AlreadyAcceptCell" owner:nil options:nil]lastObject];
        }
        if ([((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).unread isEqualToString:@"0"]) {
            cell.unread.hidden = NO;
        } else {
            cell.unread.hidden = YES;
        }
        cell.personName.text = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).expert;
        cell.timer.text = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).accept_date;
        cell.detail.text = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).content;
        NSString *tempStr=[PHJKRequestUrl stringByAppendingString:((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).pic];
        [cell.accepticoniI sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
        return cell;
    } else {
        static NSString *ID=@"Cell";
        AlreadyQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"AlreadyQuestionCell" owner:nil options:nil]lastObject];
        }
        cell.nainTiltle.text = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).content;
        cell.dateLabel.text = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).create_date;
        NSString *tempStr=[PHJKRequestUrl stringByAppendingString:((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).pic];
        [cell.photoIcon sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    NSString *userName = [user objectForKey:@"userNamez"];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    QuestionDetailController *questionDetailController = [[QuestionDetailController alloc] init];
    questionDetailController.questionDetailData = [[QuestionDetailModel alloc] init];
    questionDetailController.questionDetailData.asker = userName;
    if(tableView==self.askTabView)
    {
        questionDetailController.age = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).age;
        questionDetailController.gender = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).gender;
        questionDetailController.questionDetailData.create_date = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).create_date;
        questionDetailController.questionDetailData.questionId = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).questionId;
        questionDetailController.questionDetailData.content = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).content;
        questionDetailController.questionDetailData.pic = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).pic;
        questionDetailController.questionId = ((QuestionModel *)[self.askData objectAtIndex:indexPath.row]).questionId;
        questionDetailController.whereComeIn = @"0";
        [self.navigationController pushViewController:questionDetailController animated:YES];
    } else if(tableView==self.acceiptTabView){
        [RequestServer fetchMethodName:@"updateUnread" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"questionId":((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).questionId} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
                questionDetailController.age = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).age;
                questionDetailController.gender = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).gender;
                questionDetailController.questionDetailData.content = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).content;
                questionDetailController.questionDetailData.create_date = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).create_date;
                questionDetailController.questionDetailData.questionId = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).questionId;
                questionDetailController.questionDetailData.pic = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).pic;
                questionDetailController.questionId = ((QuestionModel *)[self.acceptData objectAtIndex:indexPath.row]).questionId;
                questionDetailController.whereComeIn = @"1";
                [self.navigationController pushViewController:questionDetailController animated:YES];
            }
        } failureHandler:^(NSString *errorInfo) {
            NSLog(@"%@",errorInfo);
        }];
    } else {
        questionDetailController.age = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).age;
        questionDetailController.gender = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).gender;
        questionDetailController.questionDetailData.create_date = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).create_date;
        questionDetailController.questionDetailData.questionId = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).questionId;
        questionDetailController.questionDetailData.content = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).content;
        questionDetailController.questionDetailData.pic = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).pic;
        questionDetailController.questionId = ((QuestionModel *)[self.doneData objectAtIndex:indexPath.row]).questionId;
        questionDetailController.whereComeIn = @"2";
        [self.navigationController pushViewController:questionDetailController animated:YES];
    }
}


-(void)tapSeg
{
    switch (self.queSeg.selectedSegmentIndex) {
        case 0: {
            [self.acceiptView removeFromSuperview];
            [self.doneView removeFromSuperview];
            [self.view addSubview:self.askView];
            [self.askView addSubview:self.askTabView];
            [self.askView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.view);
                make.top.equalTo(self.queSeg.mas_bottom).offset(5);
            }];
            break;
        }
        case 1: {
            [self.askView removeFromSuperview];
            [self.doneView removeFromSuperview];
            [self.view addSubview:self.acceiptView];
            [self.acceiptView addSubview:self.acceiptTabView];
            [self.acceiptView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.view);
                make.top.equalTo(self.queSeg.mas_bottom).offset(5);
            }];
            break;
        }
        case 2: {
            [self.askView removeFromSuperview];
            [self.acceiptView removeFromSuperview];
            [self.view addSubview:self.doneView];
            [self.doneView addSubview:self.doneTabView];
            [self.doneView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.view);
                make.top.equalTo(self.queSeg.mas_bottom).offset(5);
            }];
            break;
        }
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

-(void)qstTap{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"MyQuestionController" bundle:nil];
    QuestionsController *questionsController=[sb instantiateViewControllerWithIdentifier:@"QuestionsController"];
    [self.navigationController pushViewController:questionsController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupRefresh:(UITableView *)tableView
{
    //下拉刷新
    if (tableView == self.askTabView) {
        [tableView addHeaderWithTarget:self action:@selector(askTableheaderRereshing) dateKey:@"table"];
        [tableView headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [tableView addFooterWithTarget:self action:@selector(askTablefooterRereshing)];
    } else if (tableView == self.acceiptTabView){
        [tableView addHeaderWithTarget:self action:@selector(accTableheaderRereshing) dateKey:@"table"];
        [tableView headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [tableView addFooterWithTarget:self action:@selector(accTablefooterRereshing)];
    } else {
        [tableView addHeaderWithTarget:self action:@selector(doneTableheaderRereshing) dateKey:@"table"];
        [tableView headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [tableView addFooterWithTarget:self action:@selector(doneTablefooterRereshing)];
    }
    //一些设置
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    tableView.headerPullToRefreshText = @"下拉可以刷新了";
    tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    tableView.headerRefreshingText = @"刷新中。。。";
    
    tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    tableView.footerRefreshingText = @"加载中。。。";
}
//下拉刷新
- (void)askTableheaderRereshing
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    self.askCurrentPage = 1;
    
    [RequestServer fetchMethodName:@"myQuestions" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"status":@"0",@"pageNum":[NSString stringWithFormat:@"%d",self.askCurrentPage],@"pageSize":@"10"} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        [self.askData removeAllObjects];
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            QuestionModel *question=[QuestionModel objectWithKeyValues:dict];
            if ([question.status isEqualToString:@"0"]||[question.status isEqualToString:@"1"]) {
                [self.askData  addObject:question];
            }
        }
        self.askCurrentPage++;
        [self.askTabView reloadData];
        [self.askTabView headerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

-(void)accTableheaderRereshing {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    self.accCurrentPage = 1;
    [RequestServer fetchMethodName:@"myQuestions" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"status":@"2",@"pageNum":[NSString stringWithFormat:@"%d",self.accCurrentPage],@"pageSize":@"10"} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        [self.acceptData removeAllObjects];
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            QuestionModel *question=[QuestionModel objectWithKeyValues:dict];
            if ([question.status isEqualToString:@"2"]||[question.status isEqualToString:@"3"]) {
                [self.acceptData  addObject:question];
            }
        }
        self.accCurrentPage++;
        [self.acceiptTabView reloadData];
        [self.acceiptTabView headerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

- (void)doneTableheaderRereshing
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    self.doneCurrentPage = 1;
    
    [RequestServer fetchMethodName:@"myQuestions" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"status":@"3",@"pageNum":[NSString stringWithFormat:@"%d",self.doneCurrentPage],@"pageSize":@"10"} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        [self.doneData removeAllObjects];
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            QuestionModel *question=[QuestionModel objectWithKeyValues:dict];
            if ([question.status isEqualToString:@"3"]) {
                [self.doneData  addObject:question];
            }
        }
        self.doneCurrentPage++;
        [self.doneTabView reloadData];
        [self.doneTabView headerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

//上拉加载
- (void)askTablefooterRereshing
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"myQuestions" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"status":@"0",@"pageNum":[NSString stringWithFormat:@"%d",self.askCurrentPage],@"pageSize":@"10"} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            QuestionModel *question=[QuestionModel objectWithKeyValues:dict];
            if ([question.status isEqualToString:@"0"]||[question.status isEqualToString:@"1"]) {
                [self.askData  insertObject:question atIndex:[_askData count]];
            }
        }
        self.askCurrentPage++;
        [self.askTabView reloadData];
        [self.askTabView footerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

-(void)accTablefooterRereshing {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"myQuestions" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"status":@"0",@"pageNum":[NSString stringWithFormat:@"%d",self.askCurrentPage],@"pageSize":@"10"} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            QuestionModel *question=[QuestionModel objectWithKeyValues:dict];
            if ([question.status isEqualToString:@"2"]||[question.status isEqualToString:@"3"]) {
                [self.acceptData  insertObject:question atIndex:[_acceptData count]];
            }
        }
        self.accCurrentPage++;
        [self.acceiptTabView reloadData];
        [self.acceiptTabView footerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

- (void)doneTablefooterRereshing
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userId= [user objectForKey:@"userIdz"];
    NSString *userAccount = [user objectForKey:@"userAccountz"];
    NSString *userPwd = [user objectForKey:@"userPwdz"];
    [RequestServer fetchMethodName:@"myQuestions" parameters:@{@"userId":userId,@"userAccount":userAccount,@"userPwd":userPwd,@"status":@"3",@"pageNum":[NSString stringWithFormat:@"%d",self.doneCurrentPage],@"pageSize":@"10"} shouldDisplayLoadingIndicator:NO puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
        NSArray *inforArys=responseDic[@"data"];
        for (NSDictionary *dict  in inforArys) {
            QuestionModel *question=[QuestionModel objectWithKeyValues:dict];
            if ([question.status isEqualToString:@"3"]) {
                [self.doneData  insertObject:question atIndex:[_doneData count]];
            }
        }
        self.doneCurrentPage++;
        [self.doneTabView reloadData];
        [self.doneTabView footerEndRefreshing];
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"%@",errorInfo);
    }];
}

@end
