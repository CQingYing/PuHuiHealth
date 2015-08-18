//
//  HealthKnowlegeController.m
//  PuHui
//
//  Created by rp.wang on 15/8/7.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "HealthKnowlegeController.h"
#import "HealMainModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "HKTableViewController.h"

@interface HealthKnowlegeController ()
@property (strong, nonatomic)  UIView *boardView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (assign,nonatomic)  CGFloat  wid;
@property (assign,nonatomic)  CGFloat  widBtn;
@property (assign,nonatomic)  CGFloat  widScreen;
@property (strong, nonatomic) UIView *horiLine;
@property (strong, nonatomic) UIView *vertLine1;
@property (strong, nonatomic) UIView *vertLine2;
@property (strong, nonatomic) UIView *horiLine2;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic) NSArray *conAry;
@property (strong, nonatomic) NSMutableArray *arrysMuta;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mainHeiCons;
@end

@implementation HealthKnowlegeController
//*模型数据*/
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}
- (UIView *)boardView
{ //*(2/3)+1)
    if (!_boardView) {
        _boardView= [[UIView alloc] initWithFrame:CGRectMake(16, 8, self.wid, (self.wid-2)*2/3+1)];
    }
    return _boardView;
}
- (UIView *)horiLine
{ //*(2/3)+1)
    if (!_horiLine) {
        _horiLine= [[UIView alloc] initWithFrame:CGRectMake(0,self.widBtn, self.view.frame.size.width-32, 1)];
        _horiLine.backgroundColor=[UIColor colorWithRed:123.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:0.3];
    }
    return _horiLine;
}
- (UIView *)horiLine2
{ //*(2/3)+1)
    if (!_horiLine2) {
        _horiLine2= [[UIView alloc] initWithFrame:CGRectMake(0,(self.wid-2)*2/3+18, self.view.frame.size.width, 1)];
        _horiLine2.backgroundColor=[UIColor colorWithRed:123.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:0.3];
    }
    return _horiLine2;
}
- (UIView *)vertLine1
{ //*(2/3)+1)
    if (!_vertLine1) {
        _vertLine1= [[UIView alloc] initWithFrame:CGRectMake(self.widBtn,0, 1, self.widBtn*2+1)];
        _vertLine1.backgroundColor=[UIColor colorWithRed:123.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:0.3];
    }
    return _vertLine1;
}
- (UIView *)vertLine2
{ //*(2/3)+1)
    if (!_vertLine2) {
        _vertLine2= [[UIView alloc] initWithFrame:CGRectMake(self.widBtn*2+1,0,1, self.widBtn*2+1)];
        _vertLine2.backgroundColor=[UIColor colorWithRed:123.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:0.3];
    }
    return _vertLine2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    [self initBase];
    [self initLoadBtns];
    [self loadResourse];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initBase{
    self.wid=self.view.frame.size.width-32;
    self.widBtn=(self.view.frame.size.width-34)/3;
    [self.mainView addSubview:self.boardView];
    [self.boardView addSubview:self.horiLine];
    [self.mainView addSubview:self.horiLine2];
    [self.boardView addSubview:self.vertLine1];
    [self.boardView addSubview:self.vertLine2];
    self.conAry=@[@"体检常识",@"疾病常识",@"慢病指导",@"女性健康",@"养生保健"];
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    self.widScreen= size.width;
}

-(void)initLoadBtn{
    
    for (int i=0; i<5; i++) {
        if (i==0||i==1||i==2) {
           
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((self.widBtn+1)*i,self.widBtn*1/5,self.widBtn,self.widBtn*2/5)];
            NSString *btnSty=[NSString stringWithFormat:@"Zhealthicon%d",i+1];
            [img setImage:[UIImage imageNamed:btnSty]];
            img.contentMode = UIViewContentModeScaleAspectFit;
            
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((self.widBtn+1)*i,self.widBtn*3/5,self.widBtn,self.widBtn*2/5)];
            lab.text=self.conAry[i];
            [lab setTextAlignment:NSTextAlignmentCenter];
            lab.textColor=[UIColor grayColor];
            
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.widBtn+1)*i, 0, self.widBtn, self.widBtn)];
            btn.backgroundColor=[UIColor clearColor];
            btn.tag=i+1;
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.boardView addSubview:img];
            [self.boardView addSubview:lab];
            [self.boardView addSubview:btn];
        }
        if (i==3||i==4) {
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i-3), self.widBtn+1+(self.widBtn*1/5), self.widBtn, self.widBtn*2/5)];
            NSString *btnSty=[NSString stringWithFormat:@"Zhealthicon%d",i+1];
            [img setImage:[UIImage imageNamed:btnSty]];
            img.contentMode = UIViewContentModeScaleAspectFit;
            
            
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i-3), self.widBtn+1+(self.widBtn*3/5), self.widBtn, self.widBtn*2/5)];
            lab.text=self.conAry[i];
            [lab setTextAlignment:NSTextAlignmentCenter];
            lab.textColor=[UIColor grayColor];
            
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i-3), self.widBtn+1, self.widBtn, self.widBtn)];
            btn.tag=i+1;
            btn.backgroundColor=[UIColor clearColor];
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
            [self.boardView addSubview:img];
            [self.boardView addSubview:lab];
            [self.boardView addSubview:btn];
        }
    }
}
-(void)initLoadBtns{
    
    for (int i=0; i<self.arrysMuta.count; i++) {
        //j表示行数
        for (int j=2; j<5; j++) {
            if (i==j*3) {
               //每进一次if 就加一条水平线
                UIView * newImg= [[UIView alloc] initWithFrame:CGRectMake(0,(self.widBtn+j)*j-1, self.view.frame.size.width-32, 1)];
                newImg.backgroundColor=[UIColor colorWithRed:123.0/255.0 green:123.0/255.0 blue:123.0/255.0 alpha:0.3];
                [self.boardView addSubview:newImg];
                //改变纵向的长度
                
                CGRect  fra1=self.vertLine1.frame;
                CGRect  fra2=self.vertLine2.frame;
                
                fra1=CGRectMake(self.widBtn,0, 1, (self.widBtn+j)*j+self.widBtn);
                self.vertLine1.frame=fra1;
                
                fra2=CGRectMake(self.widBtn*2+1,0,1, (self.widBtn+j)*j+self.widBtn);
                self.vertLine2.frame=fra2;
               
                //底部线
                CGRect  fra3 =self.horiLine2.frame;
                fra3=CGRectMake(0,(self.widBtn+j)*j+self.widBtn+8, self.view.frame.size.width, 1);
                self.horiLine2.frame=fra3;
                
                //底板
                CGRect  fraBoa =self.boardView.frame;
                 fraBoa=CGRectMake(16, 8, self.wid, (self.wid-2)*(j+1)/3+j);
                self.boardView.frame=fraBoa;
                
                //主底板
                self.mainHeiCons.constant=(self.wid-2)*(j+1)/3+j+60;
               //横向j条线的 Y坐标     (self.widBtn+j)*j-1
               //纵向1,2条线的 高度    (self.widBtn+j)*j+self.widBtn
               //横向底部线的y坐标      (self.widBtn+j)*j+self.widBtn+8
            }
        }
//
        
        
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i%3), (self.widBtn+1)*(i/3)+(self.widBtn*1/5), self.widBtn, self.widBtn*2/5)];
            
            HealMainModel *heal= self.arrysMuta[i];
            NSString *tempStr=[PHJKRequestUrl stringByAppendingString:heal.categoryIcon];
            [img sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"Zhealthicon2"]];
            img.contentMode = UIViewContentModeScaleAspectFit;
            
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i%3),(self.widBtn+1)*(i/3)+self.widBtn*3/5,self.widBtn,self.widBtn*2/5)];
            lab.text=heal.categoryName;
            [lab setTextAlignment:NSTextAlignmentCenter];
            lab.textColor=[UIColor grayColor];
            UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i%3), (self.widBtn+1)*(i/3), self.widBtn, self.widBtn)];
            btn.backgroundColor=[UIColor clearColor];
            btn.tag=i+1;
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.boardView addSubview:img];
            [self.boardView addSubview:lab];
            [self.boardView addSubview:btn];
        
       
    }
}

