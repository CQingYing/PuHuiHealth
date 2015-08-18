//
//  PersonBaseInfoController.m
//  PuHui
//
//  Created by rp.wang on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonBaseInfoController.h"
#import "BBRim.h"
#import "PersonOrderTwoController.h"
#import "MBProgressHUD.h"



@interface PersonBaseInfoController ()
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIImageView *base1a;
@property (strong, nonatomic) IBOutlet UIImageView *base1b;
@property (strong, nonatomic) IBOutlet UIImageView *base2a;
@property (strong, nonatomic) IBOutlet UIImageView *base2b;
@property (strong, nonatomic) IBOutlet UIImageView *base2c;
@property (strong, nonatomic) IBOutlet UIImageView *base3a;
@property (strong, nonatomic) IBOutlet UIImageView *base3b;
@property (assign,nonatomic)  int temp1;
@property (assign,nonatomic)  int temp2;
@property (assign,nonatomic)  int temp3;
@property (strong, nonatomic)  NSMutableArray *mutaArrs;
@property (strong, nonatomic)  NSArray *str;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (strong, nonatomic) IBOutlet UILabel *sele1;
@property (strong, nonatomic) IBOutlet UILabel *sele2;
@property (strong, nonatomic) IBOutlet UILabel *sele3;
@property (strong, nonatomic) IBOutlet UILabel *item1a;
@property (strong, nonatomic) IBOutlet UILabel *item1b;
@property (strong, nonatomic) IBOutlet UILabel *item2a;
@property (strong, nonatomic) IBOutlet UILabel *item2b;
@property (strong, nonatomic) IBOutlet UILabel *item2c;
@property (strong, nonatomic) IBOutlet UILabel *item3a;
@property (strong, nonatomic) IBOutlet UILabel *item3b;

@end

