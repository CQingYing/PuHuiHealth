//
//  SoapRequestServer.m
//  NetDemo
//
//  Created by ji junjie on 15/5/14.
//  Copyright (c) 2015年 蓝鳍. All rights reserved.
//

#import "RequestServer.h"
#import "AFNetworking.h"

@implementation RequestServer

+ (void)fetchMethodName:(NSString *)methodName parameters:(id)parameters shouldDisplayLoadingIndicator:(BOOL)shouldDisplayLoadingIndicator puhuiRequestType:(PuhuiRequestType)puhuiRequestType successHandler:(void (^)(NSMutableDictionary *))successHandler failureHandler:(void (^)(NSString *))failureHandler
{
    [[[self alloc] init] fetch_MethodName:methodName parameters:parameters shouldDisplayLoadingIndicator:shouldDisplayLoadingIndicator puhuiRequestType:puhuiRequestType successHandler:successHandler failureHandler:failureHandler];
}

- (void)fetch_MethodName:(NSString *)methodName
             parameters:(id)parameters
shouldDisplayLoadingIndicator:(BOOL)shouldDisplayLoadingIndicator puhuiRequestType:(PuhuiRequestType)puhuiRequestType
         successHandler:
(void (^)(NSMutableDictionary *responseDic))successHandler failureHandler:(void (^)(NSString *errorInfo))failureHandler
{
    
    if (shouldDisplayLoadingIndicator) {
        [self displayLoadingIndicator];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *requestUrl = @"";
    switch (puhuiRequestType) {
        case PuhuiQD:
        {
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            manager.requestSerializer.stringEncoding = enc;
            requestUrl = PHQDRequestUrl;
        }
            break;
            
        case PuhuiJK:
        {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            requestUrl = PHJKRequestUrl;
        }
            break;
            
        case PuhuiYW:
        {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            requestUrl = PHYWRequestUrl;
        }
            break;
            
        default:
            break;
    }
    if ([requestUrl isEqualToString:@""]) {
        [self showAlert:@"请求地址错误"];
        return;
    }

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",nil];
    NSString *url = [NSString stringWithFormat:@"%@%@.action",requestUrl,methodName];
    
    //发送请求
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (shouldDisplayLoadingIndicator) {
            [self dismissLoadingIndicator];
        }
        if (successHandler) {
            successHandler(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (shouldDisplayLoadingIndicator) {
            [self dismissLoadingIndicator];
        }
        if (failureHandler) {
            failureHandler(error.localizedDescription);
        }
    }];

}

@end
