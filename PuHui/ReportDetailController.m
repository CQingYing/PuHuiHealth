//
//  ReportDetailController.m
//  PuHui
//
//  Created by rp.wang on 15/7/22.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "ReportDetailController.h"
#import "BBRim.h"
#import "BaseInfoModel.h"
#import "MBProgressHUD.h"
#import "QuestionsController.h"
#import "PhoneAskController.h"

@interface ReportDetailController ()

@property (strong, nonatomic)  UIScrollView *scroll;
@property (strong, nonatomic)  BBRim   *rim;
@property (assign,nonatomic)   CGFloat viewHei;
@property (strong, nonatomic)  UILabel *nameLab;
@property (strong, nonatomic)  UILabel *nameConLab;
@property (strong, nonatomic)  UILabel *sexLab;
@property (strong, nonatomic)  UILabel *sexConLab;
@property (strong, nonatomic)  UILabel *ageLab;
@property (strong, nonatomic)  UILabel *ageConLab;
@property (strong, nonatomic)  UILabel *dateLab;
@property (strong, nonatomic)  UILabel *dateConLab;
@property (strong, nonatomic)  UILabel *phoneLab;
@property (strong, nonatomic)  UILabel *phoneConLab;
@property (strong, nonatomic)  UILabel *mealLab;
@property (strong, nonatomic)  UILabel *mealConLab;
@property (strong, nonatomic)  UILabel *companyLab;
@property (strong, nonatomic)  UILabel *companyConLab;
@property (strong, nonatomic)  MBProgressHUD *HUD;

@property (strong, nonatomic)  UIView  *annlisyView;
@property (strong, nonatomic)  UILabel *annlisySumLab;
@property (strong, nonatomic)  UILabel *personNaLab;
@property (strong, nonatomic)  UILabel *reconLab;
@property (strong, nonatomic)  UILabel *signLab;

//5列表格大小宽度（身高体重血压）
@property (assign,nonatomic)   CGFloat fiveFirstWid;
@property (assign,nonatomic)   CGFloat fiveOtherWid;
@property (assign,nonatomic)   CGFloat fiveLastWid;


@property (assign,nonatomic)   CGFloat five1Wid;
@property (assign,nonatomic)   CGFloat five2Wid;
@property (assign,nonatomic)   CGFloat five3Wid;
@property (assign,nonatomic)   CGFloat five4Wid;
@property (assign,nonatomic)   CGFloat five5Wid;

@property (assign,nonatomic)   CGFloat fiveBoWid;

//3列表格大小宽度（身高体重血压）
@property (assign,nonatomic)   CGFloat threeFirstWid;
@property (assign,nonatomic)   CGFloat threeCenterWid;
@property (assign,nonatomic)   CGFloat threeLastWid;

@property (assign,nonatomic)   CGFloat three1Wid;
@property (assign,nonatomic)   CGFloat three2Wid;
@property (assign,nonatomic)   CGFloat three3Wid;

@property (assign,nonatomic)   CGFloat threeBoWid;

//设置表头

@property (assign,nonatomic)   CGFloat headWid;





@property (strong, nonatomic)  UILabel *bodyLab;
@property (strong, nonatomic)  UILabel *resultLab;
@property (strong, nonatomic)  UILabel *unitLab;
@property (strong, nonatomic)  UILabel *bodyProLab;
@property (strong, nonatomic)  UILabel *descriptionLab;
@property (strong, nonatomic)  UILabel *normalValueLab;
@property (strong, nonatomic)  UILabel *heibodyProLab;
@property (strong, nonatomic)  UILabel *heiresultLab;
@property (strong, nonatomic)  UILabel *heiunitLab;
@property (strong, nonatomic)  UILabel *heidescriptionLab;
@property (strong, nonatomic)  UILabel *heinormalValueLab;
@property (strong, nonatomic)  UILabel *weibodyProLab;
@property (strong, nonatomic)  UILabel *weiresultLab;
@property (strong, nonatomic)  UILabel *weiunitLab;
@property (strong, nonatomic)  UILabel *weidescriptionLab;
@property (strong, nonatomic)  UILabel *weinormalValueLab;
@property (strong, nonatomic)  UILabel *inweibodyProLab;
@property (strong, nonatomic)  UILabel *inweiresultLab;
@property (strong, nonatomic)  UILabel *inweiunitLab;
@property (strong, nonatomic)  UILabel *inweidescriptionLab;
@property (strong, nonatomic)  UILabel *inweinormalValueLab;
@property (strong, nonatomic)  UILabel *bloodbodyLab;
@property (strong, nonatomic)  UILabel *bloodresultLab;
@property (strong, nonatomic)  UILabel *bloodunitLab;
@property (strong, nonatomic)  UILabel *bloodbodyProLab;
@property (strong, nonatomic)  UILabel *blooddescriptionLab;
@property (strong, nonatomic)  UILabel *bloodnormalValueLab;
@property (strong, nonatomic)  UILabel *bloodEbodyLab;
@property (strong, nonatomic)  UILabel *bloodEresultLab;
@property (strong, nonatomic)  UILabel *bloodEunitLab;
@property (strong, nonatomic)  UILabel *bloodEbodyProLab;
@property (strong, nonatomic)  UILabel *bloodEdescriptionLab;
@property (strong, nonatomic)  UILabel *bloodEnormalValueLab;
@property (strong, nonatomic)  UILabel *pausebodyLab;
@property (strong, nonatomic)  UILabel *pauseresultLab;
@property (strong, nonatomic)  UILabel *pauseunitLab;
@property (strong, nonatomic)  UILabel *pausebodyProLab;
@property (strong, nonatomic)  UILabel *pausedescriptionLab;
@property (strong, nonatomic)  UILabel *pausenormalValueLab;
@property (strong, nonatomic)  UILabel *bloodAbodyLab;
@property (strong, nonatomic)  UILabel *bloodAresultLab;
@property (strong, nonatomic)  UILabel *bloodAunitLab;
@property (strong, nonatomic)  UILabel *bloodAbodyProLab;
@property (strong, nonatomic)  UILabel *bloodAdescriptionLab;
@property (strong, nonatomic)  UILabel *bloodAnormalValueLab;
@property (strong, nonatomic)  UILabel *bloodBbodyLab;
@property (strong, nonatomic)  UILabel *bloodBresultLab;
@property (strong, nonatomic)  UILabel *bloodBunitLab;
@property (strong, nonatomic)  UILabel *bloodBbodyProLab;
@property (strong, nonatomic)  UILabel *bloodBdescriptionLab;
@property (strong, nonatomic)  UILabel *bloodBnormalValueLab;
@property (strong, nonatomic)  UILabel *ideaLab;
@property (strong, nonatomic)  UILabel *ideaConLab;

