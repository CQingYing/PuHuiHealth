//
//  HealthStoreHeader.m
//  PuHui
//
//  Created by administrator on 15/7/6.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import "HealthStoreHeader.h"
#import "RequestServer.h"

@interface HealthStoreHeader ()
@property(strong, nonatomic) UIButton *chooseButton;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) UIScrollView *sv;
@property(strong, nonatomic) UIButton *manSel;
@property(strong, nonatomic) UIButton *womanSel;
@property(strong, nonatomic) UIButton *allSel;
@property(strong, nonatomic) UIPageControl *pc;
@property(strong, nonatomic) UIImageView *lastView;
@property(strong, nonatomic) NSMutableArray *arrysMuta;
@property(strong, nonatomic) NSMutableArray *tempMuta;


@end

@implementation HealthStoreHeader
@synthesize height,chooseLabel,sexTag,currentPage;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//懒加载
- (NSMutableArray *)arrysMuta
{
    if (!_arrysMuta) {
        _arrysMuta=[[NSMutableArray alloc]init];
    }
    return _arrysMuta;
}

- (NSMutableArray *)tempMuta
{
    if (!_tempMuta) {
        _tempMuta=[[NSMutableArray alloc]init];
    }
    return _tempMuta;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        sexTag = 3; //1男2女3全部
        self.lastView = nil;
        UILabel *manLabel = [[UILabel alloc] init];
        self.manSel = [[UIButton alloc] init];
        UILabel *womanLabel = [[UILabel alloc] init];
        self.womanSel = [[UIButton alloc] init];
        UILabel *allLabel = [[UILabel alloc] init];
        self.allSel = [[UIButton alloc] init];
        UIImage *notselImage = [UIImage imageNamed:@"Not selected"];
        UIImage *selImage = [UIImage imageNamed:@"Selected"];
        UIImage *defaultImage = [UIImage imageNamed:@"photo-11"];
        self.sv = [[UIScrollView alloc] init];
        
        [manLabel setText:@"男"];
        [womanLabel setText:@"女"];
        [allLabel setText:@"全部"];
        [self.manSel setImage:notselImage forState:UIControlStateNormal];
        [self.manSel setImage:selImage forState:UIControlStateSelected];
        [self.manSel addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        self.manSel.tag = 1;
        [self.womanSel setImage:notselImage forState:UIControlStateNormal];
        [self.womanSel setImage:selImage forState:UIControlStateSelected];
        self.womanSel.tag = 2;
        [self.womanSel addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.allSel setImage:notselImage forState:UIControlStateNormal];
        [self.allSel setImage:selImage forState:UIControlStateSelected];
        self.allSel.tag = 3;
        self.allSel.selected = YES;
        [self.allSel addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:manLabel];
        [self addSubview:self.manSel];
        [self addSubview:womanLabel];
        [self addSubview:self.womanSel];
        [self addSubview:allLabel];
        [self addSubview:self.allSel];
        [self addSubview:self.sv];
        [self.sv setPagingEnabled:YES];
        [self.sv setDelegate:self];
        float t = defaultImage.size.height/defaultImage.size.width;
        
        [manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(self.mas_left).offset(10);
            make.height.mas_equalTo(notselImage.size.height);
        }];
        [self.manSel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(manLabel.mas_right);
            make.height.mas_equalTo(notselImage.size.height);
            make.width.mas_equalTo(notselImage.size.width);
        }];
        [womanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(self.manSel.mas_right).offset(10);
            make.height.mas_equalTo(notselImage.size.height);
        }];
        [self.womanSel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(womanLabel.mas_right);
            make.height.mas_equalTo(notselImage.size.height);
            make.width.mas_equalTo(notselImage.size.width);
        }];
        [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(self.womanSel.mas_right).offset(10);
            make.height.mas_equalTo(notselImage.size.height);
        }];
        [self.allSel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(5);
            make.left.equalTo(allLabel.mas_right);
            make.height.mas_equalTo(notselImage.size.height);
            make.width.mas_equalTo(notselImage.size.width);
        }];
        [self.sv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(manLabel.mas_bottom).offset(10);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.equalTo(self.sv.mas_width).multipliedBy(t);
        }];
        UIImage *image1 = [UIImage imageNamed:@"Not Selected_01"];
        //UIImage *image2 = [UIImage imageNamed:@"Selected_01"];
        UIView *container = [UIView new];
        [self.sv addSubview:container];
        [RequestServer fetchMethodName:@"recommendPackages" parameters:@{@"userId":@"",@"userAccount":@"",@"userPwd":@""} shouldDisplayLoadingIndicator:YES puhuiRequestType:PuhuiJK successHandler:^(NSMutableDictionary *responseDic) {
            NSArray *inforArys=responseDic[@"data"];
            for (NSDictionary *dict  in inforArys) {
                SetModel *meals=[SetModel objectWithKeyValues:dict];
                [self.arrysMuta  addObject:meals];
            }
            for (SetModel * info in self.arrysMuta)
            {
                [self.tempMuta addObject:info];
            }
            if (self.tempMuta.count != 0&&self.tempMuta!=nil) {
                for (SetModel *sm in self.tempMuta) {
                    if (self.lastView == nil) {
                        UIImageView *imageView = [[UIImageView alloc] init];
                        NSString *tempStr=[PHQDRequestUrl stringByAppendingString:sm.info_pic];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
                        [container addSubview:imageView];
                        self.lastView = imageView;
                        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(container.mas_left);
                            make.bottom.equalTo(container.mas_bottom);
                            make.width.equalTo(self.sv.mas_width);
                            make.height.equalTo(self.sv.mas_width).multipliedBy(t);
                        }];
                        [imageView setUserInteractionEnabled:YES];
                        
//                        UILabel *name = [[UILabel alloc] init];
//                        [imageView addSubview:name];
//                        [name mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.equalTo(imageView.mas_top).offset(10);
//                            make.left.equalTo(imageView.mas_left).offset(10);
//                        }];
//                        name.text = sm.name;
//                        [name setTextColor:[UIColor blackColor]];
//                        [name setFont:[UIFont fontWithName:@"Helvetica" size:18]];
//                        UIImageView *cell = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSpaceImage"]];
//                        [imageView addSubview:cell];
//                        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.equalTo(name.mas_bottom).offset(10);
//                            make.left.equalTo(name.mas_left);
//                        }];
//                        UILabel *price = [[UILabel alloc] init];
//                        [imageView addSubview:price];
//                        [price mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(cell.mas_right).offset(5);
//                            make.top.equalTo(cell.mas_top);
//                        }];
//                        price.text = [NSString stringWithFormat:@"金额 %d 元",sm.retail];
//                        [price setTextColor:[UIColor blackColor]];
//                        [price setFont:[UIFont fontWithName:@"Helvetica" size:8]];
//                        UILabel *object = [[UILabel alloc] init];
//                        [imageView addSubview:object];
//                        [object mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(price.mas_left);
//                            make.top.equalTo(price.mas_bottom).offset(5);
//                        }];
//                        NSString *temp1 = @"适用对象：";
//                        object.text = [temp1 stringByAppendingString:sm.age_type];
//                        [object setTextColor:[UIColor blackColor]];
//                        [object setFont:[UIFont fontWithName:@"Helvetica" size:8]];
//                        UILabel *cost = [[UILabel alloc] init];
//                        [imageView addSubview:cost];
//                        [cost mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(name.mas_left);
//                            make.top.equalTo(object.mas_bottom).offset(5);
//                        }];
//                        cost.text = [NSString stringWithFormat:@"内部折扣价：¥%d",sm.cost];
//                        [cost setTextColor:[UIColor orangeColor]];
                        
                        UIButton *temp = [[UIButton alloc] init];
                        [imageView addSubview:temp];
                        [temp mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.edges.equalTo(imageView);
                        }];
                        [temp addTarget:self action:@selector(clickImageView) forControlEvents:UIControlEventTouchUpInside];
                    } else {
                        UIImageView *imageView = [[UIImageView alloc] init];
                        NSString *tempStr=[PHQDRequestUrl stringByAppendingString:sm.info_pic];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:tempStr] placeholderImage:[UIImage imageNamed:@"photo_04"]];
                        [container addSubview:imageView];
                        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.lastView.mas_right);
                            make.bottom.equalTo(container.mas_bottom);
                            make.width.equalTo(self.sv.mas_width);
                            make.height.equalTo(self.sv.mas_width).multipliedBy(t);
                        }];
                        [imageView setUserInteractionEnabled:YES];
                        
