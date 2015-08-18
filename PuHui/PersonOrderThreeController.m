//
//  PersonOrderThreeController.m
//  PuHui
//
//  Created by rp.wang on 15/7/23.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "PersonOrderThreeController.h"
#import "BBRim.h"
#import "PersonOrderFourController.h"
#import "TestResultController.h"

@interface PersonOrderThreeController ()


@property (assign,nonatomic) int  is;

@property (strong, nonatomic) IBOutlet UIButton *submmitBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIImageView *con3a;
@property (strong, nonatomic) IBOutlet UIImageView *con3b;
@property (strong, nonatomic) IBOutlet UIImageView *con3c;

@property (strong, nonatomic) IBOutlet UIImageView *con4a;
@property (strong, nonatomic) IBOutlet UIImageView *con4b;
@property (strong, nonatomic) IBOutlet UIImageView *con4c;

@property (strong, nonatomic) IBOutlet UIImageView *con5a;
@property (strong, nonatomic) IBOutlet UIImageView *con5b;
@property (strong, nonatomic) IBOutlet UIImageView *con5c;

@property (strong, nonatomic) IBOutlet UIImageView *con6a;
@property (strong, nonatomic) IBOutlet UIImageView *con6b;
@property (strong, nonatomic) IBOutlet UIImageView *con6c;
@property (strong, nonatomic) IBOutlet UIImageView *con6d;
@property (strong, nonatomic) IBOutlet UIImageView *con6e;

@property (strong, nonatomic) IBOutlet UIImageView *con7a;
@property (strong, nonatomic) IBOutlet UIImageView *con7b;
@property (strong, nonatomic) IBOutlet UIImageView *con7c;

@property (strong, nonatomic) IBOutlet UIImageView *con8a;
@property (strong, nonatomic) IBOutlet UIImageView *con8b;
@property (strong, nonatomic) IBOutlet UIImageView *con8c;

@property (strong, nonatomic) IBOutlet UIImageView *con9a;
@property (strong, nonatomic) IBOutlet UIImageView *con9b;
@property (strong, nonatomic) IBOutlet UIImageView *con9c;


@property (strong, nonatomic) IBOutlet UILabel *it3a;
@property (strong, nonatomic) IBOutlet UILabel *it3b;
@property (strong, nonatomic) IBOutlet UILabel *it3c;
@property (strong, nonatomic) IBOutlet UILabel *it4a;
@property (strong, nonatomic) IBOutlet UILabel *it4b;
@property (strong, nonatomic) IBOutlet UILabel *it4c;
@property (strong, nonatomic) IBOutlet UILabel *it5a;
@property (strong, nonatomic) IBOutlet UILabel *it5b;
@property (strong, nonatomic) IBOutlet UILabel *it5c;
@property (strong, nonatomic) IBOutlet UILabel *it6a;
@property (strong, nonatomic) IBOutlet UILabel *it6b;
@property (strong, nonatomic) IBOutlet UILabel *it6c;
@property (strong, nonatomic) IBOutlet UILabel *it6d;
@property (strong, nonatomic) IBOutlet UILabel *it6e;
@property (strong, nonatomic) IBOutlet UILabel *it7a;
@property (strong, nonatomic) IBOutlet UILabel *it7b;
@property (strong, nonatomic) IBOutlet UILabel *it7c;
@property (strong, nonatomic) IBOutlet UILabel *it8a;
@property (strong, nonatomic) IBOutlet UILabel *it8b;
@property (strong, nonatomic) IBOutlet UILabel *it8c;
@property (strong, nonatomic) IBOutlet UILabel *it9a;
@property (strong, nonatomic) IBOutlet UILabel *it9b;
@property (strong, nonatomic) IBOutlet UILabel *it9c;



//是否选中 0：否   1：是
@property (assign,nonatomic) int  isSelect3a;
@property (assign,nonatomic) int  isSelect3b;
@property (assign,nonatomic) int  isSelect3c;

@property (assign,nonatomic) int  isSelect4a;
@property (assign,nonatomic) int  isSelect4b;
@property (assign,nonatomic) int  isSelect4c;

@property (assign,nonatomic) int  isSelect5a;
@property (assign,nonatomic) int  isSelect5b;
@property (assign,nonatomic) int  isSelect5c;

