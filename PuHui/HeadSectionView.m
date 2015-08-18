//
//  HeadSectionView.m
//  PuHui
//
//  Created by rp.wang on 15/8/4.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "HeadSectionView.h"

@implementation HeadSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)subViewa
{
    if (!_subViewa) {
        _subViewa= [[UILabel alloc] init];
        _subViewa.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
        //_subViewa.backgroundColor=[UIColor redColor];
    }
    return _subViewa;
}
- (UILabel *)footBo
{
    if (!_footBo) {
        _footBo= [[UILabel alloc] init];
        _footBo.backgroundColor=[UIColor colorWithRed:169.0/255.0 green:169.0/255.0 blue:169.0/255.0 alpha:1];
    }
    return _footBo;
}
- (UILabel *)headCode
{
    if (!_headCode) {
        _headCode= [[UILabel alloc] init];
        _headCode.textColor=[UIColor grayColor];
        _headCode.font=[UIFont systemFontOfSize:11];
    }
    return _headCode;
}

- (UILabel *)headTrade
{
    if (!_headTrade) {
        _headTrade= [[UILabel alloc] init];
        _headTrade.textColor=[UIColor orangeColor];
        _headTrade.font=[UIFont systemFontOfSize:11];
        [_headTrade setTextAlignment:NSTextAlignmentRight];
    }
    return _headTrade;
}
- (UILabel *)footTime
{
    if (!_footTime) {
        _footTime= [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 140, 21)];
        _footTime.textColor=[UIColor grayColor];
        _footTime.font=[UIFont systemFontOfSize:12];
    }
    return _footTime;
}
- (UILabel *)footCount
{
    if (!_footCount) {
        _footCount= [[UILabel alloc] init];
        [_footCount setTextAlignment:NSTextAlignmentRight];
        _footCount.font=[UIFont systemFontOfSize:12];
    }
    return _footCount;
}
- (UILabel *)footTotal
{
    if (!_footTotal) {
        _footTotal= [[UILabel alloc] init];
        _footTotal.font=[UIFont systemFontOfSize:12];
        _footTotal.textColor=[UIColor orangeColor];
    }
    return _footTotal;
}
-(UIView *)objHeadViewX:(CGFloat)x viewY:(CGFloat)y codeTxt:(NSString *)codTxt tradeTxt:(NSString *)trdTxt{
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0, 0, x, 30)];
    vi.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
    self.headCode.text=codTxt;
    self.headCode.frame=CGRectMake(10, 5, x-70, 21);
    self.headTrade.frame=CGRectMake(x-60, 5, 50, 21);
    self.headTrade.text=trdTxt;

    
    [vi addSubview:self.headCode];
    [vi addSubview:self.headTrade];
    return vi;

}

-(UIView *)objFootViewX:(CGFloat)x viewY:(CGFloat)y timeTxt:(NSString *)timeTxt countTxt:(NSString *)countTxt  totalTxt:(NSString *) totalTxt{
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0, 0, x, y)];
    vi.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1];
   
    
    self.footTime.text=timeTxt;
    self.footCount.frame=CGRectMake(x-170, 5, 80, 21);
    self.footCount.text=countTxt;
    
    self.footTotal.frame=CGRectMake(x-90, 5, 80, 21);
    self.footTotal.text=totalTxt;
    
    self.footBo.frame=CGRectMake(0, y-6, x, 6);
    
    [vi addSubview:self.footTotal];
    [vi addSubview:self.footCount];
    [vi addSubview:self.footTime];
    [vi addSubview:self.footBo];
    return vi;
    
}
@end
