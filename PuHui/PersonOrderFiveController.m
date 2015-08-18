//
//  PersonOrderFiveController.m
//  PuHui
//
//  Created by rp.wang on 15/7/24.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonOrderFiveController.h"
#import "BBRim.h"
#import "PersonOrderSixController.h"
#import "TestResultController.h"

@interface PersonOrderFiveController ()

@property (strong, nonatomic) IBOutlet UIButton *submmitBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIImageView *con15a;
@property (strong, nonatomic) IBOutlet UIImageView *con15b;
@property (strong, nonatomic) IBOutlet UIImageView *con16a;
@property (strong, nonatomic) IBOutlet UIImageView *con16b;
@property (strong, nonatomic) IBOutlet UIImageView *con16c;
@property (strong, nonatomic) IBOutlet UIImageView *con17a;
@property (strong, nonatomic) IBOutlet UIImageView *con17b;
@property (strong, nonatomic) IBOutlet UIImageView *con17c;
@property (strong, nonatomic) IBOutlet UIImageView *con18a;
@property (strong, nonatomic) IBOutlet UIImageView *con18b;
@property (strong, nonatomic) IBOutlet UIImageView *con18c;
@property (strong, nonatomic) IBOutlet UIImageView *con19a;
@property (strong, nonatomic) IBOutlet UIImageView *con19b;
@property (strong, nonatomic) IBOutlet UIImageView *con19c;
@property (strong, nonatomic) IBOutlet UIImageView *con20a;
@property (strong, nonatomic) IBOutlet UIImageView *con20b;
@property (strong, nonatomic) IBOutlet UIImageView *con20c;


//是否选中 0：否   1：是
@property (assign,nonatomic) int  isSelect15a;
@property (assign,nonatomic) int  isSelect15b;

@property (assign,nonatomic) int  isSelect16a;
@property (assign,nonatomic) int  isSelect16b;
@property (assign,nonatomic) int  isSelect16c;

@property (assign,nonatomic) int  isSelect17a;
@property (assign,nonatomic) int  isSelect17b;
@property (assign,nonatomic) int  isSelect17c;

@property (assign,nonatomic) int  isSelect18a;
@property (assign,nonatomic) int  isSelect18b;
@property (assign,nonatomic) int  isSelect18c;

@property (assign,nonatomic) int  isSelect19a;
@property (assign,nonatomic) int  isSelect19b;
@property (assign,nonatomic) int  isSelect19c;

@property (assign,nonatomic) int  isSelect20a;
@property (assign,nonatomic) int  isSelect20b;
@property (assign,nonatomic) int  isSelect20c;

@property (strong, nonatomic)  NSMutableArray *endmutaArrs;
@property (strong, nonatomic) IBOutlet UILabel *sele15;
@property (strong, nonatomic) IBOutlet UILabel *sele16;
@property (strong, nonatomic) IBOutlet UILabel *sele17;
@property (strong, nonatomic) IBOutlet UILabel *sele18;
@property (strong, nonatomic) IBOutlet UILabel *sele19;
@property (strong, nonatomic) IBOutlet UILabel *sele20;


@end

@implementation PersonOrderFiveController
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
    
    self.sele15.textColor=[UIColor orangeColor];
    self.sele16.textColor=[UIColor orangeColor];
    self.sele17.textColor=[UIColor orangeColor];
    self.sele18.textColor=[UIColor orangeColor];
    self.sele19.textColor=[UIColor orangeColor];
    self.sele20.textColor=[UIColor orangeColor];
    [self setTap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)nextTap:(id)sender {
    UIStoryboard  *personModelSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    PersonOrderSixController *personOrderTwoController=[personModelSB instantiateViewControllerWithIdentifier:@"PersonOrderSixController"];
    personOrderTwoController.hidesBottomBarWhenPushed=YES;
    
    [self getMeals];
    [self deleteRepeat];
            
    personOrderTwoController.mutaArrs=self.endmutaArrs;
    personOrderTwoController.isMen=self.isMen;
    personOrderTwoController.ageRang=self.ageRang;
    personOrderTwoController.isSex=self.isSex;
    
    [self.navigationController pushViewController:personOrderTwoController animated:YES];
}

