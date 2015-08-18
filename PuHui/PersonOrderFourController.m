//
//  PersonOrderFourController.m
//  PuHui
//
//  Created by rp.wang on 15/7/24.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonOrderFourController.h"
#import "PersonOrderFiveController.h"
#import "BBRim.h"
#import "TestResultController.h"

@interface PersonOrderFourController ()

@property (strong, nonatomic) IBOutlet UIButton *submmitBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIImageView *con10a;
@property (strong, nonatomic) IBOutlet UIImageView *con10b;
@property (strong, nonatomic) IBOutlet UIImageView *con10c;
@property (strong, nonatomic) IBOutlet UIImageView *con11a;
@property (strong, nonatomic) IBOutlet UIImageView *con11b;
@property (strong, nonatomic) IBOutlet UIImageView *con11c;
@property (strong, nonatomic) IBOutlet UIImageView *con12a;
@property (strong, nonatomic) IBOutlet UIImageView *con12b;
@property (strong, nonatomic) IBOutlet UIImageView *con12c;
@property (strong, nonatomic) IBOutlet UIImageView *con13a;
@property (strong, nonatomic) IBOutlet UIImageView *con13b;
@property (strong, nonatomic) IBOutlet UIImageView *con13c;
@property (strong, nonatomic) IBOutlet UIImageView *con14a;
@property (strong, nonatomic) IBOutlet UIImageView *con14b;
@property (strong, nonatomic) IBOutlet UIImageView *con14c;

//是否选中 0：否   1：是
@property (assign,nonatomic) int  isSelect10a;
@property (assign,nonatomic) int  isSelect10b;
@property (assign,nonatomic) int  isSelect10c;

@property (assign,nonatomic) int  isSelect11a;
@property (assign,nonatomic) int  isSelect11b;
@property (assign,nonatomic) int  isSelect11c;

@property (assign,nonatomic) int  isSelect12a;
@property (assign,nonatomic) int  isSelect12b;
@property (assign,nonatomic) int  isSelect12c;

@property (assign,nonatomic) int  isSelect13a;
@property (assign,nonatomic) int  isSelect13b;
@property (assign,nonatomic) int  isSelect13c;

@property (assign,nonatomic) int  isSelect14a;
@property (assign,nonatomic) int  isSelect14b;
@property (assign,nonatomic) int  isSelect14c;
@property (strong, nonatomic) IBOutlet UILabel *sele10;
@property (strong, nonatomic) IBOutlet UILabel *sele11;
@property (strong, nonatomic) IBOutlet UILabel *sele12;
@property (strong, nonatomic) IBOutlet UILabel *sele13;
@property (strong, nonatomic) IBOutlet UILabel *sele14;


@property (strong, nonatomic)  NSMutableArray *endmutaArrs;


@end

@implementation PersonOrderFourController
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
    
    self.sele10.textColor=[UIColor orangeColor];
    self.sele11.textColor=[UIColor orangeColor];
    self.sele12.textColor=[UIColor orangeColor];
    self.sele13.textColor=[UIColor orangeColor];
    self.sele14.textColor=[UIColor orangeColor];
    //设置手势
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
    PersonOrderFiveController *personOrderFiveController=[personModelSB instantiateViewControllerWithIdentifier:@"PersonOrderFiveController"];
    personOrderFiveController.hidesBottomBarWhenPushed=YES;
    
    [self getMeals];
    [self deleteRepeat];
    
       
    personOrderFiveController.mutaArrs=self.endmutaArrs;
    personOrderFiveController.isMen=self.isMen;
    personOrderFiveController.ageRang=self.ageRang;
    personOrderFiveController.isSex=self.isSex;
    
    [self.navigationController pushViewController:personOrderFiveController animated:YES];
}