@property (assign,nonatomic) int  isSelect6a;
@property (assign,nonatomic) int  isSelect6b;
@property (assign,nonatomic) int  isSelect6c;
@property (assign,nonatomic) int  isSelect6d;
@property (assign,nonatomic) int  isSelect6e;


@property (assign,nonatomic) int  isSelect7a;
@property (assign,nonatomic) int  isSelect7b;
@property (assign,nonatomic) int  isSelect7c;

@property (assign,nonatomic) int  isSelect8a;
@property (assign,nonatomic) int  isSelect8b;
@property (assign,nonatomic) int  isSelect8c;

@property (assign,nonatomic) int  isSelect9a;
@property (assign,nonatomic) int  isSelect9b;
@property (assign,nonatomic) int  isSelect9c;
@property (strong, nonatomic)  NSMutableArray *endmutaArrs;
@property (strong, nonatomic) IBOutlet UILabel *sele3;
@property (strong, nonatomic) IBOutlet UILabel *sele4;
@property (strong, nonatomic) IBOutlet UILabel *sele5;
@property (strong, nonatomic) IBOutlet UILabel *sele6;
@property (strong, nonatomic) IBOutlet UILabel *sele7;
@property (strong, nonatomic) IBOutlet UILabel *sele8;
@property (strong, nonatomic) IBOutlet UILabel *sele9;


@end

