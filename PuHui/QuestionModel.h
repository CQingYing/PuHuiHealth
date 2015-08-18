//
//  QuestionModel.h
//  PuHui
//
//  Created by administrator on 15/7/29.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject
/**问题id*/
@property (copy, nonatomic)  NSString  * questionId;
/**问题内容*/
@property (copy,nonatomic)   NSString * content;
/**年龄*/
@property (copy,nonatomic)   NSString * age;
/**性别 1: 男2：女*/
@property (copy,nonatomic)   NSString * gender;
//**科室(当前版本为空)*/
@property (copy, nonatomic)  NSString  * department;
/**状态*/
@property (copy, nonatomic)  NSString * status;
/**受理专家*/
@property (copy, nonatomic)  NSString * expert;
/**问题图片*/
@property (copy, nonatomic)  NSString * pic;
/**未读*/
@property  (copy,nonatomic)  NSString * unread;
/**提问时间*/
@property  (copy, nonatomic)  NSString * create_date;
/**受理时间*/
@property (copy, nonatomic)  NSString * accept_date;

@end