@property (strong, nonatomic)  UILabel *boneLab;
@property (strong, nonatomic)  UILabel *boneProLab;
@property (strong, nonatomic)  UILabel *boneResuLab;
@property (strong, nonatomic)  UILabel *boneUnitLab;

@property (strong, nonatomic)  UILabel *heartLboneProLab;
@property (strong, nonatomic)  UILabel *heartLboneResuLab;
@property (strong, nonatomic)  UILabel *heartLboneUnitLab;

@property (strong, nonatomic)  UILabel *heartJboneProLab;
@property (strong, nonatomic)  UILabel *heartJboneResuLab;
@property (strong, nonatomic)  UILabel *heartJboneUnitLab;

@property (strong, nonatomic)  UILabel *loudboneProLab;
@property (strong, nonatomic)  UILabel *loudboneResuLab;
@property (strong, nonatomic)  UILabel *loudboneUnitLab;

@property (strong, nonatomic)  UILabel *lungsboneProLab;
@property (strong, nonatomic)  UILabel *lungsboneResuLab;
@property (strong, nonatomic)  UILabel *lungsboneUnitLab;

@property (strong, nonatomic)  UILabel *liverboneProLab;
@property (strong, nonatomic)  UILabel *liverboneResuLab;
@property (strong, nonatomic)  UILabel *liverboneUnitLab;

@property (strong, nonatomic)  UILabel *spleenboneProLab;
@property (strong, nonatomic)  UILabel *spleenboneResuLab;
@property (strong, nonatomic)  UILabel *spleenboneUnitLab;

@property (strong, nonatomic)  UILabel *tharmboneProLab;
@property (strong, nonatomic)  UILabel *tharmboneResuLab;
@property (strong, nonatomic)  UILabel *tharmboneUnitLab;

@property (strong, nonatomic)  UILabel *kidneyboneProLab;
@property (strong, nonatomic)  UILabel *kidneyboneResuLab;
@property (strong, nonatomic)  UILabel *kidneyboneUnitLab;

@property (strong, nonatomic)  UILabel *nerveboneProLab;
@property (strong, nonatomic)  UILabel *nerveboneResuLab;
@property (strong, nonatomic)  UILabel *nerveboneUnitLab;

@property (strong, nonatomic)  UILabel *otherboneProLab;
@property (strong, nonatomic)  UILabel *otherboneResuLab;
@property (strong, nonatomic)  UILabel *otherboneUnitLab;

@property (strong, nonatomic)  UILabel *ideaALab;
@property (strong, nonatomic)  UILabel *ideaAConLab;

@property (strong, nonatomic)  UILabel *surgeryLab;
@property (strong, nonatomic)  UILabel *surgeryProLab;
@property (strong, nonatomic)  UILabel *surgeryResuLab;
@property (strong, nonatomic)  UILabel *surgeryUnitLab;

@property (strong, nonatomic)  NSMutableArray *subAry;
@property (strong, nonatomic)  NSMutableArray *mainAry;
@property (strong, nonatomic)  NSMutableArray *itemNameAry;
@property (strong, nonatomic)  NSMutableArray *optionAry;
@property (assign, nonatomic)  int sumHei;


@property (strong, nonatomic)  UIButton *teleBtn;
@property (strong, nonatomic)  UIButton *postBtn;
@property (strong, nonatomic)  UIView   *bottomView;
@end


@implementation ReportDetailController


- (UIButton *)teleBtn
{
    if (!_teleBtn) {
        _teleBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-86-98, 11, 80, 26)];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_teleBtn radius:4 width:1 color:[UIColor orangeColor]];
        [_teleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_teleBtn setTitle:@"电话提问" forState:UIControlStateNormal];
        [_teleBtn addTarget:self action:@selector(teleTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _teleBtn;
}
- (UIButton *)postBtn
{
    if (!_postBtn) {
        _postBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-96, 11, 80, 26)];
        BBRim *rim=[[BBRim alloc]init];
        [rim bb_rimWithView:_postBtn radius:4 width:1 color:[UIColor orangeColor]];
        [_postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_postBtn setTitle:@"发帖提问" forState:UIControlStateNormal];
        _postBtn.backgroundColor=[UIColor orangeColor];
        [_postBtn addTarget:self action:@selector(postTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postBtn;
}
- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49-64, self.view.frame.size.width, 49)];
        _bottomView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    return _bottomView;
}