//                        UILabel *name = [[UILabel alloc] init];
//                        [imageView addSubview:name];
//                        [name mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.equalTo(imageView.mas_top).offset(10);
//                            make.left.equalTo(imageView.mas_left).offset(10);
//                        }];
//                        name.text = sm.name;
//                        [name setTextColor:[UIColor blackColor]];
//                        [name setFont:[UIFont fontWithName:@"Helvetica" size:18]];
//                        UIImageView *cell = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellSpaceImage"]];
//                        [imageView addSubview:cell];
//                        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.equalTo(name.mas_bottom).offset(10);
//                            make.left.equalTo(name.mas_left);
//                        }];
//                        UILabel *price = [[UILabel alloc] init];
//                        [imageView addSubview:price];
//                        [price mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(cell.mas_right).offset(5);
//                            make.top.equalTo(cell.mas_top);
//                        }];
//                        price.text = [NSString stringWithFormat:@"金额 %d 元",sm.retail];
//                        [price setTextColor:[UIColor blackColor]];
//                        [price setFont:[UIFont fontWithName:@"Helvetica" size:8]];
//                        UILabel *object = [[UILabel alloc] init];
//                        [imageView addSubview:object];
//                        [object mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(price.mas_left);
//                            make.top.equalTo(price.mas_bottom).offset(5);
//                        }];
//                        NSString *temp1 = @"适用对象：";
//                        object.text = [temp1 stringByAppendingString:sm.age_type];
//                        [object setTextColor:[UIColor blackColor]];
//                        [object setFont:[UIFont fontWithName:@"Helvetica" size:8]];
//                        UILabel *cost = [[UILabel alloc] init];
//                        [imageView addSubview:cost];
//                        [cost mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(name.mas_left);
//                            make.top.equalTo(object.mas_bottom).offset(5);
//                        }];
//                        cost.text = [NSString stringWithFormat:@"内部折扣价：¥%d",sm.cost];
//                        [cost setTextColor:[UIColor orangeColor]];
                        
                        UIButton *temp = [[UIButton alloc] init];
                        [imageView addSubview:temp];
                        [temp mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.edges.equalTo(imageView);
                        }];
                        [temp addTarget:self action:@selector(clickImageView) forControlEvents:UIControlEventTouchUpInside];
                        self.lastView = imageView;
                    }
                }
                if (self.tempMuta.count >= 2) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrollPicture) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
                }
            } else {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:defaultImage];
                [container addSubview:imageView];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(container.mas_left);
                    make.top.equalTo(container.mas_top);
                    make.width.equalTo(self.sv.mas_width);
                    make.height.equalTo(self.sv.mas_width).multipliedBy(t);
                }];
            }
            [container mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.sv);
                make.height.equalTo(self.sv);
                make.width.equalTo(self.sv).multipliedBy(self.tempMuta.count);
            }];
            self.pc = [[UIPageControl alloc] init];
            [self addSubview:self.pc];
            [self.pc mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.sv.mas_bottom).offset(5);
                make.height.mas_equalTo(image1.size.height);
            }];
            self.pc.numberOfPages = (int)self.tempMuta.count;
            self.pc.currentPage = 0;
            [self.pc setPageIndicatorTintColor:[UIColor whiteColor]];
            [self.pc setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
        } failureHandler:^(NSString *errorInfo) {
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setImage:defaultImage];
            [container addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(container.mas_left);
                make.bottom.equalTo(container.mas_bottom);
                make.width.equalTo(self.sv.mas_width);
                make.height.equalTo(self.sv.mas_width).multipliedBy(t);
            }];
            [container mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.sv);
                make.height.equalTo(self.sv);
                make.width.equalTo(self.sv);
            }];
            self.pc = [[UIPageControl alloc] init];
            [self addSubview:self.pc];
            [self.pc mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.sv.mas_bottom).offset(5);
                make.height.mas_equalTo(image1.size.height);
            }];
            self.pc.numberOfPages = (int)self.tempMuta.count;
            self.pc.currentPage = 0;
            [self.pc setPageIndicatorTintColor:[UIColor whiteColor]];
            [self.pc setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
            self.lastView = imageView;
            NSLog(@"error :%@",errorInfo);
            
        }];
        
        self.sv.showsHorizontalScrollIndicator = NO;
        
        //[self.pc setImagePageStateNormal:image1 andHight:image2];
        
        
        self.chooseButton = [UIButton new];
        self.chooseButton.layer.cornerRadius = 3;
        self.chooseButton.layer.masksToBounds = YES;
        UIImage *DownArrow = [UIImage imageNamed:@"Down arrow"];
        UIImageView *DAView = [[UIImageView alloc] initWithImage:DownArrow];
        chooseLabel = [UILabel new];
        chooseLabel.text = @"全部套餐";
        [self.chooseButton addSubview:chooseLabel];
        [self.chooseButton addSubview:DAView];
        [chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.chooseButton);
            make.left.equalTo(self.chooseButton).offset(3);
            make.width.mas_equalTo(@70);
        }];
        [DAView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(chooseLabel.mas_right).offset(5);
            make.centerY.equalTo(chooseLabel.mas_centerY);
        }];
        [self addSubview:self.chooseButton];
        [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(manLabel.mas_centerY);
            make.right.equalTo(self.sv.mas_right);
            make.height.equalTo(self.manSel).offset(5);
            make.width.mas_equalTo(@95);
        }];
        
        [self.chooseButton setBackgroundColor:[UIColor whiteColor]];
        [self.chooseButton addTarget:self action:@selector(chooseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        self.chooseView = [[UIView alloc] init];
        [self addSubview:self.chooseView];
        [self.chooseView setBackgroundColor:[UIColor whiteColor]];
        self.chooseView.alpha = 0;
        self.chooseView.layer.masksToBounds = YES;
        
        UIButton *button1 = [UIButton new];
        button1.tag = 1;
        [button1 setTitle:@"全部套餐" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button1.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
        [self.chooseView addSubview:button1];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.chooseView.mas_top).offset(3);
            make.right.equalTo(self.chooseView.mas_right).offset(1);
            make.left.equalTo(self.chooseView.mas_left).offset(-1);
            make.height.mas_equalTo(self.chooseButton.mas_height).offset(10);
        }];
        [button1 addTarget:self action:@selector(subChooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *button2 = [UIButton new];
        button2.tag = 2;
        [button2 setTitle:@"标准套餐" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button2.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
        [self.chooseView addSubview:button2];
        [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button1.mas_bottom).offset(-1);
            make.right.equalTo(self.chooseView.mas_right).offset(1);
            make.left.equalTo(self.chooseView.mas_left).offset(-1);
            make.height.mas_equalTo(self.chooseButton.mas_height).offset(10);
        }];
        button2.layer.borderWidth = 1;
        button2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [button2 addTarget:self action:@selector(subChooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *button3 = [UIButton new];
        button3.tag = 3;
        [button3 setTitle:@"特色套餐" forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button3.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button3.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
        [self.chooseView addSubview:button3];
        [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button2.mas_bottom).offset(-1);
            make.right.equalTo(self.chooseView.mas_right).offset(1);
            make.left.equalTo(self.chooseView.mas_left).offset(-1);
            make.height.mas_equalTo(self.chooseButton.mas_height).offset(10);
        }];
        button3.layer.borderWidth = 1;
        button3.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [button3 addTarget:self action:@selector(subChooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *button4 = [UIButton new];
        button4.tag = 4;
        [button4 setTitle:@"免费套餐" forState:UIControlStateNormal];
        [button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button4.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        button4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button4.contentEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
        [self.chooseView addSubview:button4];
        [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button3.mas_bottom).offset(-1);
            make.right.equalTo(self.chooseView.mas_right).offset(1);
            make.left.equalTo(self.chooseView.mas_left).offset(-1);
            make.height.mas_equalTo(self.chooseButton.mas_height).offset(10);
        }];
        button4.layer.borderWidth = 1;
        button4.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [button4 addTarget:self action:@selector(subChooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.chooseButton.mas_bottom).offset(-3);
            make.left.equalTo(self.chooseButton.mas_left);
            make.right.equalTo(self.chooseButton.mas_right);
            make.bottom.equalTo(button4.mas_bottom).offset(-1);
        }];
        height = ([UIScreen mainScreen].bounds.size.width-20)*t+notselImage.size.height+image1.size.height+25;
    }
    return self;
}

