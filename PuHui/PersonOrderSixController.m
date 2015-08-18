//
//  PersonOrderSixController.m
//  PuHui
//
//  Created by rp.wang on 15/7/24.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonOrderSixController.h"
#import "BBRim.h"
#import "TestResultController.h"

@interface PersonOrderSixController ()
@property (strong, nonatomic) IBOutlet UIButton *submmitBtn;
@property (strong, nonatomic) IBOutlet UIImageView *con21a;
@property (strong, nonatomic) IBOutlet UIImageView *con21b;
@property (strong, nonatomic) IBOutlet UIImageView *con22a;
@property (strong, nonatomic) IBOutlet UIImageView *con22b;
@property (strong, nonatomic) IBOutlet UIImageView *con23a;
@property (strong, nonatomic) IBOutlet UIImageView *con23b;
@property (strong, nonatomic) IBOutlet UIImageView *con24a;
@property (strong, nonatomic) IBOutlet UIImageView *con24b;
@property (strong, nonatomic) IBOutlet UIImageView *con25a;
@property (strong, nonatomic) IBOutlet UIImageView *con25b;
@property (strong, nonatomic) IBOutlet UIImageView *con26a;
@property (strong, nonatomic) IBOutlet UIImageView *con26b;
@property (strong, nonatomic) IBOutlet UIImageView *con27a;
@property (strong, nonatomic) IBOutlet UIImageView *con27b;

//是否选中 0：否   1：是
@property (assign,nonatomic) int  isSelect21a;
@property (assign,nonatomic) int  isSelect21b;

@property (assign,nonatomic) int  isSelect22a;
@property (assign,nonatomic) int  isSelect22b;

@property (assign,nonatomic) int  isSelect23a;
@property (assign,nonatomic) int  isSelect23b;

@property (assign,nonatomic) int  isSelect24a;
@property (assign,nonatomic) int  isSelect24b;

@property (assign,nonatomic) int  isSelect25a;
@property (assign,nonatomic) int  isSelect25b;

@property (assign,nonatomic) int  isSelect26a;
@property (assign,nonatomic) int  isSelect26b;

@property (assign,nonatomic) int  isSelect27a;
@property (assign,nonatomic) int  isSelect27b;
@property (strong, nonatomic)  NSMutableArray *endmutaArrs;
@property (strong, nonatomic) IBOutlet UILabel *sele21;
@property (strong, nonatomic) IBOutlet UILabel *sele22;
@property (strong, nonatomic) IBOutlet UILabel *sele23;
@property (strong, nonatomic) IBOutlet UILabel *sele24;
@property (strong, nonatomic) IBOutlet UILabel *sele25;
@property (strong, nonatomic) IBOutlet UILabel *sele26;
@property (strong, nonatomic) IBOutlet UILabel *sele27;


@end

@implementation PersonOrderSixController
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
    BBRim *rim=[[BBRim alloc]init];
    [self.submmitBtn setBackgroundColor:[UIColor orangeColor]];
    [self.submmitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rim bb_rimWithView:self.submmitBtn radius:6 width:1 color:[UIColor clearColor]];
    
    self.sele21.textColor=[UIColor orangeColor];
    self.sele22.textColor=[UIColor orangeColor];
    self.sele23.textColor=[UIColor orangeColor];
    self.sele24.textColor=[UIColor orangeColor];
    self.sele25.textColor=[UIColor orangeColor];
    self.sele26.textColor=[UIColor orangeColor];
    self.sele27.textColor=[UIColor orangeColor];
    [self setTap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submmitTap:(id)sender {
//        UIStoryboard  *personModelSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
//        TestResultController *personOrderTwoController=[personModelSB instantiateViewControllerWithIdentifier:@"TestResultController"];
//        personOrderTwoController.hidesBottomBarWhenPushed=YES;
//    
//    [self getMeals];
//    [self deleteRepeat];
//       
//    personOrderTwoController.mutaArrs=self.endmutaArrs;
//    personOrderTwoController.isMen=self.isMen;
//    personOrderTwoController.ageRang=self.ageRang;
//    personOrderTwoController.isSex=self.isSex;
//
//    [self.navigationController pushViewController:personOrderTwoController animated:YES];
    
    
    
    
    
    
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

-(void)setTap{
    
    self.con21a.userInteractionEnabled=YES;
    self.con21b.userInteractionEnabled=YES;
    
    self.con22a.userInteractionEnabled=YES;
    self.con22b.userInteractionEnabled=YES;
    
    self.con23a.userInteractionEnabled=YES;
    self.con23b.userInteractionEnabled=YES;
    
    self.con24a.userInteractionEnabled=YES;
    self.con24b.userInteractionEnabled=YES;
    
    self.con25a.userInteractionEnabled=YES;
    self.con25b.userInteractionEnabled=YES;
    
    self.con26a.userInteractionEnabled=YES;
    self.con26b.userInteractionEnabled=YES;
    
    self.con27a.userInteractionEnabled=YES;
    self.con27b.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *con21aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con21aTap)];
    UITapGestureRecognizer *con21bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con21bTap)];
    
    
    
    UITapGestureRecognizer *con22aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con22aTap)];
    UITapGestureRecognizer *con22bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con22bTap)];
    
    
    UITapGestureRecognizer *con23aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con23aTap)];
    UITapGestureRecognizer *con23bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con23bTap)];
    
    
    UITapGestureRecognizer *con24aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con24aTap)];
    UITapGestureRecognizer *con24bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con24bTap)];
    
    
    UITapGestureRecognizer *con26aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con26aTap)];
    UITapGestureRecognizer *con26bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con26bTap)];
    
    
    UITapGestureRecognizer *con27aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con27aTap)];
    UITapGestureRecognizer *con27bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con27bTap)];
    
    
    UITapGestureRecognizer *con25aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con25aTap)];
    UITapGestureRecognizer *con25bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con25bTap)];
    
    [self.con21a addGestureRecognizer:con21aGes];
    [self.con21b addGestureRecognizer:con21bGes];
    
    [self.con22a addGestureRecognizer:con22aGes];
    [self.con22b addGestureRecognizer:con22bGes];
    
    [self.con23a addGestureRecognizer:con23aGes];
    [self.con23b addGestureRecognizer:con23bGes];
    
    [self.con24a addGestureRecognizer:con24aGes];
    [self.con24b addGestureRecognizer:con24bGes];
    
    [self.con25a addGestureRecognizer:con25aGes];
    [self.con25b addGestureRecognizer:con25bGes];

    [self.con26a addGestureRecognizer:con26aGes];
    [self.con26b addGestureRecognizer:con26bGes];
    
    [self.con27a addGestureRecognizer:con27aGes];
    [self.con27b addGestureRecognizer:con27bGes];

}
-(void)con21aTap{
    self.con21a.image=[UIImage imageNamed:@"personselected"];
    self.con21b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect21a=1;
    self.isSelect21b=0;
}

