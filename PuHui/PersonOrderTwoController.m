//
//  PersonOrderTwoController.m
//  PuHui
//
//  Created by rp.wang on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonOrderTwoController.h"
#import "BBRim.h"
#import "PersonOrderThreeController.h"
#import "MBProgressHUD.h"
#import "TestResultController.h"

@interface PersonOrderTwoController ()
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIButton *submmitBtn;
@property (strong, nonatomic) IBOutlet UIImageView *con1a;
@property (strong, nonatomic) IBOutlet UIImageView *con1b;
@property (strong, nonatomic) IBOutlet UIImageView *con1c;
@property (strong, nonatomic) IBOutlet UIImageView *con1d;
@property (strong, nonatomic) IBOutlet UIImageView *con1e;
@property (strong, nonatomic) IBOutlet UIImageView *con1f;
@property (strong, nonatomic) IBOutlet UIImageView *con1g;
@property (strong, nonatomic) IBOutlet UIImageView *con1h;
@property (strong, nonatomic) IBOutlet UIImageView *con2a;
@property (strong, nonatomic) IBOutlet UIImageView *con2b;
@property (strong, nonatomic) IBOutlet UIImageView *con2c;
@property (strong, nonatomic) IBOutlet UIImageView *con2d;
@property (strong, nonatomic) IBOutlet UIImageView *con2e;
@property (strong, nonatomic) IBOutlet UIImageView *con2f;
@property (strong, nonatomic) IBOutlet UIImageView *con2g;
@property (strong, nonatomic) IBOutlet UILabel *it1a;
@property (strong, nonatomic) IBOutlet UILabel *it1b;
@property (strong, nonatomic) IBOutlet UILabel *it1c;
@property (strong, nonatomic) IBOutlet UILabel *it1d;
@property (strong, nonatomic) IBOutlet UILabel *it1e;
@property (strong, nonatomic) IBOutlet UILabel *it1f;
@property (strong, nonatomic) IBOutlet UILabel *it1g;
@property (strong, nonatomic) IBOutlet UILabel *it1h;
@property (strong, nonatomic) IBOutlet UILabel *it2a;
@property (strong, nonatomic) IBOutlet UILabel *it2b;
@property (strong, nonatomic) IBOutlet UILabel *it2c;
@property (strong, nonatomic) IBOutlet UILabel *it2d;
@property (strong, nonatomic) IBOutlet UILabel *it2e;
@property (strong, nonatomic) IBOutlet UILabel *it2f;
@property (strong, nonatomic) IBOutlet UILabel *it2g;



//是否选中 0：否   1：是
@property (assign,nonatomic) int  isSelect1a;
@property (assign,nonatomic) int  isSelect1b;
@property (assign,nonatomic) int  isSelect1c;
@property (assign,nonatomic) int  isSelect1d;
@property (assign,nonatomic) int  isSelect1e;
@property (assign,nonatomic) int  isSelect1f;
@property (assign,nonatomic) int  isSelect1g;
@property (assign,nonatomic) int  isSelect1h;

@property (assign,nonatomic) int  isSelect2a;
@property (assign,nonatomic) int  isSelect2b;
@property (assign,nonatomic) int  isSelect2c;
@property (assign,nonatomic) int  isSelect2d;
@property (assign,nonatomic) int  isSelect2e;
@property (assign,nonatomic) int  isSelect2f;
@property (assign,nonatomic) int  isSelect2g;
@property (strong, nonatomic) IBOutlet UILabel *sele1;
@property (strong, nonatomic) IBOutlet UILabel *sele2;


@property (strong, nonatomic)  NSMutableArray *endmutaArrs;
@end

@implementation PersonOrderTwoController

