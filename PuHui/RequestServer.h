//
//  SoapRequestServer.h
//  NetDemo
//
//  Created by ji junjie on 15/5/14.
//  Copyright (c) 2015年 蓝鳍. All rights reserved.
//

#import "BaseService.h"

typedef enum : NSUInteger {
    PuhuiQD,//普惠渠道
    PuhuiJK,//普惠健康
    PuhuiYW //普惠业务
} PuhuiRequestType;

@interface RequestServer : BaseService

//请求数据 - 类方法
/**
 *  获取网络数据
 *
 *  @param methodName                    方法名
 *  @param parameters                    参数
 *  @param shouldDisplayLoadingIndicator 是否显示加载器
 *  @param puhuiRequestType              请求类型（渠道、健康、业务）
 *  @param successHandler                成功
 *  @param failureHandler                失败
 */
+ (void)fetchMethodName:(NSString *)methodName
             parameters:(id)parameters
shouldDisplayLoadingIndicator:(BOOL)shouldDisplayLoadingIndicator puhuiRequestType:(PuhuiRequestType)puhuiRequestType
         successHandler:
(void (^)(NSMutableDictionary *responseDic))successHandler failureHandler:(void (^)(NSString *errorInfo))failureHandler;

//请求数据
- (void)fetch_MethodName:(NSString *)methodName
              parameters:(id)parameters
shouldDisplayLoadingIndicator:(BOOL)shouldDisplayLoadingIndicator puhuiRequestType:(PuhuiRequestType)puhuiRequestType
          successHandler:
(void (^)(NSMutableDictionary *responseDic))successHandler failureHandler:(void (^)(NSString *errorInfo))failureHandler;
@end