-(void)con21bTap{
    self.con21b.image=[UIImage imageNamed:@"personselected"];
    self.con21a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect21b=1;
    self.isSelect21a=0;
}

-(void)con22aTap{
    self.con22a.image=[UIImage imageNamed:@"personselected"];
    self.con22b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect22a=1;
    self.isSelect22b=0;
}

-(void)con22bTap{
    self.con22b.image=[UIImage imageNamed:@"personselected"];
    self.con22a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect22b=1;
    self.isSelect22a=0;
}
-(void)con23aTap{
    self.con23a.image=[UIImage imageNamed:@"personselected"];
    self.con23b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect23a=1;
    self.isSelect23b=0;
}

-(void)con23bTap{
    self.con23b.image=[UIImage imageNamed:@"personselected"];
    self.con23a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect23b=1;
    self.isSelect23a=0;
}

-(void)con24aTap{
    self.con24a.image=[UIImage imageNamed:@"personselected"];
    self.con24b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect24a=1;
    self.isSelect24b=0;
}

-(void)con24bTap{
    self.con24b.image=[UIImage imageNamed:@"personselected"];
    self.con24a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect24b=1;
    self.isSelect24a=0;
}

-(void)con25aTap{
    self.con25a.image=[UIImage imageNamed:@"personselected"];
    self.con25b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect25a=1;
    self.isSelect25b=0;
}

-(void)con25bTap{
    self.con25b.image=[UIImage imageNamed:@"personselected"];
    self.con25a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect25b=1;
    self.isSelect25a=0;
}
-(void)con26aTap{
    self.con26a.image=[UIImage imageNamed:@"personselected"];
    self.con26b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect26a=1;
    self.isSelect26b=0;
}

-(void)con26bTap{
    self.con26b.image=[UIImage imageNamed:@"personselected"];
    self.con21a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect26b=1;
    self.isSelect26a=0;
}

-(void)con27aTap{
    self.con27a.image=[UIImage imageNamed:@"personselected"];
    self.con27b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect27a=1;
    self.isSelect27b=0;
}

-(void)con27bTap{
    self.con27b.image=[UIImage imageNamed:@"personselected"];
    self.con27a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect27b=1;
    self.isSelect27a=0;
}

-(void)getMeals{
    if(self.isSelect21b==1){
        [self.mutaArrs addObjectsFromArray:@[@"糖化血清蛋白",@"葡萄糖耐量试验"]];
    }
    if(self.isSelect22b==1){
        [self.mutaArrs addObjectsFromArray:@[@"肾功能4项",@"心肌酶谱五项",@"超敏C反应蛋白"]];
    }
    if(self.isSelect23b==1){
        [self.mutaArrs addObjectsFromArray:@[@"心肌酶谱",@"超敏C反应蛋白"]];
    }
    if(self.isSelect24b==1){
        [self.mutaArrs addObjectsFromArray:@[@"甲状腺彩超",@"甲状腺功能7项"]];
    }
    if(self.isSelect25b==1){
        [self.mutaArrs addObjectsFromArray:@[@"乙肝五项",@"甲肝抗体",@"丙肝抗体",@"戊肝抗体"]];
    }
    if(self.isSelect26b==1){
        [self.mutaArrs addObjectsFromArray:@[@"DR颈椎侧双斜三位摄片"]];
    }
    if(self.isSelect27b==1){
        [self.mutaArrs addObjectsFromArray:@[@"DR腰椎正侧位摄片"]];
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