@implementation PersonOrderThreeController
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
    
    self.sele3.textColor=[UIColor orangeColor];
    self.sele4.textColor=[UIColor orangeColor];
    self.sele8.textColor=[UIColor orangeColor];
    self.sele5.textColor=[UIColor orangeColor];
    self.sele6.textColor=[UIColor orangeColor];
    self.sele7.textColor=[UIColor orangeColor];
    self.sele9.textColor=[UIColor orangeColor];
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
    PersonOrderFourController *personOrderFourController=[personModelSB instantiateViewControllerWithIdentifier:@"PersonOrderFourController"];
    personOrderFourController.hidesBottomBarWhenPushed=YES;
    
    [self getMeals];
    [self deleteRepeat];
    
    personOrderFourController.mutaArrs=self.endmutaArrs;
    personOrderFourController.isMen=self.isMen;
    personOrderFourController.ageRang=self.ageRang;
    personOrderFourController.isSex=self.isSex;
    [self.navigationController pushViewController:personOrderFourController animated:YES];
}
-(void)setTap{
    self.con3a.userInteractionEnabled=YES;
    self.con3b.userInteractionEnabled=YES;
    self.con3c.userInteractionEnabled=YES;
    
    
    self.con4a.userInteractionEnabled=YES;
    self.con4b.userInteractionEnabled=YES;
    self.con4c.userInteractionEnabled=YES;
    
    self.con5a.userInteractionEnabled=YES;
    self.con5b.userInteractionEnabled=YES;
    self.con5c.userInteractionEnabled=YES;
    
    self.con6a.userInteractionEnabled=YES;
    self.con6b.userInteractionEnabled=YES;
    self.con6c.userInteractionEnabled=YES;
    self.con6d.userInteractionEnabled=YES;
    self.con6e.userInteractionEnabled=YES;
    
    self.con7a.userInteractionEnabled=YES;
    self.con7b.userInteractionEnabled=YES;
    self.con7c.userInteractionEnabled=YES;
    
    self.con8a.userInteractionEnabled=YES;
    self.con8b.userInteractionEnabled=YES;
    self.con8c.userInteractionEnabled=YES;
    
    self.con9a.userInteractionEnabled=YES;
    self.con9b.userInteractionEnabled=YES;
    self.con9c.userInteractionEnabled=YES;
    
    self.it3a.userInteractionEnabled=YES;
    self.it3b.userInteractionEnabled=YES;
    self.it3c.userInteractionEnabled=YES;
    
    
    self.it4a.userInteractionEnabled=YES;
    self.it4b.userInteractionEnabled=YES;
    self.it4c.userInteractionEnabled=YES;
    
    self.it5a.userInteractionEnabled=YES;
    self.it5b.userInteractionEnabled=YES;
    self.it5c.userInteractionEnabled=YES;
    
    self.it6a.userInteractionEnabled=YES;
    self.it6b.userInteractionEnabled=YES;
    self.it6c.userInteractionEnabled=YES;
    self.it6d.userInteractionEnabled=YES;
    self.it6e.userInteractionEnabled=YES;
    
    self.it7a.userInteractionEnabled=YES;
    self.it7b.userInteractionEnabled=YES;
    self.it7c.userInteractionEnabled=YES;
    
    self.it8a.userInteractionEnabled=YES;
    self.it8b.userInteractionEnabled=YES;
    self.it8c.userInteractionEnabled=YES;
    
    self.it9a.userInteractionEnabled=YES;
    self.it9b.userInteractionEnabled=YES;
    self.it9c.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *con3aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con3aTap)];
    UITapGestureRecognizer *con3bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con3bTap)];
    UITapGestureRecognizer *con3cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con3cTap)];
    
    
    UITapGestureRecognizer *con4aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con4aTap)];
    UITapGestureRecognizer *con4bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con4bTap)];
    UITapGestureRecognizer *con4cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con4cTap)];
    
    
    UITapGestureRecognizer *con5aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con5aTap)];
    UITapGestureRecognizer *con5bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con5bTap)];
    UITapGestureRecognizer *con5cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con5cTap)];
    
    
    UITapGestureRecognizer *con6aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con6aTap)];
    UITapGestureRecognizer *con6bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con6bTap)];
    UITapGestureRecognizer *con6cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con6cTap)];
    UITapGestureRecognizer *con6dGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con6dTap)];
    UITapGestureRecognizer *con6eGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con6eTap)];
    
    
    
    UITapGestureRecognizer *con7aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con7aTap)];
    UITapGestureRecognizer *con7bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con7bTap)];
    UITapGestureRecognizer *con7cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con7cTap)];
    
    
    UITapGestureRecognizer *con8aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con8aTap)];
    UITapGestureRecognizer *con8bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con8bTap)];
    UITapGestureRecognizer *con8cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con8cTap)];
    
    
    UITapGestureRecognizer *con9aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con9aTap)];
    UITapGestureRecognizer *con9bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con9bTap)];
    UITapGestureRecognizer *con9cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(con9cTap)];
    
    
    
    
    
    
    UITapGestureRecognizer *it3aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it3aTap)];
    UITapGestureRecognizer *it3bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it3bTap)];
    UITapGestureRecognizer *it3cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it3cTap)];
    
    
    UITapGestureRecognizer *it4aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it4aTap)];
    UITapGestureRecognizer *it4bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it4bTap)];
    UITapGestureRecognizer *it4cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it4cTap)];
    
    
    UITapGestureRecognizer *it5aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it5aTap)];
    UITapGestureRecognizer *it5bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it5bTap)];
    UITapGestureRecognizer *it5cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it5cTap)];
    
    
    UITapGestureRecognizer *it6aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it6aTap)];
    UITapGestureRecognizer *it6bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it6bTap)];
    UITapGestureRecognizer *it6cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it6cTap)];
    UITapGestureRecognizer *it6dGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it6dTap)];
    UITapGestureRecognizer *it6eGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it6eTap)];
    
    
    
    UITapGestureRecognizer *it7aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it7aTap)];
    UITapGestureRecognizer *it7bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it7bTap)];
    UITapGestureRecognizer *it7cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it7cTap)];
    
    
    UITapGestureRecognizer *it8aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it8aTap)];
    UITapGestureRecognizer *it8bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it8bTap)];
    UITapGestureRecognizer *it8cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it8cTap)];
    
    
    UITapGestureRecognizer *it9aGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it9aTap)];
    UITapGestureRecognizer *it9bGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it9bTap)];
    UITapGestureRecognizer *it9cGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(it9cTap)];
    
    [self.con3a addGestureRecognizer:con3aGes];
    [self.con3b addGestureRecognizer:con3bGes];
    [self.con3c addGestureRecognizer:con3cGes];
    
    [self.con4a addGestureRecognizer:con4aGes];
    [self.con4b addGestureRecognizer:con4bGes];
    [self.con4c addGestureRecognizer:con4cGes];
    
    [self.con5a addGestureRecognizer:con5aGes];
    [self.con5b addGestureRecognizer:con5bGes];
    [self.con5c addGestureRecognizer:con5cGes];
    
    [self.con6a addGestureRecognizer:con6aGes];
    [self.con6b addGestureRecognizer:con6bGes];
    [self.con6c addGestureRecognizer:con6cGes];
    [self.con6d addGestureRecognizer:con6dGes];
    [self.con6e addGestureRecognizer:con6eGes];
    
    [self.con7a addGestureRecognizer:con7aGes];
    [self.con7b addGestureRecognizer:con7bGes];
    [self.con7c addGestureRecognizer:con7cGes];
    
    [self.con8a addGestureRecognizer:con8aGes];
    [self.con8b addGestureRecognizer:con8bGes];
    [self.con8c addGestureRecognizer:con8cGes];
    
    [self.con9a addGestureRecognizer:con9aGes];
    [self.con9b addGestureRecognizer:con9bGes];
    [self.con9c addGestureRecognizer:con9cGes];
}
-(void)con3aTap{
    self.con3a.image=[UIImage imageNamed:@"personselected"];
    self.con3b.image=[UIImage imageNamed:@"personnotselected"];
    self.con3c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect3a=1;
    self.isSelect3b=0;
    self.isSelect3c=0;
}