- (NSMutableArray *)endmutaArrs
{
    if (!_endmutaArrs) {
        _endmutaArrs = [[NSMutableArray alloc] init];
    }
    return _endmutaArrs;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.nextBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithViews:@[self.nextBtn,self.submmitBtn] radius:6 width:1 color:[UIColor orangeColor]];
    [self.submmitBtn setBackgroundColor:[UIColor orangeColor]];
    [self.submmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sele1.textColor=[UIColor orangeColor];
    self.sele2.textColor=[UIColor orangeColor];
    // 添加手势
    [self setTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextTap:(id)sender {
    //PersonOrderThreeController
    UIStoryboard  *SB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    PersonOrderThreeController *personOrderThreeController=[SB instantiateViewControllerWithIdentifier:@"PersonOrderThreeController"];
    [self  getMeals];
    [self deleteRepeat];
    
    //NSSet *set = [NSSet setWithArray:self.mutaArrs];
//    NSEnumerator * enumerator = [set objectEnumerator];
//    NSString *str;
//    while (str = [enumerator nextObject]) {
//        NSLog(@"!!!%@",str);
//         }
    
    personOrderThreeController.mutaArrs=self.endmutaArrs;
    personOrderThreeController.isMen=self.isMen;
    personOrderThreeController.ageRang=self.ageRang;
    personOrderThreeController.isSex=self.isSex;
    [self.navigationController pushViewController:personOrderThreeController animated:YES];

}
- (IBAction)submmitTap:(id)sender {
    
    [self  getMeals];
    [self deleteRepeat];
    for (int i=0; i<self.endmutaArrs.count; i++) {
        NSLog(@"^^^^^^%@",self.endmutaArrs[i]);
    }
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    TestResultController *selectCourtController=[sb instantiateViewControllerWithIdentifier:@"TestResultController"];
    selectCourtController.endmutaArrs=self.endmutaArrs;
    [self.navigationController pushViewController:selectCourtController animated:YES];
}
/**
 *  获得套餐列表信息
 *
 */
- (void)setMealInfo
{//"肝功10项","血脂二项","胃蛋白酶原"   //self.endmutaArrs
    [RequestServer fetchMethodName:@"health_appserv_itemDetail" parameters:@{@"itemList":self.endmutaArrs} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiYW successHandler:^(NSMutableDictionary *responseDic) {
        if ([responseDic[@"retCode"] isEqualToString:@"0"]) {
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
            TestResultController *selectCourtController=[sb instantiateViewControllerWithIdentifier:@"TestResultController"];
            [self.navigationController pushViewController:selectCourtController animated:YES];
        }else{
            [self showAllTextDialog:responseDic[@"retMsg"]];
        }
        
    } failureHandler:^(NSString *errorInfo) {
        NSLog(@"error :%@",errorInfo);
    }];
}


-(void)setTap{
    self.con1a.userInteractionEnabled=YES;
    self.con1b.userInteractionEnabled=YES;
    self.con1c.userInteractionEnabled=YES;
    self.con1d.userInteractionEnabled=YES;
    self.con1e.userInteractionEnabled=YES;
    self.con1f.userInteractionEnabled=YES;
    self.con1g.userInteractionEnabled=YES;
    self.con1h.userInteractionEnabled=YES;
    
    self.con2a.userInteractionEnabled=YES;
    self.con2b.userInteractionEnabled=YES;
    self.con2c.userInteractionEnabled=YES;
    self.con2d.userInteractionEnabled=YES;
    self.con2e.userInteractionEnabled=YES;
    self.con2f.userInteractionEnabled=YES;
    self.con2g.userInteractionEnabled=YES;
    
    self.it1a.userInteractionEnabled=YES;
    self.it1b.userInteractionEnabled=YES;
    self.it1c.userInteractionEnabled=YES;
    self.it1d.userInteractionEnabled=YES;
    self.it1e.userInteractionEnabled=YES;
    self.it1f.userInteractionEnabled=YES;
    self.it1g.userInteractionEnabled=YES;
    self.it1h.userInteractionEnabled=YES;
    
    self.it2a.userInteractionEnabled=YES;
    self.it2b.userInteractionEnabled=YES;
    self.it2c.userInteractionEnabled=YES;
    self.it2d.userInteractionEnabled=YES;
    self.it2e.userInteractionEnabled=YES;
    self.it2f.userInteractionEnabled=YES;
    self.it2g.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *con1aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con1aTap)];
    UITapGestureRecognizer *con1bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con1bTap)];
    UITapGestureRecognizer *con1cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con1cTap)];
    UITapGestureRecognizer *con1dGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con1dTap)];
    UITapGestureRecognizer *con1eGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con1eTap)];
    UITapGestureRecognizer *con1fGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con1fTap)];
    UITapGestureRecognizer *con1gGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con1gTap)];
    UITapGestureRecognizer *con1hGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con1hTap)];
    
    
    
    
    UITapGestureRecognizer *con2aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con2aTap)];
    UITapGestureRecognizer *con2bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con2bTap)];
    UITapGestureRecognizer *con2cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con2cTap)];
    UITapGestureRecognizer *con2dGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con2dTap)];
    UITapGestureRecognizer *con2eGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con2eTap)];
    UITapGestureRecognizer *con2fGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con2fTap)];
    UITapGestureRecognizer *con2gGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con2gTap)];
    
    
    UITapGestureRecognizer *it1aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it1aTap)];
    UITapGestureRecognizer *it1bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it1bTap)];
    UITapGestureRecognizer *it1cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it1cTap)];
    UITapGestureRecognizer *it1dGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it1dTap)];
    UITapGestureRecognizer *it1eGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it1eTap)];
    UITapGestureRecognizer *it1fGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it1fTap)];
    UITapGestureRecognizer *it1gGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it1gTap)];
    UITapGestureRecognizer *it1hGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it1hTap)];
    
    
    
    
    UITapGestureRecognizer *it2aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it2aTap)];
    UITapGestureRecognizer *it2bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it2bTap)];
    UITapGestureRecognizer *it2cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it2cTap)];
    UITapGestureRecognizer *it2dGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it2dTap)];
    UITapGestureRecognizer *it2eGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it2eTap)];
    UITapGestureRecognizer *it2fGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it2fTap)];
    UITapGestureRecognizer *it2gGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it2gTap)];
    
    
    [self.con1a addGestureRecognizer:con1aGes];
    [self.con1b addGestureRecognizer:con1bGes];
    [self.con1c addGestureRecognizer:con1cGes];
    [self.con1d addGestureRecognizer:con1dGes];
    [self.con1e addGestureRecognizer:con1eGes];
    [self.con1f addGestureRecognizer:con1fGes];
    [self.con1g addGestureRecognizer:con1gGes];
    [self.con1h addGestureRecognizer:con1hGes];
    
    [self.con2a addGestureRecognizer:con2aGes];
    [self.con2b addGestureRecognizer:con2bGes];
    [self.con2c addGestureRecognizer:con2cGes];
    [self.con2d addGestureRecognizer:con2dGes];
    [self.con2e addGestureRecognizer:con2eGes];
    [self.con2f addGestureRecognizer:con2fGes];
    [self.con2g addGestureRecognizer:con2gGes];
    
    
    [self.it1a addGestureRecognizer:it1aGes];
    [self.it1b addGestureRecognizer:it1bGes];
    [self.it1c addGestureRecognizer:it1cGes];
    [self.it1d addGestureRecognizer:it1dGes];
    [self.it1e addGestureRecognizer:it1eGes];
    [self.it1f addGestureRecognizer:it1fGes];
    [self.it1g addGestureRecognizer:it1gGes];
    [self.it1h addGestureRecognizer:it1hGes];
    
    [self.it2a addGestureRecognizer:it2aGes];
    [self.it2b addGestureRecognizer:it2bGes];
    [self.it2c addGestureRecognizer:it2cGes];
    [self.it2d addGestureRecognizer:it2dGes];
    [self.it2e addGestureRecognizer:it2eGes];
    [self.it2f addGestureRecognizer:it2fGes];
    [self.it2g addGestureRecognizer:it2gGes];
}
-(void)con1aTap{
    self.isSelect1a=1;
    self.con1a.image=[UIImage imageNamed:@"personselected"];
    self.con1b.image=[UIImage imageNamed:@"personnotselected"];
    self.con1c.image=[UIImage imageNamed:@"personnotselected"];
    self.con1d.image=[UIImage imageNamed:@"personnotselected"];
    self.con1e.image=[UIImage imageNamed:@"personnotselected"];
    self.con1f.image=[UIImage imageNamed:@"personnotselected"];
    self.con1g.image=[UIImage imageNamed:@"personnotselected"];
    self.con1h.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect1b=0;
    self.isSelect1c=0;
    self.isSelect1d=0;
    self.isSelect1e=0;
    self.isSelect1f=0;
    self.isSelect1g=0;
    self.isSelect1h=0;
}
-(void)con1bTap{
    if (self.isSelect1b==0) {
        self.con1b.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1b=1;
        return;
    }
    if (self.isSelect1b==1) {
        self.con1b.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1b=0;
        return;
    }
}
-(void)con1cTap{
    if (self.isSelect1c==0) {
        self.con1c.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1c=1;
        return;
    }
    if (self.isSelect1c==1) {
        self.con1c.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1c=0;
        return;
    }
}