-(void)setTap{
    self.con10a.userInteractionEnabled=YES;
    self.con10b.userInteractionEnabled=YES;
    self.con10c.userInteractionEnabled=YES;
    
    
    self.con11a.userInteractionEnabled=YES;
    self.con11b.userInteractionEnabled=YES;
    self.con11c.userInteractionEnabled=YES;
    
    self.con12a.userInteractionEnabled=YES;
    self.con12b.userInteractionEnabled=YES;
    self.con12c.userInteractionEnabled=YES;
    
    self.con13a.userInteractionEnabled=YES;
    self.con13b.userInteractionEnabled=YES;
    self.con13c.userInteractionEnabled=YES;
    
    self.con14a.userInteractionEnabled=YES;
    self.con14b.userInteractionEnabled=YES;
    self.con14c.userInteractionEnabled=YES;
    
    
    UITapGestureRecognizer *con10aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con10aTap)];
    UITapGestureRecognizer *con10bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con10bTap)];
    UITapGestureRecognizer *con10cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con10cTap)];
    
    
    UITapGestureRecognizer *con11aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con11aTap)];
    UITapGestureRecognizer *con11bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con11bTap)];
    UITapGestureRecognizer *con11cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con11cTap)];
    
    
    UITapGestureRecognizer *con12aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con12aTap)];
    UITapGestureRecognizer *con12bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con12bTap)];
    UITapGestureRecognizer *con12cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con12cTap)];
    
    
    UITapGestureRecognizer *con13aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con13aTap)];
    UITapGestureRecognizer *con13bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con13bTap)];
    UITapGestureRecognizer *con13cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con13cTap)];
    
    
    UITapGestureRecognizer *con14aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con14aTap)];
    UITapGestureRecognizer *con14bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con14bTap)];
    UITapGestureRecognizer *con14cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con14cTap)];
    
    
    [self.con10a addGestureRecognizer:con10aGes];
    [self.con10b addGestureRecognizer:con10bGes];
    [self.con10c addGestureRecognizer:con10cGes];
    
    [self.con11a addGestureRecognizer:con11aGes];
    [self.con11b addGestureRecognizer:con11bGes];
    [self.con11c addGestureRecognizer:con11cGes];
    
    [self.con12a addGestureRecognizer:con12aGes];
    [self.con12b addGestureRecognizer:con12bGes];
    [self.con12c addGestureRecognizer:con12cGes];
    
    [self.con13a addGestureRecognizer:con13aGes];
    [self.con13b addGestureRecognizer:con13bGes];
    [self.con13c addGestureRecognizer:con13cGes];
    
    [self.con14a addGestureRecognizer:con14aGes];
    [self.con14b addGestureRecognizer:con14bGes];
    [self.con14c addGestureRecognizer:con14cGes];
    
   
}
-(void)con10aTap{
    if (self.isSelect10a==0) {
        self.con10a.image=[UIImage imageNamed:@"personselected"];
        self.isSelect10a=1;
        return;
    }
    if (self.isSelect10a==1) {
        self.con10a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect10a=0;
        return;
    }
}

-(void)con10bTap{
    if (self.isSelect10b==0) {
        self.con10b.image=[UIImage imageNamed:@"personselected"];
        self.isSelect10b=1;
        return;
    }
    if (self.isSelect10b==1) {
        self.con10b.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect10b=0;
        return;
    }
}
-(void)con10cTap{
    if (self.isSelect10c==0) {
        self.con10c.image=[UIImage imageNamed:@"personselected"];
        self.isSelect10c=1;
        return;
    }
    if (self.isSelect10c==1) {
        self.con10c.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect10c=0;
        return;
    }
}


-(void)con11aTap{
    if (self.isSelect11a==0) {
        self.con11a.image=[UIImage imageNamed:@"personselected"];
        self.isSelect11a=1;
        return;
    }
    if (self.isSelect11a==1) {
        self.con11a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect11a=0;
        return;
    }
}

-(void)con11bTap{
    if (self.isSelect11b==0) {
        self.con11b.image=[UIImage imageNamed:@"personselected"];
        self.isSelect11b=1;
        return;
    }
    if (self.isSelect11b==1) {
        self.con11b.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect11b=0;
        return;
    }
}
-(void)con11cTap{
    if (self.isSelect11c==0) {
        self.con11c.image=[UIImage imageNamed:@"personselected"];
        self.isSelect11c=1;
        return;
    }
    if (self.isSelect11c==1) {
        self.con11c.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect11c=0;
        return;
    }
}

-(void)con12aTap{
    self.con12a.image=[UIImage imageNamed:@"personselected"];
    self.con12b.image=[UIImage imageNamed:@"personnotselected"];
    self.con12c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect12a=1;
    self.isSelect12b=0;
    self.isSelect12c=0;
}

-(void)con12bTap{
    self.con12b.image=[UIImage imageNamed:@"personselected"];
    self.con12a.image=[UIImage imageNamed:@"personnotselected"];
    self.con12c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect12b=1;
    self.isSelect12a=0;
    self.isSelect12c=0;
}

-(void)con12cTap{
    self.con12c.image=[UIImage imageNamed:@"personselected"];
    self.con12b.image=[UIImage imageNamed:@"personnotselected"];
    self.con12a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect12c=1;
    self.isSelect12b=0;
    self.isSelect12a=0;
}

