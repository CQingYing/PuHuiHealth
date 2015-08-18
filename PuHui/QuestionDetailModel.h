//
//  QuestionDetailModel.h
//  PuHui
//
//  Created by administrator on 15/7/31.
//  Copyright (c) 2015年 Lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionDetailModel : NSObject
/**提问id*/
@property (strong, nonatomic)  NSString  * questionId;
/**详细id*/
@property (strong, nonatomic)  NSString  * detailId;
/**顺序*/
@property (strong, nonatomic)  NSString  * order;
/**类型*/
@property (strong, nonatomic)  NSString  * type;
/**提问／答复内容*/
@property (strong, nonatomic)  NSString  * content;
/**提问者*/
@property (strong, nonatomic)  NSString  * asker;
/**回复专家*/
@property (strong, nonatomic)  NSString  * expert;
/**提问图片*/
@property (strong, nonatomic)  NSString  * pic;
/**提问／答复时间*/
@property (strong, nonatomic)  NSString  * create_date;
@end