-(void)con1dTap{
    if (self.isSelect1d==0) {
        self.con1d.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1d=1;
        return;
    }
    if (self.isSelect1d==1) {
        self.con1d.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1d=0;
        return;
    }
}

-(void)con1eTap{
    if (self.isSelect1e==0) {
        self.con1e.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1e=1;
        return;
    }
    if (self.isSelect1e==1) {
        self.con1e.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1e=0;
        return;
    }
}

-(void)con1fTap{
    if (self.isSelect1f==0) {
        self.con1f.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1f=1;
        return;
    }
    if (self.isSelect1f==1) {
        self.con1f.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1f=0;
        return;
    }
}

-(void)con1gTap{
    if (self.isSelect1g==0) {
        self.con1g.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1g=1;
        return;
    }
    if (self.isSelect1g==1) {
        self.con1g.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1g=0;
        return;
    }
}
-(void)con1hTap{
    if (self.isSelect1h==0) {
        self.con1h.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1h=1;
        return;
    }
    if (self.isSelect1h==1) {
        self.con1h.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1h=0;
        return;
    }
}




-(void)con2aTap{
    self.isSelect2a=1;
    self.con2a.image=[UIImage imageNamed:@"personselected"];
    self.con2b.image=[UIImage imageNamed:@"personnotselected"];
    self.con2c.image=[UIImage imageNamed:@"personnotselected"];
    self.con2d.image=[UIImage imageNamed:@"personnotselected"];
    self.con2e.image=[UIImage imageNamed:@"personnotselected"];
    self.con2f.image=[UIImage imageNamed:@"personnotselected"];
    self.con2g.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect2b=0;
    self.isSelect2c=0;
    self.isSelect2d=0;
    self.isSelect2e=0;
    self.isSelect2f=0;
    self.isSelect2g=0;
}
-(void)con2bTap{
    if (self.isSelect2b==0) {
        self.con2b.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2b=1;
        return;
    }
    if (self.isSelect2b==1) {
        self.con2b.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2b=0;
        return;
    }
}

