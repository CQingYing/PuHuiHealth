//
//  QuestionDetailController.h
//  PuHui
//
//  Created by rp.wang on 15/7/15.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionDetailModel.h"
#import "QuestionModel.h"


@interface QuestionDetailController : UIViewController<UIAlertViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) NSString *questionId;
@property (strong, nonatomic) QuestionDetailModel *questionDetailData;
@property (strong, nonatomic) NSString *whereComeIn; //"0"提问进来,"1"受理进来."2"完成进来
@property (nonatomic) NSString *gender;
@property (nonatomic) NSString *age;
@end