-(void)con3bTap{
    self.con3b.image=[UIImage imageNamed:@"personselected"];
    self.con3a.image=[UIImage imageNamed:@"personnotselected"];
    self.con3c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect3b=1;
    self.isSelect3a=0;
    self.isSelect3c=0;
}

-(void)con3cTap{
    self.con3c.image=[UIImage imageNamed:@"personselected"];
    self.con3a.image=[UIImage imageNamed:@"personnotselected"];
    self.con3b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect3c=1;
    self.isSelect3b=0;
    self.isSelect3a=0;
}

-(void)con4aTap{
    if (self.isSelect4a==0) {
        self.con4a.image=[UIImage imageNamed:@"personselected"];
        self.isSelect4a=1;
        return;
    }
    if (self.isSelect4a==1) {
        self.con4a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect4a=0;
        return;
    }
}

-(void)con4bTap{
    if (self.isSelect4b==0) {
        self.con4b.image=[UIImage imageNamed:@"personselected"];
        self.isSelect4b=1;
        return;
    }
    if (self.isSelect4b==1) {
        self.con4b.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect4b=0;
        return;
    }
}


-(void)con4cTap{
    if (self.isSelect4c==0) {
        self.con4c.image=[UIImage imageNamed:@"personselected"];
        self.isSelect4c=1;
        return;
    }
    if (self.isSelect4c==1) {
        self.con4c.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect4c=0;
        return;
    }
}

-(void)con5aTap{
    self.con5a.image=[UIImage imageNamed:@"personselected"];
    self.con5b.image=[UIImage imageNamed:@"personnotselected"];
    self.con5c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect5a=1;
    self.isSelect5b=0;
    self.isSelect5c=0;
}

-(void)con5bTap{
    self.con5b.image=[UIImage imageNamed:@"personselected"];
    self.con5a.image=[UIImage imageNamed:@"personnotselected"];
    self.con5c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect5b=1;
    self.isSelect5a=0;
    self.isSelect5c=0;
}

-(void)con5cTap{
    self.con5c.image=[UIImage imageNamed:@"personselected"];
    self.con5a.image=[UIImage imageNamed:@"personnotselected"];
    self.con5b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect5c=1;
    self.isSelect5b=0;
    self.isSelect5a=0;
}

-(void)con6aTap{
    self.con6a.image=[UIImage imageNamed:@"personselected"];
    self.con6b.image=[UIImage imageNamed:@"personnotselected"];
    self.con6c.image=[UIImage imageNamed:@"personnotselected"];
    self.con6d.image=[UIImage imageNamed:@"personnotselected"];
    self.con6e.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect6a=1;
    self.isSelect6b=0;
    self.isSelect6c=0;
    self.isSelect6d=0;
    self.isSelect6e=0;
}

-(void)con6bTap{
    self.con6b.image=[UIImage imageNamed:@"personselected"];
    self.con6a.image=[UIImage imageNamed:@"personnotselected"];
    self.con6c.image=[UIImage imageNamed:@"personnotselected"];
    self.con6d.image=[UIImage imageNamed:@"personnotselected"];
    self.con6e.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect6b=1;
    self.isSelect6a=0;
    self.isSelect6c=0;
    self.isSelect6d=0;
    self.isSelect6e=0;
}

