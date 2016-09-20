//
//  JSAPI.m
//  JSAPIRequest
//
//  Created by Macx on 16/9/20.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import "JSAPI.h"
#import "MJExtension.h"
@implementation JSAPI

+ (void)request:(JSRequest *)request success:(void (^)(id response))success failure:(void (^)(NSError *error))failue {
    JSRequest *param = [[JSRequest alloc] init];
    param.httpMethod = request.httpMethod;
    param.requestUrl = request.requestUrl;
    param.timeoutInterval = request.timeoutInterval;
    request.httpMethod = nil;
    request.timeoutInterval = nil;
    request.httpMethod = nil;
    param.params = request.mj_keyValues;
    if ( [param.httpMethod isEqualToString:@"GET"] ) {
        [JSAPI GET_Request:param success:success failure:failue];
    }else if ( [param.httpMethod isEqualToString:@"POST"] ) {
        [JSAPI POST_Request:param success:success failure:failue];
    }
}

+ (void)POST_Request:(JSRequest *)request success:(void (^)(id response))success failure:(void (^)(NSError *error))failue {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = [request.timeoutInterval integerValue]?:60;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    manager.securityPolicy = security;
    NSString *requestUrl = @"";
    if ([request.requestUrl rangeOfString:@"http://"].length) {
        requestUrl = request.requestUrl;
    }else{
        requestUrl = [URL_Release stringByAppendingString:request.requestUrl];
    }
    [manager POST:requestUrl parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failue(error);
    }];
}

+ (void)GET_Request:(JSRequest *)request success:(void (^)(id response))success failure:(void (^)(NSError *error))failue {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = [request.timeoutInterval integerValue]?:60;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    manager.securityPolicy = security;
    
    NSString *requestUrl = @"";
    if ([request.requestUrl rangeOfString:@"http://"].length) {
       requestUrl = request.requestUrl;
    }else{
       requestUrl = [URL_Release stringByAppendingString:request.requestUrl];
    }
    [manager GET:requestUrl parameters:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             success(data);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             failue(error);
         }];
}

@end