-(void)setTap{
    self.con15a.userInteractionEnabled=YES;
    self.con15b.userInteractionEnabled=YES;
    
    
    self.con16a.userInteractionEnabled=YES;
    self.con16b.userInteractionEnabled=YES;
    self.con16c.userInteractionEnabled=YES;
    
    self.con17a.userInteractionEnabled=YES;
    self.con17b.userInteractionEnabled=YES;
    self.con17c.userInteractionEnabled=YES;
    
    self.con18a.userInteractionEnabled=YES;
    self.con18b.userInteractionEnabled=YES;
    self.con18c.userInteractionEnabled=YES;
    
    self.con19a.userInteractionEnabled=YES;
    self.con19b.userInteractionEnabled=YES;
    self.con19c.userInteractionEnabled=YES;
    
    self.con20a.userInteractionEnabled=YES;
    self.con20b.userInteractionEnabled=YES;
    self.con20c.userInteractionEnabled=YES;
    
    
    UITapGestureRecognizer *con15aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con15aTap)];
    UITapGestureRecognizer *con15bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con15bTap)];
    
    
    UITapGestureRecognizer *con16aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con16aTap)];
    UITapGestureRecognizer *con16bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con16bTap)];
    UITapGestureRecognizer *con16cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con16cTap)];
    
    
    UITapGestureRecognizer *con17aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con17aTap)];
    UITapGestureRecognizer *con17bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con17bTap)];
    UITapGestureRecognizer *con17cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con17cTap)];
    
    
    UITapGestureRecognizer *con18aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con18aTap)];
    UITapGestureRecognizer *con18bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con18bTap)];
    UITapGestureRecognizer *con18cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con18cTap)];
    
    
    UITapGestureRecognizer *con19aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con19aTap)];
    UITapGestureRecognizer *con19bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con19bTap)];
    UITapGestureRecognizer *con19cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con19cTap)];
    
    
    
    UITapGestureRecognizer *con20aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con20aTap)];
    UITapGestureRecognizer *con20bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con20bTap)];
    UITapGestureRecognizer *con20cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con20cTap)];
    
    
    
    [self.con15a addGestureRecognizer:con15aGes];
    [self.con15b addGestureRecognizer:con15bGes];
    
    [self.con16a addGestureRecognizer:con16aGes];
    [self.con16b addGestureRecognizer:con16bGes];
    [self.con16c addGestureRecognizer:con16cGes];
    
    [self.con17a addGestureRecognizer:con17aGes];
    [self.con17b addGestureRecognizer:con17bGes];
    [self.con17c addGestureRecognizer:con17cGes];
    
    [self.con18a addGestureRecognizer:con18aGes];
    [self.con18b addGestureRecognizer:con18bGes];
    [self.con18c addGestureRecognizer:con18cGes];
    
    [self.con19a addGestureRecognizer:con19aGes];
    [self.con19b addGestureRecognizer:con19bGes];
    [self.con19c addGestureRecognizer:con19cGes];
    
    [self.con20a addGestureRecognizer:con20aGes];
    [self.con20b addGestureRecognizer:con20bGes];
    [self.con20c addGestureRecognizer:con20cGes];
    
}

-(void)con15aTap{
    self.con15a.image=[UIImage imageNamed:@"personselected"];
    self.con15b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect15a=1;
    self.isSelect15b=0;
}

-(void)con15bTap{
    self.con15b.image=[UIImage imageNamed:@"personselected"];
    self.con15a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect15b=1;
    self.isSelect15a=0;
}



-(void)con16aTap{
    self.con16a.image=[UIImage imageNamed:@"personselected"];
    self.con16b.image=[UIImage imageNamed:@"personnotselected"];
    self.con16c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect16a=1;
    self.isSelect16b=0;
    self.isSelect16c=0;
}

-(void)con16bTap{
    self.con16b.image=[UIImage imageNamed:@"personselected"];
    self.con16a.image=[UIImage imageNamed:@"personnotselected"];
    self.con16c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect16b=1;
    self.isSelect16a=0;
    self.isSelect16c=0;
}

-(void)con16cTap{
    self.con16c.image=[UIImage imageNamed:@"personselected"];
    self.con16b.image=[UIImage imageNamed:@"personnotselected"];
    self.con16a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect16c=1;
    self.isSelect16b=0;
    self.isSelect16a=0;
}

-(void)con17aTap{
    self.con17a.image=[UIImage imageNamed:@"personselected"];
    self.con17b.image=[UIImage imageNamed:@"personnotselected"];
    self.con17c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect17a=1;
    self.isSelect17b=0;
    self.isSelect17c=0;
}

-(void)con17bTap{
    self.con17b.image=[UIImage imageNamed:@"personselected"];
    self.con17a.image=[UIImage imageNamed:@"personnotselected"];
    self.con17c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect17b=1;
    self.isSelect17a=0;
    self.isSelect17c=0;
}

-(void)con17cTap{
    self.con17c.image=[UIImage imageNamed:@"personselected"];
    self.con17b.image=[UIImage imageNamed:@"personnotselected"];
    self.con17a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect17c=1;
    self.isSelect17b=0;
    self.isSelect17a=0;
}