-(void)con2cTap{
    if (self.isSelect2c==0) {
        self.con2c.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2c=1;
        return;
    }
    if (self.isSelect2c==1) {
        self.con2c.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2c=0;
        return;
    }
}


-(void)con2dTap{
    if (self.isSelect2d==0) {
        self.con2d.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2d=1;
        return;
    }
    if (self.isSelect2d==1) {
        self.con2d.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2d=0;
        return;
    }
}


-(void)con2eTap{
    if (self.isSelect2e==0) {
        self.con2e.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2e=1;
        return;
    }
    if (self.isSelect2e==1) {
        self.con2e.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2e=0;
        return;
    }
}


-(void)con2fTap{
    if (self.isSelect2f==0) {
        self.con2f.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2f=1;
        return;
    }
    if (self.isSelect2f==1) {
        self.con2f.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2f=0;
        return;
    }
}


-(void)con2gTap{
    if (self.isSelect2g==0) {
        self.con2g.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2g=1;
        return;
    }
    if (self.isSelect2g==1) {
        self.con2g.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2g=0;
        return;
    }
}







-(void)it1aTap{
    self.isSelect1a=1;
    self.con1a.image=[UIImage imageNamed:@"personselected"];
    self.con1b.image=[UIImage imageNamed:@"personnotselected"];
    self.con1c.image=[UIImage imageNamed:@"personnotselected"];
    self.con1d.image=[UIImage imageNamed:@"personnotselected"];
    self.con1e.image=[UIImage imageNamed:@"personnotselected"];
    self.con1f.image=[UIImage imageNamed:@"personnotselected"];
    self.con1g.image=[UIImage imageNamed:@"personnotselected"];
    self.con1h.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect1b=0;
    self.isSelect1c=0;
    self.isSelect1d=0;
    self.isSelect1e=0;
    self.isSelect1f=0;
    self.isSelect1g=0;
    self.isSelect1h=0;
}
-(void)it1bTap{
    if (self.isSelect1b==0) {
        self.con1b.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1b=1;
        return;
    }
    if (self.isSelect1b==1) {
        self.con1b.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1b=0;
        return;
    }
}
-(void)it1cTap{
    if (self.isSelect1c==0) {
        self.con1c.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1c=1;
        return;
    }
    if (self.isSelect1c==1) {
        self.con1c.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1c=0;
        return;
    }
}