-(void)con6cTap{
    self.con6c.image=[UIImage imageNamed:@"personselected"];
    self.con6a.image=[UIImage imageNamed:@"personnotselected"];
    self.con6b.image=[UIImage imageNamed:@"personnotselected"];
    self.con6d.image=[UIImage imageNamed:@"personnotselected"];
    self.con6e.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect6c=1;
    self.isSelect6b=0;
    self.isSelect6a=0;
    self.isSelect6d=0;
    self.isSelect6e=0;
}

-(void)con6dTap{
    self.con6d.image=[UIImage imageNamed:@"personselected"];
    self.con6a.image=[UIImage imageNamed:@"personnotselected"];
    self.con6b.image=[UIImage imageNamed:@"personnotselected"];
    self.con6c.image=[UIImage imageNamed:@"personnotselected"];
    self.con6e.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect6d=1;
    self.isSelect6b=0;
    self.isSelect6a=0;
    self.isSelect6c=0;
    self.isSelect6e=0;
}

-(void)con6eTap{
    self.con6e.image=[UIImage imageNamed:@"personselected"];
    self.con6a.image=[UIImage imageNamed:@"personnotselected"];
    self.con6b.image=[UIImage imageNamed:@"personnotselected"];
    self.con6d.image=[UIImage imageNamed:@"personnotselected"];
    self.con6c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect6e=1;
    self.isSelect6b=0;
    self.isSelect6a=0;
    self.isSelect6d=0;
    self.isSelect6c=0;
}
-(void)con7aTap{
    self.con7a.image=[UIImage imageNamed:@"personselected"];
    self.con7b.image=[UIImage imageNamed:@"personnotselected"];
    self.con7c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect7a=1;
    self.isSelect7b=0;
    self.isSelect7c=0;
}

-(void)con7bTap{
    self.con7b.image=[UIImage imageNamed:@"personselected"];
    self.con7a.image=[UIImage imageNamed:@"personnotselected"];
    self.con7c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect7b=1;
    self.isSelect7a=0;
    self.isSelect7c=0;
}

-(void)con7cTap{
    self.con7c.image=[UIImage imageNamed:@"personselected"];
    self.con7a.image=[UIImage imageNamed:@"personnotselected"];
    self.con7b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect7c=1;
    self.isSelect7b=0;
    self.isSelect7a=0;
}

-(void)con8aTap{
    self.con8a.image=[UIImage imageNamed:@"personselected"];
    self.con8b.image=[UIImage imageNamed:@"personnotselected"];
    self.con8c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect8a=1;
    self.isSelect8b=0;
    self.isSelect8c=0;
}

-(void)con8bTap{
    self.con8b.image=[UIImage imageNamed:@"personselected"];
    self.con8a.image=[UIImage imageNamed:@"personnotselected"];
    self.con8c.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect8b=1;
    self.isSelect8a=0;
    self.isSelect8c=0;
}

-(void)con8cTap{
    self.con8c.image=[UIImage imageNamed:@"personselected"];
    self.con8a.image=[UIImage imageNamed:@"personnotselected"];
    self.con8b.image=[UIImage imageNamed:@"personnotselected"];
    self.isSelect8c=1;
    self.isSelect8b=0;
    self.isSelect8a=0;
}


-(void)con9aTap{
    if (self.isSelect9a==0) {
        self.con9a.image=[UIImage imageNamed:@"personselected"];
        self.isSelect9a=1;
        return;
    }
    if (self.isSelect9a==1) {
        self.con9a.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect9a=0;
        return;
    }
}

-(void)con9bTap{
    if (self.isSelect9b==0) {
        self.con9b.image=[UIImage imageNamed:@"personselected"];
        self.isSelect9b=1;
        return;
    }
    if (self.isSelect9b==1) {
        self.con9b.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect9b=0;
        return;
    }
}


-(void)con9cTap{
    if (self.isSelect9c==0) {
        self.con9c.image=[UIImage imageNamed:@"personselected"];
        self.isSelect9c=1;
        return;
    }
    if (self.isSelect9c==1) {
        self.con9c.image=[UIImage imageNamed:@"personnotselected"];
        self.isSelect9c=0;
        return;
    }
}