-(void)loadResourse{
    
    [RequestServer fetchMethodName:@"categoryList" parameters:@{@"superId":@"0"} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK  successHandler:^(NSMutableDictionary *responseDic) {
        if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
            NSArray *inforArys=responseDic[@"data"];
            if (inforArys.count==0) {
                 [self showAllTextDialog:@"此页无数据！"];
                 return ;
            }
            //方式1
            for (NSDictionary *dict  in inforArys) {
                HealMainModel *heal=[HealMainModel objectWithKeyValues:dict];
                [self.arrysMuta  addObject:heal];
            }
        }else
        {
            [self showAllTextDialog:responseDic[@"retMsg"]];
        
        }

        [self initLoadBtns];
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


-(void)btnTap:(UIButton *)btn{
    
    for(int i=0;i<self.arrysMuta.count;i++){
        if (btn.tag==(i+1)) {
//            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"HealthKnowlegeController" bundle:nil];
//            HKTableViewController *selectCourtController=[sb instantiateViewControllerWithIdentifier:@"HKTableViewController"];
            
            HKTableViewController * selectCourtController=[[HKTableViewController alloc]init];
            HealMainModel *heal= self.arrysMuta[i];
            selectCourtController.categoryId=heal.categoryId;
            selectCourtController.NavTitle = heal.categoryName;
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
            backItem.title = @"";
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:selectCourtController animated:YES];
        }
    
    }
}

//if (i==0||i==1||i==2) {
//    
//    // UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((self.widBtn+1)*i,self.widBtn*1/5,self.widBtn,self.widBtn*2/5)];
//    
//    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i%3), (self.widBtn+1)*(i/3)+(self.widBtn*1/5), self.widBtn, self.widBtn*2/5)];
//    
//    HealMainModel *heal= self.arrysMuta[i];
//    NSString *tempStr=[PHJKRequestUrl stringByAppendingString:heal.categoryIcon];
//    [img sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"Zhealthicon2"]];
//    img.contentMode = UIViewContentModeScaleAspectFit;
//    
//    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((self.widBtn+1)*i,self.widBtn*3/5,self.widBtn,self.widBtn*2/5)];
//    lab.text=heal.categoryName;
//    [lab setTextAlignment:NSTextAlignmentCenter];
//    lab.textColor=[UIColor grayColor];
//    
//    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.widBtn+1)*i, 0, self.widBtn, self.widBtn)];
//    btn.backgroundColor=[UIColor clearColor];
//    btn.tag=i+1;
//    [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    [self.boardView addSubview:img];
//    [self.boardView addSubview:lab];
//    [self.boardView addSubview:btn];
//}
//if (i==3||i==4||i==5) {
//    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i-3), self.widBtn+1+(self.widBtn*1/5), self.widBtn, self.widBtn*2/5)];
//    HealMainModel *heal= self.arrysMuta[i];
//    NSString *tempStr=[PHJKRequestUrl stringByAppendingString:heal.categoryIcon];
//    [img sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"Zhealthicon2"]];
//    
//    //            NSString *btnSty=[NSString stringWithFormat:@"Zhealthicon%d",i+1];
//    //            [img setImage:[UIImage imageNamed:btnSty]];
//    
//    img.contentMode = UIViewContentModeScaleAspectFit;
//    
//    
//    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i-3), self.widBtn+1+(self.widBtn*3/5), self.widBtn, self.widBtn*2/5)];
//    lab.text=heal.categoryName;
//    [lab setTextAlignment:NSTextAlignmentCenter];
//    lab.textColor=[UIColor grayColor];
//    
//    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((self.widBtn+1)*(i-3), self.widBtn+1, self.widBtn, self.widBtn)];
//    btn.tag=i+1;
//    btn.backgroundColor=[UIColor clearColor];
//    [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
//    [self.boardView addSubview:img];
//    [self.boardView addSubview:lab];
//    [self.boardView addSubview:btn];
//}

@end