-(void)it1dTap{
    if (self.isSelect1d==0) {
        self.con1d.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1d=1;
        return;
    }
    if (self.isSelect1d==1) {
        self.con1d.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1d=0;
        return;
    }
}

-(void)it1eTap{
    if (self.isSelect1e==0) {
        self.con1e.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1e=1;
        return;
    }
    if (self.isSelect1e==1) {
        self.con1e.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1e=0;
        return;
    }
}

-(void)it1fTap{
    if (self.isSelect1f==0) {
        self.con1f.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1f=1;
        return;
    }
    if (self.isSelect1f==1) {
        self.con1f.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1f=0;
        return;
    }
}

-(void)it1gTap{
    if (self.isSelect1g==0) {
        self.con1g.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1g=1;
        return;
    }
    if (self.isSelect1g==1) {
        self.con1g.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1g=0;
        return;
    }
}
-(void)it1hTap{
    if (self.isSelect1h==0) {
        self.con1h.image=[UIImage imageNamed:@"personselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1h=1;
        return;
    }
    if (self.isSelect1h==1) {
        self.con1h.image=[UIImage imageNamed:@"personnotselected"];
        self.con1a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect1a=0;
        self.isSelect1h=0;
        return;
    }
}




-(void)it2aTap{
    self.isSelect2a=1;
    self.con2a.image=[UIImage imageNamed:@"personselected"];
    self.con2b.image=[UIImage imageNamed:@"personnotselected"];
    self.con2c.image=[UIImage imageNamed:@"personnotselected"];
    self.con2d.image=[UIImage imageNamed:@"personnotselected"];
    self.con2e.image=[UIImage imageNamed:@"personnotselected"];
    self.con2f.image=[UIImage imageNamed:@"personnotselected"];
    self.con2g.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect2b=0;
    self.isSelect2c=0;
    self.isSelect2d=0;
    self.isSelect2e=0;
    self.isSelect2f=0;
    self.isSelect2g=0;
}
-(void)it2bTap{
    if (self.isSelect2b==0) {
        self.con2b.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2b=1;
        return;
    }
    if (self.isSelect2b==1) {
        self.con2b.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2b=0;
        return;
    }
}

-(void)it2cTap{
    if (self.isSelect2c==0) {
        self.con2c.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2c=1;
        return;
    }
    if (self.isSelect2c==1) {
        self.con2c.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2c=0;
        return;
    }
}


-(void)it2dTap{
    if (self.isSelect2d==0) {
        self.con2d.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2d=1;
        return;
    }
    if (self.isSelect2d==1) {
        self.con2d.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2d=0;
        return;
    }
}


-(void)it2eTap{
    if (self.isSelect2e==0) {
        self.con2e.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2e=1;
        return;
    }
    if (self.isSelect2e==1) {
        self.con2e.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2e=0;
        return;
    }
}


-(void)it2fTap{
    if (self.isSelect2f==0) {
        self.con2f.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2f=1;
        return;
    }
    if (self.isSelect2f==1) {
        self.con2f.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2f=0;
        return;
    }
}


-(void)it2gTap{
    if (self.isSelect2g==0) {
        self.con2g.image=[UIImage imageNamed:@"personselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2g=1;
        return;
    }
    if (self.isSelect2g==1) {
        self.con2g.image=[UIImage imageNamed:@"personnotselected"];
        self.con2a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect2a=0;
        self.isSelect2g=0;
        return;
    }
}




-(void)getMeals{
    if (self.isMen==1) {
        //高血压
        if(self.isSelect1b==1){
            [self.mutaArrs addObject:@"血流变（男）"  ];
            [self.mutaArrs addObject:@"血脂四项"  ];
        }
        //冠心病
        if(self.isSelect1c==1){
            [self.mutaArrs addObject:@"血流变（男）"];
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"肌钙蛋白1"];
            [self.mutaArrs addObject:@"超敏C反应蛋白"];
            [self.mutaArrs addObject:@"同型半胱氨酸"];
            [self.mutaArrs addObject:@"脂蛋白相关磷脂酶A2测定"];
        }
        //脑中风
        if(self.isSelect1d==1){
            [self.mutaArrs addObject:@"血流变（男）"];
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"脑流血（TCD）"];
            [self.mutaArrs addObject:@"动脉血管硬度测定"];
            [self.mutaArrs addObject:@"颅脑CT"];
            [self.mutaArrs addObject:@"脂蛋白（a）"];
        }
    }else{
        //高血压
        if(self.isSelect1b==1){
            [self.mutaArrs addObject:@"血流变（女）"  ];
            [self.mutaArrs addObject:@"血脂四项"  ];
        }
        //冠心病
        if(self.isSelect1c==1){
            [self.mutaArrs addObject:@"血流变（女）"];
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"肌钙蛋白1"];
            [self.mutaArrs addObject:@"超敏C反应蛋白"];
            [self.mutaArrs addObject:@"同型半胱氨酸"];
            [self.mutaArrs addObject:@"脂蛋白相关磷脂酶A2测定"];
        }
        //脑中风
        if(self.isSelect1d==1){
            [self.mutaArrs addObject:@"血流变（女）"];
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"脑流血（TCD）"];
            [self.mutaArrs addObject:@"动脉血管硬度测定"];
            [self.mutaArrs addObject:@"颅脑CT"];
            [self.mutaArrs addObject:@"脂蛋白（a）"];
        }

    
    }
        //糖尿病
        if(self.isSelect1e==1){
            [self.mutaArrs addObject:@"糖化血红蛋白"];
            [self.mutaArrs addObject:@"葡萄糖耐量试验"];
        }
        //肿瘤
        if(self.isSelect1f==1){
            [self.mutaArrs addObject:@"癌胚抗原（定量）"];
            [self.mutaArrs addObject:@"甲胎蛋白（定量）"];
            [self.mutaArrs addObject:@"特异性肿瘤因子"];
            [self.mutaArrs addObject:@"糖类抗原CA50"];
        }
        //脂肪肝
        if(self.isSelect1g==1){
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"肝功13项"];
            [self.mutaArrs addObject:@"肝纤维化四项"];
        }
    
    
    
    
    if (self.isMen==1) {
        //高血压
        if(self.isSelect2b==1){
            [self.mutaArrs addObject:@"血流变（男）"  ];
            [self.mutaArrs addObject:@"血脂四项"  ];
        }
        //冠心病
        if(self.isSelect2c==1){
            [self.mutaArrs addObject:@"血流变（男）"];
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"肌钙蛋白1"];
            [self.mutaArrs addObject:@"超敏C反应蛋白"];
            [self.mutaArrs addObject:@"同型半胱氨酸"];
            [self.mutaArrs addObject:@"脂蛋白相关磷脂酶A2测定"];
        }
        //脑中风
        if(self.isSelect2d==1){
            [self.mutaArrs addObject:@"血流变（男）"];
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"脑流血（TCD）"];
            [self.mutaArrs addObject:@"动脉血管硬度测定"];
            [self.mutaArrs addObject:@"颅脑CT"];
        }
    }else{
        //高血压
        if(self.isSelect2b==1){
            [self.mutaArrs addObject:@"血流变（女）"  ];
            [self.mutaArrs addObject:@"血脂四项"  ];
        }
        //冠心病
        if(self.isSelect2c==1){
            [self.mutaArrs addObject:@"血流变（女）"];
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"肌钙蛋白1"];
            [self.mutaArrs addObject:@"超敏C反应蛋白"];
            [self.mutaArrs addObject:@"同型半胱氨酸"];
            [self.mutaArrs addObject:@"脂蛋白相关磷脂酶A2测定"];
        }
        //脑中风
        if(self.isSelect2d==1){
            [self.mutaArrs addObject:@"血流变（女）"];
            [self.mutaArrs addObject:@"血脂六项"];
            [self.mutaArrs addObject:@"脑流血（TCD）"];
            [self.mutaArrs addObject:@"动脉血管硬度测定"];
            [self.mutaArrs addObject:@"颅脑CT"];
        }
        
        
    }
    //糖尿病
    if(self.isSelect2e==1){
        [self.mutaArrs addObject:@"糖化血红蛋白"];
        [self.mutaArrs addObject:@"葡萄糖耐量试验"];
    }
    //肿瘤
    if(self.isSelect2f==1){
        [self.mutaArrs addObject:@"癌胚抗原（定量）"];
        [self.mutaArrs addObject:@"甲胎蛋白（定量）"];
        [self.mutaArrs addObject:@"特异性肿瘤因子"];
        [self.mutaArrs addObject:@"糖类抗原CA50"];
    }
}
-(void)deleteRepeat{
    //[self deleteRepeat];
    NSSet *set = [NSSet setWithArray:self.mutaArrs];
    self.endmutaArrs= [NSMutableArray arrayWithArray:[set allObjects]];
    
    NSString *str1=@"血脂二项";
    NSString *str2=@"血脂四项";
    NSString *str3=@"血脂六项";
    if([self.endmutaArrs containsObject:str1]){
        if ([self.endmutaArrs containsObject:str2]) {
            [self.endmutaArrs removeObject:str1];
        }
    }
    if([self.endmutaArrs containsObject:str2]){
        if ([self.endmutaArrs containsObject:str3]) {
            [self.endmutaArrs removeObject:str2];
        }
    }
    if([self.endmutaArrs containsObject:str1]){
        if ([self.endmutaArrs containsObject:str3]) {
            [self.endmutaArrs removeObject:str1];
        }
    }
    NSString *str4=@"肝功5项";
    NSString *str5=@"肝功10项";
    NSString *str6=@"肝功13项";
    if([self.endmutaArrs containsObject:str4]){
        if ([self.endmutaArrs containsObject:str5]) {
            [self.endmutaArrs removeObject:str4];
        }
    }
    if([self.endmutaArrs containsObject:str4]){
        if ([self.endmutaArrs containsObject:str6]) {
            [self.endmutaArrs removeObject:str4];
        }
    }
    if([self.endmutaArrs containsObject:str5]){
        if ([self.endmutaArrs containsObject:str6]) {
            [self.endmutaArrs removeObject:str5];
        }
    }
    NSString *str7=@"男性盆腔彩超";
    NSString *str8=@"女性盆腔彩超";
    NSString *str9=@"盆腔CT";
    if([self.endmutaArrs containsObject:str8]){
        if ([self.endmutaArrs containsObject:str9]) {
            [self.endmutaArrs removeObject:str8];
        }
    }
    if([self.endmutaArrs containsObject:str7]){
        if ([self.endmutaArrs containsObject:str9]) {
            [self.endmutaArrs removeObject:str7];
        }
    }
    
    NSString *str10=@"胃蛋白酶原";
    NSString *str11=@"胃功能四项";
    NSString *str12=@"上消化道造影";
    if([self.endmutaArrs containsObject:str10]){
        if ([self.endmutaArrs containsObject:str11]) {
            [self.endmutaArrs removeObject:str10];
        }
    }
    if([self.endmutaArrs containsObject:str11]){
        if ([self.endmutaArrs containsObject:str12]) {
            [self.endmutaArrs removeObject:str11];
        }
    }
    if([self.endmutaArrs containsObject:str10]){
        if ([self.endmutaArrs containsObject:str12]) {
            [self.endmutaArrs removeObject:str10];
        }
    }
    NSString *str13=@"DR胸部正位检查";
    NSString *str14=@"DR胸部正侧位检查";
    NSString *str15=@"DR胸部正侧位摄片";
    if([self.endmutaArrs containsObject:str13]){
        if ([self.endmutaArrs containsObject:str14]) {
            [self.endmutaArrs removeObject:str13];
        }
    }
    if([self.endmutaArrs containsObject:str14]){
        if ([self.endmutaArrs containsObject:str15]) {
            [self.endmutaArrs removeObject:str14];
        }
    }
    if([self.endmutaArrs containsObject:str13]){
        if ([self.endmutaArrs containsObject:str15]) {
            [self.endmutaArrs removeObject:str13];
        }
    }
    NSString *str16=@"DR颈椎正位检查";
    NSString *str17=@"DR颈椎侧双斜三位检查";
    NSString *str18=@"DR颈椎正侧位摄片";
    NSString *str19=@"DR颈椎侧双斜三位摄片";
    if([self.endmutaArrs containsObject:str16]){
        if ([self.endmutaArrs containsObject:str17]) {
            [self.endmutaArrs removeObject:str16];
        }
    }
    if([self.endmutaArrs containsObject:str16]){
        if ([self.endmutaArrs containsObject:str18]) {
            [self.endmutaArrs removeObject:str16];
        }
    }
    if([self.endmutaArrs containsObject:str16]){
        if ([self.endmutaArrs containsObject:str19]) {
            [self.endmutaArrs removeObject:str16];
        }
    }
    if([self.endmutaArrs containsObject:str17]){
        if ([self.endmutaArrs containsObject:str18]) {
            [self.endmutaArrs removeObject:str17];
        }
    }
    if([self.endmutaArrs containsObject:str17]){
        if ([self.endmutaArrs containsObject:str19]) {
            [self.endmutaArrs removeObject:str17];
        }
    }
    
    if([self.endmutaArrs containsObject:str18]){
        if ([self.endmutaArrs containsObject:str19]) {
            [self.endmutaArrs removeObject:str18];
        }
    }
    NSString *str20=@"肾功能3项";
    NSString *str21=@"肾功能4项";
    if([self.endmutaArrs containsObject:str20]){
        if ([self.endmutaArrs containsObject:str21]) {
            [self.endmutaArrs removeObject:str20];
        }
    }
    NSString *str22=@"过敏体质检测";
    NSString *str23=@"过敏原特异性抗体14项";
    if([self.endmutaArrs containsObject:str22]){
        if ([self.endmutaArrs containsObject:str23]) {
            [self.endmutaArrs removeObject:str22];
        }
    }
    NSString *str24=@"幽门螺杆菌抗体（定量）";
    NSString *str25=@"幽门螺杆菌抗原检测";
    if([self.endmutaArrs containsObject:str24]){
        if ([self.endmutaArrs containsObject:str25]) {
            [self.endmutaArrs removeObject:str24];
        }
    }
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