- (NSMutableArray *)itemNameAry
{
    if (!_itemNameAry) {
        _itemNameAry = [[NSMutableArray alloc] init];
    }
    return _itemNameAry;
}
- (NSMutableArray *)optionAry
{
    if (!_optionAry) {
        _optionAry = [[NSMutableArray alloc] init];
    }
    return _optionAry;
}

- (NSMutableArray *)mainAry
{
    if (!_mainAry) {
        _mainAry = [[NSMutableArray alloc] init];
    }
    return _mainAry;
}
- (NSMutableArray *)subAry
{
    if (!_subAry) {
        _subAry = [[NSMutableArray alloc] init];
    }
    return _subAry;
}

- (UIScrollView *)scroll
{
    if (!_scroll) {
        _scroll= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49)];
        _scroll.backgroundColor=[UIColor whiteColor];
    }
    return _scroll;
}
- (UIView *)annlisyView
{
    if (!_annlisyView) {
        _annlisyView= [[UIView alloc] initWithFrame:CGRectMake(16, 191, self.view.frame.size.width-32, self.viewHei)];
        _annlisyView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        BBRim *annRim=[[BBRim alloc]init];
        [annRim bb_rimWithView:_annlisyView radius:0 width:1 color:[UIColor blackColor]];
    }
    return _annlisyView;
}
- (UILabel *)annlisySumLab
{
    if (!_annlisySumLab) {
        _annlisySumLab= [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 100, 25)];
        _annlisySumLab.text=@"【汇总分析】";
        [_annlisySumLab setFont:[UIFont systemFontOfSize:14]];
    }
    return _annlisySumLab;
}
- (UILabel *)personNaLab
{
    if (!_personNaLab) {
        _personNaLab= [[UILabel alloc] initWithFrame:CGRectMake(12, 37, self.view.frame.size.width-50, 25)];
        _personNaLab.text=@"刘青云先生你好：";
        [_personNaLab setFont:[UIFont systemFontOfSize:14]];
    }
    return _personNaLab;
}
- (UILabel *)reconLab
{
    if (!_reconLab) {
        _reconLab= [[UILabel alloc] initWithFrame:CGRectMake(20, 65, self.view.frame.size.width-52, 25)];
        _reconLab.text=@"您此次体检项目未见异常！";
        [_reconLab setFont:[UIFont systemFontOfSize:14]];
    }
    return _reconLab;
}
- (UILabel *)signLab
{
    if (!_signLab) {
        _signLab= [[UILabel alloc] initWithFrame:CGRectMake(8, 100, self.view.frame.size.width-36, 25)];
        _signLab.text=@"普惠体检健康产业集团全体员工祝您身体健康!";
        [_signLab setFont:[UIFont systemFontOfSize:14]];
        [_signLab setTextAlignment:NSTextAlignmentRight];
    }
    return _signLab;
}

//13880329652
-(void)pasrData{
    //self.reportDetailsAry[self.nums] 里面为 多个字典（itemDetails   itemName     opinion）
    for (NSDictionary *dic in self.reportDetailsAry[self.nums]) {
        //itemDetails里面放的是数组
       NSArray *tempAry= dic[@"itemDetails"];
        self.subAry =nil;
        //数组里面放的是字典 dTitle   dValue
        for (int i=0 ; i<tempAry.count;i++) {
            if (i==0) {
                NSDictionary *dic0 =tempAry[0];
                NSArray *subA= dic0[@"dTitle"];
                [self.subAry addObject:subA];
            }else{
            NSDictionary *dic0 =tempAry[i];
            NSArray *subA= dic0[@"dValue"];
            [self.subAry addObject:subA];
            }
        
        }
        
        NSString *itemName= dic[@"itemName"];
        NSString *opinion= dic[@"opinion"];
        [self.itemNameAry addObject:itemName];
        [self.optionAry addObject:opinion];
        //存放多个 itemDetails
        [self.mainAry addObject:self.subAry];
    }
    
}