-(void)clicked:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    if (temp.tag == 1) {
        sexTag = 2;//不为女所以是2
        self.manSel.selected = YES;
        self.womanSel.selected = NO;
        self.allSel.selected = NO;
    } else if(temp.tag == 2) {
        sexTag = 1;//不为男所以是1
        self.manSel.selected = NO;
        self.womanSel.selected = YES;
        self.allSel.selected = NO;
    } else {
        sexTag = 3;
        self.manSel.selected = NO;
        self.womanSel.selected = NO;
        self.allSel.selected = YES;
    }
    [_delegate ClickedManOrWomanWithTag:temp.tag];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.pc.currentPage = currentPage;
}

-(void)chooseButtonClicked
{
    [UIView animateWithDuration:0.2 animations:^{
        if (self.chooseView.alpha <= 0.5) {
            self.chooseView.alpha = 1;
        }else {
            self.chooseView.alpha = 0;
        }
    }];
}

-(void)setDelegate:(id)delegate
{
    _delegate = delegate;
}

-(void)subChooseButtonClicked:(id)sender
{
    UIButton *temp = (UIButton *)sender;
    chooseLabel.text = temp.titleLabel.text;
    self.chooseView.alpha = 0;
    [_delegate ClickedChooseButtonWithTag:temp.tag];
}

-(void)scrollPicture
{
    currentPage = self.sv.contentOffset.x/self.sv.frame.size.width;
    if (currentPage == self.tempMuta.count-1) {
        currentPage = 0;
    }
    else {
        currentPage++;
    }
    [self.sv setContentOffset:CGPointMake(self.sv.frame.size.width*currentPage, self.sv.contentOffset.y) animated:YES];
}

-(void)clickImageView
{
    [_delegate ClickedImageViewWithModel:[self.tempMuta objectAtIndex:currentPage]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.chooseView.alpha = 0;
    }];
}


@end