-(void)con13aTap{
    self.con13a.image=[UIImage imageNamed:@"personselected"];
    self.con13b.image=[UIImage imageNamed:@"personnotselected"];
    self.con13c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect13a=1;
    self.isSelect13b=0;
    self.isSelect13c=0;
}

-(void)con13bTap{
    self.con13b.image=[UIImage imageNamed:@"personselected"];
    self.con13a.image=[UIImage imageNamed:@"personnotselected"];
    self.con13c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect13b=1;
    self.isSelect13a=0;
    self.isSelect13c=0;
}

-(void)con13cTap{
    self.con13c.image=[UIImage imageNamed:@"personselected"];
    self.con13b.image=[UIImage imageNamed:@"personnotselected"];
    self.con13a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect13c=1;
    self.isSelect13b=0;
    self.isSelect13a=0;
}

-(void)con14aTap{
    self.con14a.image=[UIImage imageNamed:@"personselected"];
    self.con14b.image=[UIImage imageNamed:@"personnotselected"];
    self.con14c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect14a=1;
    self.isSelect14b=0;
    self.isSelect14c=0;
}

-(void)con14bTap{
    self.con14b.image=[UIImage imageNamed:@"personselected"];
    self.con14a.image=[UIImage imageNamed:@"personnotselected"];
    self.con14c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect14b=1;
    self.isSelect14a=0;
    self.isSelect14c=0;
}

-(void)con14cTap{
    self.con14c.image=[UIImage imageNamed:@"personselected"];
    self.con14b.image=[UIImage imageNamed:@"personnotselected"];
    self.con14a.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect14c=1;
    self.isSelect14b=0;
    self.isSelect14a=0;
}

-(void)getMeals{
    //10、大便情况
    if(self.isSelect10c==1){
        if (self.isMen==1) {
            [self.mutaArrs addObjectsFromArray:@[@"肛门指诊（男）",@"便常规",@"便潜血",@"糖蛋白抗原CA50",@"糖类抗原CA242"]];
        }else{
         [self.mutaArrs addObjectsFromArray:@[@"肛门指诊（女）",@"便常规",@"便潜血",@"糖蛋白抗原CA50",@"糖类抗原CA242"]];
        }
    }
    
    if(self.isSelect10b==1){
        if (self.isMen!=1)
        {
            [self.mutaArrs addObjectsFromArray:@[@"肛门指诊（男）",@"便常规",@"便潜血"]];
        }else{
           [self.mutaArrs addObjectsFromArray:@[@"肛门指诊（女）",@"便常规",@"便潜血"]];
        }
        
    }
    
    //11、小便情况
    if(self.isSelect11c==1){
            [self.mutaArrs addObjectsFromArray:@[@"盆腔CT"]];
    }
    
    if(self.isSelect11b==1){
        if (self.isMen!=1)
        {
            [self.mutaArrs addObjectsFromArray:@[@"男性盆腔彩超",@"肾功能4项"]];
        }else{
            [self.mutaArrs addObjectsFromArray:@[@"女性盆腔彩超",@"肾功能4项"]];
        }
        
    }
    
    //12、眼睛
    if(self.isSelect12b==1){
        [self.mutaArrs addObjectsFromArray:@[@"眼底检查"]];
    }
    if(self.isSelect12c==1){
        [self.mutaArrs addObjectsFromArray:@[@"眼底检查",@"眼裂隙灯检查",@"眼压"]];
    }
    //13、er
    if(self.isSelect13b==1){
        [self.mutaArrs addObjectsFromArray:@[@"脑血流（TCD）"]];
    }
    if(self.isSelect13c==1){
        if (self.isMen==1) {
             [self.mutaArrs addObjectsFromArray:@[@"脑血流（TCD）",@"血流变（男）"]];
        }else{
             [self.mutaArrs addObjectsFromArray:@[@"脑血流（TCD）",@"血流变（女）"]];
        }
       
    }
    //14、口腔
    if(self.isSelect14b==1){
        [self.mutaArrs addObjectsFromArray:@[@"幽门螺杆菌抗体（定量）"]];
    }
    if(self.isSelect14c==1){
        [self.mutaArrs addObjectsFromArray:@[@"幽门螺杆菌抗体（定量）",@"胃蛋白酶原检测",@"糖蛋白抗原CA50",@"糖类抗原CA242"]];
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
