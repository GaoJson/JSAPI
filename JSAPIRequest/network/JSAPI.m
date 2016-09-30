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

+ (void)GET_Request:(JSRequest *)request
            success:(void (^)(id response))success
            failure:(void (^)(NSError *error))failue {
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

+ (void)uploadFileRequest:(JSRequest *)request fileArray:(NSArray *)fileArray progress:(void (^)(NSProgress *progress))progress success:(void (^)(id response))success failure:(void (^)(NSError *error))failue {
    NSString *requestUrl = request.requestUrl;
    request.requestUrl = nil;
    request.httpMethod = nil;
    request.timeoutInterval = nil;
    request.httpMethod = nil;
    request.params = request.mj_keyValues;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    manager.securityPolicy = security;
    [manager POST:requestUrl parameters:request.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (fileArray.count) {
            for (JSUploadFileUtil *model in fileArray) {
                [formData appendPartWithFileData:model.files
                                            name:model.formName
                                        fileName:model.fileName
                                        mimeType:model.fileType];
            }
        }
    } progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id data = [NSJSONSerialization JSONObjectWithData:responseObject
                                                  options:NSJSONReadingMutableContainers
                                                    error:nil];
        success(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failue(error);
    }];
}

+(void)downLoadFileRequest:(JSRequest *)request downloadFilePath:(NSString *)fileName progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock success:(void (^)(id response))success failure:(void (^)(NSError *error))failue{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *security = [AFSecurityPolicy defaultPolicy];
    security.allowInvalidCertificates = YES;
    security.validatesDomainName = NO;
    manager.securityPolicy = security;
    NSURLRequest *requests = [NSURLRequest requestWithURL:[NSURL URLWithString:request.requestUrl]];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:requests progress:downloadProgressBlock destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
      
        return [NSURL fileURLWithPath:fileName];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failue(error);
        }else{
            success(response);
        }
    }];
    [task resume];
}


@end