@implementation PersonBaseInfoController
- (NSMutableArray *)mutaArrs
{
    if (!_mutaArrs) {
        _mutaArrs = [[NSMutableArray alloc] init];
    }
    return _mutaArrs;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   //设置基础属性
    [self setBase];
    //添加手势
    [self setTap];
    
}
- (IBAction)nextTap:(id)sender {
    UIStoryboard  *personModelSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    PersonOrderTwoController *personOrderTwoController=[personModelSB instantiateViewControllerWithIdentifier:@"PersonOrderTwoController"];
    personOrderTwoController.hidesBottomBarWhenPushed=YES;
    if (self.temp1!=1&&self.temp1!=2) {
        [self showAllTextDialog:@"请选择性别！"];
        return;
    }
    if (self.temp2!=1&&self.temp2!=2&&self.temp2!=3) {
        [self showAllTextDialog:@"请选择年龄！"];
        return;
    }
    if (self.temp3!=1&&self.temp3!=2) {
        [self showAllTextDialog:@"请选性生活史！"];
        return;
    }
    
    if (self.temp1==1) {
        personOrderTwoController.isMen=1;
        [self.mutaArrs addObject:@"外科（男）"];
    }else {
        personOrderTwoController.isMen=0;
        [self.mutaArrs addObject:@"外科（女）"];
    }
    
    if (self.temp2==1) {
        personOrderTwoController.ageRang=1;
    }else if (self.temp2==2){
        personOrderTwoController.ageRang=2;
        if(self.temp1==1){
            [self.mutaArrs addObjectsFromArray:@[@"幽门螺杆菌抗体",@"男性盆腔彩超",@"前列腺特异性抗原PSA"]];
        }else{
            [self.mutaArrs addObjectsFromArray:@[@"幽门螺杆菌抗体",@"女性盆腔彩超",@"乳腺彩超",@"癌抗原CA12-5卵巢",@"癌抗原"]];
        }
    }else{
        personOrderTwoController.ageRang=3;
        if(self.temp1==1){
            [self.mutaArrs addObjectsFromArray:@[@"幽门螺杆菌抗体",@"男性盆腔彩超",@"前列腺特异性抗原PSA",@"肛门指诊（男）",@"骨密度",@"肺功能",@"脑血流（TCD）",@"血流变（男）",@"DR颈椎正侧检查",@"甲胎蛋白",@"癌胚抗原",@"糖蛋白抗原CA50"]];
        }else{
            [self.mutaArrs addObjectsFromArray:@[@"幽门螺杆菌抗体",@"女性盆腔彩超",@"乳腺彩超",@"癌抗原CA12-5卵巢",@"癌抗原",@"肛门指诊（女）",@"骨密度",@"肺功能",@"脑血流（TCD）",@"血流变（女）",@"DR颈椎正侧检查",@"甲胎蛋白",@"癌胚抗原",@"糖蛋白抗原CA50",@"鳞状细胞癌抗原（SCC）"]];
        }
    }
    
    if (self.temp3==1) {
        personOrderTwoController.isSex=1;
        if (self.temp1==2) {
            [self.mutaArrs addObjectsFromArray:@[@"妇科检查",@"白带常规"]];
        }
        if (self.temp2==2) {
            [self.mutaArrs addObjectsFromArray:@[@"液基薄层细胞检查"]];
        }
    }else{
        personOrderTwoController.isSex=0;
    }
    personOrderTwoController.mutaArrs=self.mutaArrs;
    [self.navigationController pushViewController:personOrderTwoController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setBase{
    //设置按钮属性
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.nextBtn radius:6 width:1 color:[UIColor orangeColor]];
    [self.nextBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    self.sele1.textColor=[UIColor orangeColor];
    self.sele2.textColor=[UIColor orangeColor];
    self.sele3.textColor=[UIColor orangeColor];
    
    self.str=@[@"身高体重血压",@"内科",@"口腔科",@"眼科常规",@"腹部彩超",@"心电图",@"DR胸部",@"正位检查",@"血常规",@"尿常规",@"肝功5项",@"肾功能3项",@"血脂二项",@"空腹血糖"];
    
    self.mutaArrs=[NSMutableArray arrayWithArray:self.str];
}
-(void)setTap{
    self.base1a.userInteractionEnabled=YES;
    self.base1b.userInteractionEnabled=YES;
    self.base2a.userInteractionEnabled=YES;
    self.base2b.userInteractionEnabled=YES;
    self.base2c.userInteractionEnabled=YES;
    self.base3a.userInteractionEnabled=YES;
    self.base3b.userInteractionEnabled=YES;
    
    self.item1a.userInteractionEnabled=YES;
    self.item1b.userInteractionEnabled=YES;
    self.item2a.userInteractionEnabled=YES;
    self.item2b.userInteractionEnabled=YES;
    self.item2c.userInteractionEnabled=YES;
    self.item3a.userInteractionEnabled=YES;
    self.item3b.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *base1aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(base1aTap)];
    UITapGestureRecognizer *base1bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(base1bTap)];
    
    UITapGestureRecognizer *base2aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(base2aTap)];
    UITapGestureRecognizer *base2bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(base2bTap)];
    UITapGestureRecognizer *base2cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(base2cTap)];
    
    UITapGestureRecognizer *base3aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(base3aTap)];
    UITapGestureRecognizer *base3bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(base3bTap)];

    
    UITapGestureRecognizer *item1aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(item1aTap)];
    UITapGestureRecognizer *item1bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(item1bTap)];
    
    
    UITapGestureRecognizer *item2aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(item2aTap)];
    UITapGestureRecognizer *item2bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(item2bTap)];
    UITapGestureRecognizer *item2cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(item2cTap)];
    
    
    UITapGestureRecognizer *item3aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(item3aTap)];
    UITapGestureRecognizer *item3bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(item3bTap)];
    
    [self.base1a addGestureRecognizer:base1aGes];
    [self.base1b addGestureRecognizer:base1bGes];
    [self.base2a addGestureRecognizer:base2aGes];
    [self.base2b addGestureRecognizer:base2bGes];
    [self.base2c addGestureRecognizer:base2cGes];
    [self.base3a addGestureRecognizer:base3aGes];
    [self.base3b addGestureRecognizer:base3bGes];
    
    
    [self.item1a addGestureRecognizer:item1aGes];
    [self.item1b addGestureRecognizer:item1bGes];
    [self.item2a addGestureRecognizer:item2aGes];
    [self.item2b addGestureRecognizer:item2bGes];
    [self.item2c addGestureRecognizer:item2cGes];
    [self.item3a addGestureRecognizer:item3aGes];
    [self.item3b addGestureRecognizer:item3bGes];
}

    -(void)base1aTap{
        self.temp1=1;
        self.base1a.image=[UIImage imageNamed:@"personselected"];
        self.base1b.image=[UIImage imageNamed:@"personnotselected"];
    }
    -(void)base1bTap{
        
        self.temp1=2;
        self.base1b.image=[UIImage imageNamed:@"personselected"];
        self.base1a.image=[UIImage imageNamed:@"personnotselected"];
    }
    -(void)base2aTap{
        
        self.temp2=1;
        self.base2a.image=[UIImage imageNamed:@"personselected"];
        self.base2b.image=[UIImage imageNamed:@"personnotselected"];
        self.base2c.image=[UIImage imageNamed:@"personnotselected"];
    }
    -(void)base2bTap{
        
        self.temp2=2;
        self.base2b.image=[UIImage imageNamed:@"personselected"];
        self.base2a.image=[UIImage imageNamed:@"personnotselected"];
        self.base2c.image=[UIImage imageNamed:@"personnotselected"];
    }
    -(void)base2cTap{
        
        self.temp2=3;
        self.base2a.image=[UIImage imageNamed:@"personnotselected"];
        self.base2b.image=[UIImage imageNamed:@"personnotselected"];
        self.base2c.image=[UIImage imageNamed:@"personselected"];
    }
    -(void)base3aTap{
        
        self.temp3=1;
        self.base3a.image=[UIImage imageNamed:@"personselected"];
        self.base3b.image=[UIImage imageNamed:@"personnotselected"];
    }
    -(void)base3bTap{
        
        self.temp3=2;
        self.base3b.image=[UIImage imageNamed:@"personselected"];
        self.base3a.image=[UIImage imageNamed:@"personnotselected"];
    }