//加载数据
-(void)loadDatas{
        //自定义表内容
        NSArray *str=  self.mainAry[0];//str里面就是 itemDetails
        NSDictionary *dicTemp= str[0];
       //NSLog(@"^^^^%d^^^^^^%@^^^",self.mainAry.count,self.optionAry[39]);

    for (int i=0; i<self.mainAry.count; i++) {
        int hei=0;
        if(i==0){
            [self creatTableHead:self.itemNameAry[0] oryX:16 oryY:self.viewHei+210];
            [self creatTableContents:str oryX:16 oryY:self.viewHei+210+30 rowNum:str.count clomnNum:dicTemp.count];
            [self creatTableBo:self.optionAry[0] oryX:16 oryY:self.viewHei+210+30+str.count*25 sele:dicTemp.count];
            hei=self.viewHei+210+30+str.count*25+25;
        }
        else
        {
            int tempHei=0;
            for(int j=0;j<i;j++){
                NSArray *strTemp=  self.mainAry[j];
                tempHei+=strTemp.count*25;
            }
            tempHei+=(i+1)*70+self.viewHei+150;
         NSArray  *strT=  self.mainAry[i];  //str里面就是 itemDetails
         NSDictionary *dictT=   strT[0];
        [self creatTableHead:self.itemNameAry[i] oryX:16 oryY:tempHei];
        [self creatTableContents:strT oryX:16 oryY:tempHei+30 rowNum:strT.count clomnNum:dictT.count];
        [self creatTableBo:self.optionAry[i] oryX:16 oryY:tempHei+30+strT.count*25 sele:dictT.count];
        self.sumHei=tempHei+30+strT.count*25+40;
        }
    }
       [self.scroll setContentSize:CGSizeMake(self.view.frame.size.width, self.sumHei)];
}
-(void)setBaes{
    BaseInfoModel *inf=self.baseInfoAry[self.nums];
    self.nameConLab.text=inf.name;
    self.sexConLab.text=inf.gender;
    self.ageConLab.text=inf.age;
    self.dateConLab.text=inf.date;
    self.phoneConLab.text=inf.phone;
    self.mealConLab.text=inf.packages;
    self.companyConLab.text=inf.company;
    NSLog(@"………………………………%@",self.sumA[self.nums]);
    self.reconLab.text=self.sumA[self.nums];
    
    
    if([inf.gender isEqualToString:@"男"]){
    self.personNaLab.text= [ NSString stringWithFormat:@"%@先生你好",inf.name ];
    }else{
        
        self.personNaLab.text= [ NSString stringWithFormat:@"%@女士你好",inf.name ];
    }
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    BaseInfoModel *inf=self.baseInfoAry[self.nums];
    
    NSLog(@"%@",inf.name);
    [self pasrData];
    NSArray *aa= self.mainAry[0];
    NSArray *bb= aa[0];
    NSLog(@"测试解析结果：^^^^%@",bb[0]) ;
    
    
    
    // Do any additional setup after loading the view.
    self.viewHei=150;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    // 设置单元格的大小
    [self setWidth];
    //初始化控件
    [self initLabel];
    
    //基本数据加载
    [self setBaes];
    //加载控件
    [self addSubviewsToSuperview];
    //设置控件详情
    [self setSubviewsDetail];
    
    //kebia  tit
    [self loadDatas];
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)initLabel{
    
    self.nameLab=[self getlabel:@"姓名" align:1 oryX:16 oryY:16 width:80 height:26];
    self.nameConLab=[self getlabel:@"刘青云" align:2 oryX:95 oryY:16 width:self.view.frame.size.width-95-16 height:26];
    self.sexLab=[self getlabel:@"性别" align:1 oryX:16 oryY:41 width:80 height:26];
    self.sexConLab=[self getlabel:@"男" align:2 oryX:95 oryY:41 width:self.view.frame.size.width-95-16 height:26];
    self.ageLab=[self getlabel:@"年龄" align:1 oryX:16 oryY:66 width:80 height:26];
    self.ageConLab=[self getlabel:@"40" align:2 oryX:95 oryY:66  width:self.view.frame.size.width-95-16 height:26];
    self.dateLab=[self getlabel:@"体检日期" align:1 oryX:16 oryY:91 width:80 height:26];
    self.dateConLab=[self getlabel:@"2015-07-15" align:2 oryX:95 oryY:91 width:self.view.frame.size.width-95-16 height:26];
    self.phoneLab=[self getlabel:@"手机号码" align:1 oryX:16 oryY:116 width:80 height:26];
    self.phoneConLab=[self getlabel:@"18706898854" align:2 oryX:95 oryY:116 width:self.view.frame.size.width-95-16 height:26];
    
    
    self.mealLab=[self getlabel:@"体检套餐" align:1 oryX:16 oryY:141 width:80 height:26];
    self.mealConLab=[self getlabel:@"成年套餐" align:2 oryX:95 oryY:141 width:self.view.frame.size.width-95-16 height:26];
    self.companyLab=[self getlabel:@"工作单位" align:1 oryX:16 oryY:166 width:80 height:26];
    self.companyConLab=[self getlabel:@"三星公司" align:2 oryX:95 oryY:166 width:self.view.frame.size.width-95-16 height:26];
    
    
    
    
    self.bodyLab=[self getlabel:@"身高体重血压" align:3 oryX:16 oryY:self.viewHei+200 width:self.view.frame.size.width-32 height:31];
    //0
    self.bodyProLab=[self getlabel:@"体检项目" align:3 oryX:16 oryY:self.viewHei+230 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.resultLab=[self getlabel:@"测量结果" align:3 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+230 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.unitLab=[self getlabel:@"单位" align:3 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+230 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.descriptionLab=[self getlabel:@"异常描述" align:3 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+230 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.normalValueLab=[self getlabel:@"正常参数值" align:3 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+230 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    
    //1hei
    self.heibodyProLab=[self getlabel:@"身高" align:4 oryX:16 oryY:self.viewHei+255 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.heiresultLab=[self getlabel:@"正常" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+255 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.heiunitLab=[self getlabel:@"cm" align:4 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+255 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.heidescriptionLab=[self getlabel:@"" align:4 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+255 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.heinormalValueLab=[self getlabel:@"" align:4 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+255 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    //wei
    self.weibodyProLab=[self getlabel:@"体重" align:4 oryX:16 oryY:self.viewHei+280 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.weiresultLab=[self getlabel:@"正常" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+280 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.weiunitLab=[self getlabel:@"kg" align:4 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+280 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.weidescriptionLab=[self getlabel:@"" align:4 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+280 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.weinormalValueLab=[self getlabel:@"" align:4 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+280 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    //inwei
    self.inweibodyProLab=[self getlabel:@"体重指数" align:4 oryX:16 oryY:self.viewHei+305 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.inweiresultLab=[self getlabel:@"正常" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+305 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.inweiunitLab=[self getlabel:@"kg/m^2" align:4 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+305 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.inweidescriptionLab=[self getlabel:@"" align:4 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+305 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.inweinormalValueLab=[self getlabel:@"18-24" align:4 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+305 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    //blood
    self.bloodbodyProLab=[self getlabel:@"血压(收缩压)" align:4 oryX:16 oryY:self.viewHei+330 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.bloodresultLab=[self getlabel:@"/" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+330 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodunitLab=[self getlabel:@"毫米汞柱" align:4 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+330 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.blooddescriptionLab=[self getlabel:@"" align:4 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+330 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodnormalValueLab=[self getlabel:@"83-139" align:4 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+330 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    //Eblood
    self.bloodEbodyProLab=[self getlabel:@"血压(舒张压)" align:4 oryX:16 oryY:self.viewHei+355 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.bloodEresultLab=[self getlabel:@"/" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+355 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodEunitLab=[self getlabel:@"毫米汞柱" align:4 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+355 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodEdescriptionLab=[self getlabel:@"" align:4 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+355 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodEnormalValueLab=[self getlabel:@"59-89" align:4 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+355 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    //pause
    self.pausebodyProLab=[self getlabel:@"脉搏" align:4 oryX:16 oryY:self.viewHei+380 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.pauseresultLab=[self getlabel:@"正常" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+380 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.pauseunitLab=[self getlabel:@"次/分" align:4 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+380 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.pausedescriptionLab=[self getlabel:@"" align:4 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+380 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.pausenormalValueLab=[self getlabel:@"60-100" align:4 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+380 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    //bloodA
    self.bloodAbodyProLab=[self getlabel:@"复测血压1" align:4 oryX:16 oryY:self.viewHei+405 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.bloodAresultLab=[self getlabel:@"/" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+405 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodAunitLab=[self getlabel:@"毫米汞柱" align:4 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+405 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodAdescriptionLab=[self getlabel:@"" align:4 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+405 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodAnormalValueLab=[self getlabel:@"83-139" align:4 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+405 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    //bloodB
    self.bloodBbodyProLab=[self getlabel:@"复测血压2" align:4 oryX:16 oryY:self.viewHei+430 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.bloodBresultLab=[self getlabel:@"/" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+430 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodBunitLab=[self getlabel:@"毫米汞柱" align:4 oryX:16+(self.view.frame.size.width-32)*9.5/22.5 oryY:self.viewHei+430 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodBdescriptionLab=[self getlabel:@"" align:4 oryX:15+(self.view.frame.size.width-32)*13.5/22.5 oryY:self.viewHei+430 width:(self.view.frame.size.width-32)*4/22.5 height:26];
    self.bloodBnormalValueLab=[self getlabel:@"83-139" align:4 oryX:14+(self.view.frame.size.width-32)*17.5/22.5 oryY:self.viewHei+430 width:2+(self.view.frame.size.width-32)*5/22.5 height:26];
    self.ideaLab=[self getlabel:@"初步意见" align:4 oryX:16 oryY:self.viewHei+455 width:2+(self.view.frame.size.width-32)*5.5/22.5  height:26];
    self.ideaConLab=[self getlabel:@"未见异常" align:4 oryX:17+(self.view.frame.size.width-32)*5.5/22.5 oryY:self.viewHei+455 width:self.view.frame.size.width-(33+(self.view.frame.size.width-32)*5.5/22.5)  height:26];
    
    self.boneLab=[self getlabel:@"骨密度" align:3 oryX:16 oryY:self.viewHei+490 width:self.view.frame.size.width-32  height:31];
    self.boneProLab=[self getlabel:@"体检项目" align:3 oryX:16 oryY:self.viewHei+520 width:60  height:26];
    self.boneResuLab=[self getlabel:@"体检结果" align:3 oryX:15+60 oryY:self.viewHei+520 width:self.view.frame.size.width-130  height:26];
    self.boneUnitLab=[self getlabel:@"单位" align:3 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+520 width:40  height:26];
    //heartL
    self.heartLboneProLab=[self getlabel:@"心率" align:4 oryX:16 oryY:self.viewHei+545 width:60  height:26];
    self.heartLboneResuLab=[self getlabel:@"齐" align:4 oryX:15+60 oryY:self.viewHei+545 width:self.view.frame.size.width-130  height:26];
    self.heartLboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+545 width:40  height:26];
    //heartJ
    
    self.heartJboneProLab=[self getlabel:@"心界" align:4 oryX:16 oryY:self.viewHei+570 width:60  height:26];
    self.heartJboneResuLab=[self getlabel:@"正常" align:4 oryX:15+60 oryY:self.viewHei+570 width:self.view.frame.size.width-130  height:26];
    self.heartJboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+570 width:40  height:26];
    //loud
    self.loudboneProLab=[self getlabel:@"杂音" align:4 oryX:16 oryY:self.viewHei+595 width:60  height:26];
    self.loudboneResuLab=[self getlabel:@"未闻及" align:4 oryX:15+60 oryY:self.viewHei+595 width:self.view.frame.size.width-130  height:26];
    self.loudboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+595 width:40  height:26];
    //lungs
    self.lungsboneProLab=[self getlabel:@"肺" align:4 oryX:16 oryY:self.viewHei+620 width:60  height:26];
    self.lungsboneResuLab=[self getlabel:@"肺呼吸清晰" align:4 oryX:15+60 oryY:self.viewHei+620 width:self.view.frame.size.width-130  height:26];
    self.lungsboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+620 width:40  height:26];
    //liver
    self.liverboneProLab=[self getlabel:@"肝脏" align:4 oryX:16 oryY:self.viewHei+645 width:60  height:26];
    self.liverboneResuLab=[self getlabel:@"肝脏下未接触" align:4 oryX:15+60 oryY:self.viewHei+645 width:self.view.frame.size.width-130  height:26];
    self.liverboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+645 width:40  height:26];
    
    //spleen脾脏
    self.spleenboneProLab=[self getlabel:@"脾" align:4 oryX:16 oryY:self.viewHei+670 width:60  height:26];
    self.spleenboneResuLab=[self getlabel:@"脾脏下未接触" align:4 oryX:15+60 oryY:self.viewHei+670 width:self.view.frame.size.width-130  height:26];
    self.spleenboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+670 width:40  height:26];
    //tharm
    self.tharmboneProLab=[self getlabel:@"肠鸣音" align:4 oryX:16 oryY:self.viewHei+695 width:60  height:26];
    self.tharmboneResuLab=[self getlabel:@"正常" align:4 oryX:15+60 oryY:self.viewHei+695 width:self.view.frame.size.width-130  height:26];
    self.tharmboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+695 width:40  height:26];
    //kidney
    self.kidneyboneProLab=[self getlabel:@"双肾" align:4 oryX:16 oryY:self.viewHei+720 width:60  height:26];
    self.kidneyboneResuLab=[self getlabel:@"无叩击偏" align:4 oryX:15+60 oryY:self.viewHei+720 width:self.view.frame.size.width-130  height:26];
    self.kidneyboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+720 width:40  height:26];
    //nerve
    self.nerveboneProLab=[self getlabel:@"神经系统" align:4 oryX:16 oryY:self.viewHei+745 width:60  height:26];
    self.nerveboneResuLab=[self getlabel:@"生理反射正常存在" align:4 oryX:15+60 oryY:self.viewHei+745 width:self.view.frame.size.width-130  height:26];
    self.nerveboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+745 width:40  height:26];
    //tharm
    self.otherboneProLab=[self getlabel:@"其它" align:4 oryX:16 oryY:self.viewHei+770 width:60  height:26];
    self.otherboneResuLab=[self getlabel:@"/" align:4 oryX:15+60 oryY:self.viewHei+770 width:self.view.frame.size.width-130  height:26];
    self.otherboneUnitLab=[self getlabel:@"" align:4 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+770 width:40  height:26];
    self.ideaALab=[self getlabel:@"初步意见" align:4 oryX:16 oryY:self.viewHei+795 width:60  height:26];
    self.ideaAConLab=[self getlabel:@"未见异常" align:4 oryX:75 oryY:self.viewHei+795 width:self.view.frame.size.width-91  height:26];
    
    
    self.surgeryLab=[self getlabel:@"外科" align:3 oryX:16 oryY:self.viewHei+830 width:self.view.frame.size.width-32  height:31];
    
    
    self.surgeryProLab=[self getlabel:@"体检项目" align:3 oryX:16 oryY:self.viewHei+860 width:60  height:26];
    self.surgeryResuLab=[self getlabel:@"体检结果" align:3 oryX:15+60 oryY:self.viewHei+860 width:self.view.frame.size.width-130  height:26];
    self.surgeryUnitLab=[self getlabel:@"单位" align:3 oryX:self.view.frame.size.width-70+14 oryY:self.viewHei+860 width:40  height:26];
    
    
    
}

//add控件
-(void)addSubviewsToSuperview{
    [self.view addSubview:self.scroll];
    [self.scroll addSubview:self.nameLab];
    [self.scroll addSubview:self.nameConLab];
    [self.scroll addSubview:self.sexLab];
    [self.scroll addSubview:self.sexConLab];
    [self.scroll addSubview:self.ageLab];
    [self.scroll addSubview:self.ageConLab];
    [self.scroll addSubview:self.dateLab];
    [self.scroll addSubview:self.dateConLab];
    [self.scroll addSubview:self.phoneLab];
    [self.scroll addSubview:self.phoneConLab];
    [self.scroll addSubview:self.mealLab];
    [self.scroll addSubview:self.mealConLab];
    [self.scroll addSubview:self.companyLab];
    [self.scroll addSubview:self.companyConLab];
    [self.scroll addSubview:self.annlisyView];
    [self.annlisyView addSubview:self.annlisySumLab];
    [self.annlisyView addSubview:self.personNaLab];
    [self.annlisyView addSubview:self.reconLab];
    [self.annlisyView addSubview:self.signLab];
    
    
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.teleBtn];
    [self.bottomView addSubview:self.postBtn];
    
//    [self.scroll addSubview:self.bodyLab];
//    
//    [self.scroll addSubview:self.bodyProLab];
//    [self.scroll addSubview:self.resultLab];
//    [self.scroll addSubview:self.unitLab];
//    [self.scroll addSubview:self.descriptionLab];
//    [self.scroll addSubview:self.normalValueLab];
//    
//    [self.scroll addSubview:self.heibodyProLab];
//    [self.scroll addSubview:self.heiresultLab];
//    [self.scroll addSubview:self.heiunitLab];
//    [self.scroll addSubview:self.heidescriptionLab];
//    [self.scroll addSubview:self.heinormalValueLab];
//    [self.scroll addSubview:self.weibodyProLab];
//    [self.scroll addSubview:self.weiresultLab];
//    [self.scroll addSubview:self.weiunitLab];
//    [self.scroll addSubview:self.weidescriptionLab];
//    [self.scroll addSubview:self.weinormalValueLab];
//    [self.scroll addSubview:self.inweibodyProLab];
//    [self.scroll addSubview:self.inweiresultLab];
//    [self.scroll addSubview:self.inweiunitLab];
//    [self.scroll addSubview:self.inweidescriptionLab];
//    [self.scroll addSubview:self.inweinormalValueLab];
//    
//    [self.scroll addSubview:self.bloodbodyProLab];
//    [self.scroll addSubview:self.bloodresultLab];
//    [self.scroll addSubview:self.bloodunitLab];
//    [self.scroll addSubview:self.blooddescriptionLab];
//    [self.scroll addSubview:self.bloodnormalValueLab];
//    
//    [self.scroll addSubview:self.bloodEbodyProLab];
//    [self.scroll addSubview:self.bloodEresultLab];
//    [self.scroll addSubview:self.bloodEunitLab];
//    [self.scroll addSubview:self.bloodEdescriptionLab];
//    [self.scroll addSubview:self.bloodEnormalValueLab];
//    
//    [self.scroll addSubview:self.pausebodyProLab];
//    [self.scroll addSubview:self.pauseresultLab];
//    [self.scroll addSubview:self.pauseunitLab];
//    [self.scroll addSubview:self.pausedescriptionLab];
//    [self.scroll addSubview:self.pausenormalValueLab];
//    
//    [self.scroll addSubview:self.bloodAbodyProLab];
//    [self.scroll addSubview:self.bloodAresultLab];
//    [self.scroll addSubview:self.bloodAunitLab];
//    [self.scroll addSubview:self.bloodAdescriptionLab];
//    [self.scroll addSubview:self.bloodAnormalValueLab];
//    
//    [self.scroll addSubview:self.bloodBbodyProLab];
//    [self.scroll addSubview:self.bloodBresultLab];
//    [self.scroll addSubview:self.bloodBunitLab];
//    [self.scroll addSubview:self.bloodBdescriptionLab];
//    [self.scroll addSubview:self.bloodBnormalValueLab];
//    
//    [self.scroll addSubview:self.ideaLab];
//    [self.scroll addSubview:self.ideaConLab];
//    
//    [self.scroll addSubview:self.boneLab];
//    [self.scroll addSubview:self.boneProLab];
//    [self.scroll addSubview:self.boneResuLab];
//    [self.scroll addSubview:self.boneUnitLab];
//    
//    [self.scroll addSubview:self.heartLboneProLab];
//    [self.scroll addSubview:self.heartLboneResuLab];
//    [self.scroll addSubview:self.heartLboneUnitLab];
//    
//    [self.scroll addSubview:self.heartJboneProLab];
//    [self.scroll addSubview:self.heartJboneResuLab];
//    [self.scroll addSubview:self.heartJboneUnitLab];
//    
//    [self.scroll addSubview:self.loudboneProLab];
//    [self.scroll addSubview:self.loudboneResuLab];
//    [self.scroll addSubview:self.loudboneUnitLab];
//    
//    [self.scroll addSubview:self.lungsboneProLab];
//    [self.scroll addSubview:self.lungsboneResuLab];
//    [self.scroll addSubview:self.lungsboneUnitLab];
//    
//    [self.scroll addSubview:self.liverboneProLab];
//    [self.scroll addSubview:self.liverboneResuLab];
//    [self.scroll addSubview:self.liverboneUnitLab];
//    
//    [self.scroll addSubview:self.spleenboneProLab];
//    [self.scroll addSubview:self.spleenboneResuLab];
//    [self.scroll addSubview:self.spleenboneUnitLab];
//    
//    [self.scroll addSubview:self.tharmboneProLab];
//    [self.scroll addSubview:self.tharmboneResuLab];
//    [self.scroll addSubview:self.tharmboneUnitLab];
//    
//    [self.scroll addSubview:self.kidneyboneProLab];
//    [self.scroll addSubview:self.kidneyboneResuLab];
//    [self.scroll addSubview:self.kidneyboneUnitLab];
//    
//    [self.scroll addSubview:self.nerveboneProLab];
//    [self.scroll addSubview:self.nerveboneResuLab];
//    [self.scroll addSubview:self.nerveboneUnitLab];
//    
//    [self.scroll addSubview:self.otherboneProLab];
//    [self.scroll addSubview:self.otherboneResuLab];
//    [self.scroll addSubview:self.otherboneUnitLab];
//    
//    [self.scroll addSubview:self.ideaALab];
//    [self.scroll addSubview:self.ideaAConLab];
//    
//    [self.scroll addSubview:self.surgeryLab];
//    [self.scroll addSubview:self.surgeryProLab];
//    [self.scroll addSubview:self.surgeryResuLab];
//    [self.scroll addSubview:self.surgeryUnitLab];
//    
//    
}



-(void)setWidth{
    //5
    self.five1Wid=16;
    self.five2Wid=17+(self.view.frame.size.width-32)*5.5/22.5;
    self.five3Wid=16+(self.view.frame.size.width-32)*9.5/22.5;
    self.five4Wid=15+(self.view.frame.size.width-32)*13.5/22.5;
    self.five5Wid=14+(self.view.frame.size.width-32)*17.5/22.5;
    
    self.fiveFirstWid=2+(self.view.frame.size.width-32)*5.5/22.5;
    self.fiveOtherWid=(self.view.frame.size.width-32)*4/22.5;
    self.fiveLastWid=2+(self.view.frame.size.width-32)*5/22.5;
    self.fiveBoWid=self.view.frame.size.width-(33+(self.view.frame.size.width-32)*5.5/22.5);
    //3
    self.three1Wid=16;
    self.three2Wid=75;
    self.three3Wid=self.view.frame.size.width-56;
    
    self.threeFirstWid=60;
    self.threeCenterWid=self.view.frame.size.width-130;
    self.threeLastWid=40;
    self.threeBoWid=self.view.frame.size.width-91;
    //tou
    self.headWid=self.view.frame.size.width-32;
    

}
-(UILabel *)getlabel:(NSString *)str align:(int)align oryX:(float)x oryY:(float)y width:(float)wid height:(float)hei{
    //1:center 2:left
    UILabel *labCustom=[[UILabel alloc]initWithFrame:CGRectMake(x, y, wid, hei)];
    labCustom.text=str;
    if (align==1) {
        [labCustom setTextAlignment:NSTextAlignmentCenter];
        [labCustom setFont:[UIFont systemFontOfSize:14]];
    }
    if (align==2) {
        labCustom.text=[NSString stringWithFormat:@"   %@",str ];
        [labCustom setFont:[UIFont systemFontOfSize:14]];
    }
    if (align==3) {
        labCustom.text=[NSString stringWithFormat:@" %@",str ];
        [labCustom setFont:[UIFont systemFontOfSize:11]];
    }
    if (align==4) {
        labCustom.text=[NSString stringWithFormat:@" %@",str ];
        [labCustom setFont:[UIFont systemFontOfSize:11]];
        labCustom.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    if (align==5) {
        labCustom.text=[NSString stringWithFormat:@" %@",str ];
        [labCustom setFont:[UIFont systemFontOfSize:16]];
    }
    self.rim=[[BBRim alloc]init];
    [self.rim bb_rimWithView:labCustom radius:0 width:1 color:[UIColor blackColor]];
    return labCustom;
}


-(void)setSubviewsDetail{
    [self.bodyLab setFont:[UIFont systemFontOfSize:16]];
    [self.boneLab setFont:[UIFont systemFontOfSize:16]];
    [self.surgeryLab setFont:[UIFont systemFontOfSize:16]];
    [self.scroll setContentSize:CGSizeMake(self.view.frame.size.width, self.viewHei+4000)];
    [self.ideaLab setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
}

//创建表格头
-(void)creatTableHead:(NSString *)str oryX:(float)x oryY:(float)y{
    UILabel *customLab=[self getlabel:str align:5 oryX:x oryY:y width:self.headWid height:31];
    [self.scroll addSubview:customLab];
}

//创建表格
-(void)creatTableContents:(NSArray *)contenTxt oryX:(float)x oryY:(float)y rowNum:(int)rown clomnNum:(int)clon
{
  //y：self.viewHei+930
    if (clon==5) {
        for (int i=0; i<rown; i++) {
            for (int j=0; j<clon; j++) {
                
               NSArray *STR= contenTxt[i];//行
                
                if (j==0) {
                    UILabel * cusLab=[self getlabel:STR[j] align:4 oryX:x oryY:y+i*25 width:self.fiveFirstWid height:26];
                    [self.scroll addSubview:cusLab];
                }
                if (j==1) {
                    UILabel * cusLab=[self getlabel:STR[j] align:4 oryX:self.five2Wid oryY:y+i*25 width:self.fiveOtherWid height:26];
                    [self.scroll addSubview:cusLab];
                }
                if (j==2) {
                    UILabel * cusLab=[self getlabel:STR[j] align:4 oryX:self.five3Wid oryY:y+i*25 width:self.fiveOtherWid height:26];
                    [self.scroll addSubview:cusLab];
                }
                if (j==3) {
                    UILabel * cusLab=[self getlabel:STR[j] align:4 oryX:self.five4Wid oryY:y+i*25 width:self.fiveOtherWid height:26];
                    [self.scroll addSubview:cusLab];
                }
                if (j==4) {
                    UILabel * cusLab=[self getlabel:STR[j] align:4 oryX:self.five5Wid oryY:y+i*25 width:self.fiveLastWid height:26];
                    [self.scroll addSubview:cusLab];
                }
            }
        }
    }
    
    if (clon==3) {
        for (int i=0; i<rown; i++) {
            for (int j=0; j<clon; j++) {
                if (j==0) {
                    UILabel * cusLab=[self getlabel:@"第一列" align:4 oryX:x oryY:y+i*25 width:self.threeFirstWid height:26];
                    [self.scroll addSubview:cusLab];
                }
                if (j==1) {
                    UILabel * cusLab=[self getlabel:@"第二列" align:4 oryX:self.three2Wid oryY:y+i*25 width:self.threeCenterWid height:26];
                    [self.scroll addSubview:cusLab];
                }
                if (j==2) {
                    UILabel * cusLab=[self getlabel:@"第三列" align:4 oryX:self.three3Wid oryY:y+i*25 width:self.threeLastWid height:26];
                    [self.scroll addSubview:cusLab];
                }
            }
        }
    }

}

//创建表尾
-(void)creatTableBo:(NSString *)str oryX:(float)x oryY:(float)y sele:(int)temp{
    if (temp==5) {
        UILabel *customLab=[self getlabel:str align:4 oryX:self.five1Wid oryY:y width:self.fiveFirstWid height:26];
        [self.scroll addSubview:customLab];
        
        UILabel *customLab1=[self getlabel:str align:4 oryX:self.five2Wid oryY:y width:self.fiveBoWid height:26];
        [self.scroll addSubview:customLab1];
    }
    if (temp==3) {
        UILabel *customLab=[self getlabel:str align:4 oryX:self.three1Wid oryY:y width:self.threeFirstWid height:26];
        [self.scroll addSubview:customLab];
        
        UILabel *customLab1=[self getlabel:str align:4 oryX:self.three2Wid oryY:y width:self.threeBoWid height:26];
        [self.scroll addSubview:customLab1];
    }
    
}

//发帖提问
-(void)postTap{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"MyQuestionController" bundle:nil];
    QuestionsController *questionsController=[sb instantiateViewControllerWithIdentifier:@"QuestionsController"];
    questionsController.phoneBtn.hidden = YES;
    [self.navigationController pushViewController:questionsController animated:YES];
}

//电话提问
-(void)teleTap{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"MyQuestionController" bundle:nil];
    PhoneAskController *questionsController=[sb instantiateViewControllerWithIdentifier:@"PhoneAskController"];
    [self.navigationController pushViewController:questionsController animated:YES];
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
