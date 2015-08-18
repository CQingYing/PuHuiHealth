//
//  SelectMealController.m
//  PuHui
//
//  Created by rp.wang on 15/7/13.
//  Copyright (c) 2015年 Lq. All rights reserved.
//  创建者：朱贝贝
//  修改者：朱贝贝

#import "SelectMealController.h"
#import "SelectMealCell.h"
#import "BBRim.h"
#import "SelectAreaController.h"
#import "MBProgressHUD.h"

@interface SelectMealController ()
@property (strong, nonatomic) IBOutlet UITableView *selectTabView;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIButton *spinSele;
@property (strong, nonatomic)  UITableView *spinnerTabView;
@property (strong, nonatomic)  NSArray *spinContentAry;
@property (strong, nonatomic) IBOutlet UIView *mealView;
@property (strong, nonatomic) IBOutlet UIScrollView *mealScr;
@property (strong, nonatomic)  MBProgressHUD *HUD;
@property (assign,nonatomic)int temp;
@property (strong, nonatomic)  UIButton *leftBtn;

@property (strong, nonatomic) IBOutlet UILabel *consLab;
@property (strong, nonatomic) IBOutlet UILabel *conmLab;
@property (strong, nonatomic) IBOutlet UITextField *nameTxtImg;
@property (strong, nonatomic) IBOutlet UITextField *sexTxtImg;

//nameTxtImg  sexTxtImg
@end

@implementation SelectMealController
//懒加载
- (UITableView *)spinnerTabView
{
    if (!_spinnerTabView) {
        _spinnerTabView= [[UITableView alloc] init];
        _spinnerTabView.frame = CGRectMake(119,215+50, 90, 75);
    }
    return _spinnerTabView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"团体预约";
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];
    //设置tableView属性
    self.selectTabView.rowHeight=102;
    //self.selectTabView.scrollEnabled=NO;
    self.selectTabView.separatorStyle=UITableViewCellSeparatorStyleNone;
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.selectTabView radius:8 width:1 color:[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:0.2]];
    //设置nextBtn属性
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nextBtn.backgroundColor=[UIColor orangeColor];
    [rim bb_rimWithView:self.nextBtn radius:4 width:1 color:[UIColor clearColor]];
    //设置spinSele属性
    self.spinSele.backgroundColor=[UIColor whiteColor];
    [rim bb_rimWithView:self.spinSele radius:1 width:1 color:[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:0.2]];
    [self.spinSele setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -125)];
    [self.spinSele setTitleEdgeInsets:UIEdgeInsetsMake(0, -26, 0, 0)];
    //设置下拉内容tableView属性
    self.spinnerTabView.userInteractionEnabled=YES;
    self.spinnerTabView.delegate=self;
    self.spinnerTabView.dataSource=self;
    self.spinnerTabView.rowHeight=25;
    [self.spinnerTabView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.spinContentAry=@[@"男性套餐",@"女性套餐",@"所有套餐"];
    [rim bb_rimWithView:self.spinnerTabView radius:1 width:1 color:[UIColor colorWithRed:230/255 green:230/255 blue:230/255 alpha:0.2]];
    
    
    self.consLab.text=self.contractName;
    self.conmLab.text=self.groupName;
    self.nameTxtImg.text=self.userName;
    self.sexTxtImg.text=self.userPhone;
    
    
}
-(void)leftTap{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextTap:(id)sender {
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    SelectAreaController *selectAreaController=[sb instantiateViewControllerWithIdentifier:@"SelectAreaController"];
    //nameTxtImg  sexTxtImg
    selectAreaController.contractName=self.contractName;
    selectAreaController.groupName=self.groupName;
    selectAreaController.userName=self.nameTxtImg.text;
    selectAreaController.userPhone=self.sexTxtImg.text;
    selectAreaController.codesCon=self.codesCon;
    
    [self.navigationController pushViewController:selectAreaController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(tableView==self.selectTabView){
        return 1;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(tableView==self.selectTabView){
        return 4;
    }else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==self.selectTabView)
    {
      static NSString *ID=@"Cell";
      SelectMealCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
      if (cell==nil)
      {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectMealCell" owner:nil options:nil]lastObject];
      }
      return cell;
    }else
    {
        static NSString *ID=@"Cell";
        UITableViewCell *cell = [self.spinnerTabView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        cell.textLabel.text=self.spinContentAry[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.selectTabView)
    {
    }else
    {
        self.temp=0;
        UITableViewCell *cell = [self.spinnerTabView cellForRowAtIndexPath:indexPath];
        [self.spinSele setTitle:cell.textLabel.text forState:UIControlStateNormal];
        [self.spinnerTabView removeFromSuperview];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{   self.temp=0;
    [self.spinnerTabView removeFromSuperview];
}

- (IBAction)seectMealTap:(id)sender {
    
    if (self.temp==0) {
        [self.spinnerTabView reloadData];
        self.mealView.clipsToBounds=NO;
        [self.mealScr insertSubview:self.spinnerTabView atIndex:[[self.mealScr subviews] count]];
        self.temp=1;
        return;
    }
    if(self.temp==1){
        [self.spinnerTabView removeFromSuperview];
        self.temp=0;
        return;
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