-(void)item1aTap{
    self.temp1=1;
    self.base1a.image=[UIImage imageNamed:@"personselected"];
    self.base1b.image=[UIImage imageNamed:@"personnotselected"];


}
-(void)item1bTap{
    self.temp1=2;
    self.base1b.image=[UIImage imageNamed:@"personselected"];
    self.base1a.image=[UIImage imageNamed:@"personnotselected"];

    
    
}
-(void)item2aTap{
    self.temp2=1;
    self.base2a.image=[UIImage imageNamed:@"personselected"];
    self.base2b.image=[UIImage imageNamed:@"personnotselected"];
    self.base2c.image=[UIImage imageNamed:@"personnotselected"];
    
    
}
-(void)item2bTap{
    self.temp2=2;
    self.base2b.image=[UIImage imageNamed:@"personselected"];
    self.base2a.image=[UIImage imageNamed:@"personnotselected"];
    self.base2c.image=[UIImage imageNamed:@"personnotselected"];
    
    
}
-(void)item2cTap{
    
    self.temp2=3;
    self.base2a.image=[UIImage imageNamed:@"personnotselected"];
    self.base2b.image=[UIImage imageNamed:@"personnotselected"];
    self.base2c.image=[UIImage imageNamed:@"personselected"];
    
}
-(void)item3aTap{
    
    self.temp3=1;
    self.base3a.image=[UIImage imageNamed:@"personselected"];
    self.base3b.image=[UIImage imageNamed:@"personnotselected"];
    
}
-(void)item3bTap{
    
    
    self.temp3=2;
    self.base3b.image=[UIImage imageNamed:@"personselected"];
    self.base3a.image=[UIImage imageNamed:@"personnotselected"];

    
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