-(void)getMeals{
    //休息时间
        if(self.isSelect3a==1){
            [self.mutaArrs addObjectsFromArray:@[@"同型半胱氨酸",@"超敏C反应蛋白",@"糖化血红蛋白",@"血脂四项",@"甲状腺系列（7项）"]];
        }
    
        if(self.isSelect3b==1){
            if (self.ageRang!=3)
            {
              [self.mutaArrs addObjectsFromArray:@[@"同型半胱氨酸",@"糖化血红蛋白",@"血脂四项"]];
            }
            
        }
    
    //夜间睡眠质量
    
    if(self.isSelect4b==1){
        [self.mutaArrs addObjectsFromArray:@[@"DR颈椎正侧位检查",@"脑血流（TCD）"]];
    }
    
    if(self.isSelect4c==1){
            [self.mutaArrs addObjectsFromArray:@[@"肾功能4项",@"甲状腺系列（7项）",@"心脏彩超"]];
    }
    //xiyanshi
    if(self.isSelect5b==1){
        if (self.isMen==1)
        {
            [self.mutaArrs addObjectsFromArray:@[@"DR胸部正侧位检查",@"肺功能",@"血流变（男）"]];
        }else{
            [self.mutaArrs addObjectsFromArray:@[@"DR胸部正侧位检查",@"肺功能",@"血流变（女）"]];
        }
        
    }
    if(self.isSelect5c==1){
        if (self.isMen==1)
        {
            [self.mutaArrs addObjectsFromArray:@[@"DR胸部正侧位检查",@"肺功能",@"血流变（男）",@"骨密度",@"糖化血红蛋白",@"神经元特异性烯化醇酶（NSE）",@"EB病毒"]];
        }else{
            [self.mutaArrs addObjectsFromArray:@[@"DR胸部正侧位检查",@"肺功能",@"血流变（女）",@"骨密度",@"糖化血红蛋白",@"神经元特异性烯化醇酶（NSE）",@"EB病毒"]];
        }
        
    }
    //饮酒史
    if(self.isSelect6b==1){
            [self.mutaArrs addObjectsFromArray:@[@"肝功10项"]];
    }
    if(self.isSelect6c==1){
            [self.mutaArrs addObjectsFromArray:@[@"肝功13项",@"肾功能3项"]];
    }
    if(self.isSelect6d==1){
        [self.mutaArrs addObjectsFromArray:@[@"肝功10项",@"胃蛋白酶原"]];
    }
    if(self.isSelect6e==1){
        [self.mutaArrs addObjectsFromArray:@[@"肝功13项",@"肾功能4项",@"胃功能四项",@"甲胎蛋白",@"糖蛋白抗原CA50",@"糖类抗原CA-242",@"超敏C反应蛋白"]];
    }
    //duanlian
    if(self.isSelect7b==1){
        [self.mutaArrs addObjectsFromArray:@[@"血脂四项",@"骨密度"]];
    }
    if(self.isSelect7a==1){
        [self.mutaArrs addObjectsFromArray:@[@"免疫功能三项",@"血脂四项",@"骨密度",@"肺功能",@"同型半胱氨酸",@"糖化血红蛋白"]];
        
    }
    //饮食情况
    if(self.isSelect8b==1){
        [self.mutaArrs addObjectsFromArray:@[@"胃蛋白酶原",@"幽门螺杆菌抗体"]];
    }
    if(self.isSelect8c==1){
        [self.mutaArrs addObjectsFromArray:@[@"胃功能四项",@"幽门螺杆菌抗体（定量）",@"骨密度",@"糖类抗原CA199",@"糖类抗原CA242"]];
        
    }
    //口味偏好
    if(self.isSelect9c==1){
        [self.mutaArrs addObjectsFromArray:@[@"糖化血红蛋白"]];
    }
    if(self.isSelect9b==1){
        [self.mutaArrs addObjectsFromArray:@[@"骨密度",@"动脉血管硬度检测"]];
    }
    if(self.isSelect9c==1){
        [self.mutaArrs addObjectsFromArray:@[@"胃功能四项"]];
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