-(void)con18aTap{
    self.con18a.image=[UIImage imageNamed:@"personselected"];
    self.con18b.image=[UIImage imageNamed:@"personnotselected"];
    self.con18c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect18a=1;
    self.isSelect18b=0;
    self.isSelect18c=0;
}

-(void)con18bTap{
    self.con18b.image=[UIImage imageNamed:@"personselected"];
    self.con18a.image=[UIImage imageNamed:@"personnotselected"];
    self.con18c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect18b=1;
    self.isSelect18a=0;
    self.isSelect18c=0;
}

-(void)con18cTap{
    self.con18c.image=[UIImage imageNamed:@"personselected"];
    self.con18b.image=[UIImage imageNamed:@"personnotselected"];
    self.con18a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect18c=1;
    self.isSelect18b=0;
    self.isSelect18a=0;
}

-(void)con19aTap{
    self.con19a.image=[UIImage imageNamed:@"personselected"];
    self.con19b.image=[UIImage imageNamed:@"personnotselected"];
    self.con19c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect19a=1;
    self.isSelect19b=0;
    self.isSelect19c=0;
}

-(void)con19bTap{
    self.con19b.image=[UIImage imageNamed:@"personselected"];
    self.con19a.image=[UIImage imageNamed:@"personnotselected"];
    self.con19c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect19b=1;
    self.isSelect19b=0;
    self.isSelect19c=0;
}

-(void)con19cTap{
    self.con19c.image=[UIImage imageNamed:@"personselected"];
    self.con19b.image=[UIImage imageNamed:@"personnotselected"];
    self.con19a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect19c=1;
    self.isSelect19b=0;
    self.isSelect19a=0;
}

-(void)con20aTap{
    self.con20a.image=[UIImage imageNamed:@"personselected"];
    self.con20b.image=[UIImage imageNamed:@"personnotselected"];
    self.con20c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect20a=1;
    self.isSelect20b=0;
    self.isSelect20c=0;
}

-(void)con20bTap{
    self.con20b.image=[UIImage imageNamed:@"personselected"];
    self.con20a.image=[UIImage imageNamed:@"personnotselected"];
    self.con20c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect20b=1;
    self.isSelect20a=0;
    self.isSelect20c=0;
}

-(void)con20cTap{
    self.con20c.image=[UIImage imageNamed:@"personselected"];
    self.con20b.image=[UIImage imageNamed:@"personnotselected"];
    self.con20a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect20c=1;
    self.isSelect20b=0;
    self.isSelect20a=0;
}


-(void)getMeals{
    //15、鼻子-20
    if(self.isSelect15b==1){
        [self.mutaArrs addObjectsFromArray:@[@"过敏原特异性抗体14项"]];
    }
    //舌头
    if(self.isSelect16b==1){
        [self.mutaArrs addObjectsFromArray:@[@"脑血流（TCD）",@"同型半胱氨酸"]];
    }if(self.isSelect16c==1){
        [self.mutaArrs addObjectsFromArray:@[@"脑血流（TCD）",@"颅脑CT"]];
    }
    //消化系统
    if(self.isSelect17b==1){
        [self.mutaArrs addObjectsFromArray:@[@"胃蛋白酶原检测"]];
    }if(self.isSelect17c==1){
        [self.mutaArrs addObjectsFromArray:@[@"胃功能四项",@"幽门螺杆菌抗体",@"便常规",@"便潜血",@"糖类抗原CA50",@"糖类抗原CA242"]];
    }
    //xin zang
    if(self.isSelect18b==1){
        [self.mutaArrs addObjectsFromArray:@[@"心肌酶谱五项"]];
    }if(self.isSelect18c==1){
        [self.mutaArrs addObjectsFromArray:@[@"心肌酶谱五项",@"肌钙蛋白1",@"同型半胱氨酸",@"超敏C反应蛋白"]];
    }
    //头
    if(self.isSelect19b==1){
        [self.mutaArrs addObjectsFromArray:@[@"动脉血管硬度检测定",@"脑血流（TCD）"]];
    }if(self.isSelect19c==1){
        if (self.isMen==1) {
            [self.mutaArrs addObjectsFromArray:@[@"DR颈椎正侧位摄片",@"血脂四项",@"血流变（男）",@"脑血流（TCD）"]];
        }else{
            [self.mutaArrs addObjectsFromArray:@[@"DR颈椎正侧位摄片",@"血脂四项",@"血流变（女）",@"脑血流（TCD）"]];
        }
        
    }
    //呼吸
    if(self.isSelect20b==1){
        [self.mutaArrs addObjectsFromArray:@[@"DR胸部正侧位检查"]];
    }if(self.isSelect20c==1){
        [self.mutaArrs addObjectsFromArray:@[@"DR胸部正侧位摄片",@"结核抗体",@"神经元特异性烯化醇酶（NSE）"]];
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
    
@end
