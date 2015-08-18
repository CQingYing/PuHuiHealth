//
//  OrderInforController.m
//  PuHui
//
//  Created by rp.wang on 15/7/10.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "OrderInforController.h"
#import "BBRim.h"
#import "SureOrderController.h"
#import "UIImageView+WebCache.h"

@interface OrderInforController ()
@property (strong, nonatomic) IBOutlet UIButton *sureInfor;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *mealInformLabel;
@property (strong, nonatomic) IBOutlet UILabel *mealProLabel;
@property (strong, nonatomic) IBOutlet UIImageView *picImgView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgConstra;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *infoConstra;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *proConstra;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *objConstra;
@property (strong, nonatomic)  UIButton *leftBtn;
@end

@implementation OrderInforController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.leftBtn setImage:[UIImage imageNamed:@"person_leftarr"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    
    //    [self.leftBtn setTitle:@"Back" forState:UIControlStateNormal];
    //    [self.leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBtn];

    self.navigationItem.title=self.mealTypeContent;
    self.sureInfor.backgroundColor=[UIColor orangeColor];
    [self.sureInfor setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    BBRim *rim=[[BBRim alloc]init];
    [rim bb_rimWithView:self.sureInfor radius:4 width:1 color:[UIColor clearColor]];
    [self.sureInfor addTarget:self action:@selector(sureTap)forControlEvents:UIControlEventTouchUpInside];

    self.imgConstra.constant=(self.view.frame.size.width-32)*105/252;
    //设置图片
    NSString *tempStr=[PHQDRequestUrl stringByAppendingString:self.infoPicContent];
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
    //设置使用对象
    self.ageLabel.text=self.ageTypeContent;
    CGRect fram = [self.ageTypeContent boundingRectWithSize:CGSizeMake(self.view.frame.size.width-56,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}context:nil];
    self.objConstra.constant=fram.size.height;
    //设置套餐介绍
    self.mealInformLabel.text=self.mealSimContent;
    CGRect frame = [self.mealSimContent boundingRectWithSize:CGSizeMake(self.view.frame.size.width-56,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}context:nil];
    self.infoConstra.constant=frame.size.height+10;
    //设置项目
    self.mealProLabel.text=self.mealInfoContent;
    CGRect frames = [self.mealInfoContent boundingRectWithSize:CGSizeMake(self.view.frame.size.width-56,1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}context:nil];
    self.proConstra.constant=frames.size.height+10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)sureTap
{
    //SureOrderController
    UIStoryboard *sureOrderSB=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    SureOrderController *sureOrderController=[sureOrderSB instantiateViewControllerWithIdentifier:@"SureOrderController"];
    sureOrderController.adContent=self.addrContent;
    sureOrderController.mealTyContent=self.mealTypeContent;
    sureOrderController.pagIDContent=self.pagIDContent;
    [self.navigationController pushViewController:sureOrderController animated:YES];
}
-(void)leftTap{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
