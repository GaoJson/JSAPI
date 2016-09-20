//
//  JSAPI.h
//  JSAPIRequest
//
//  Created by Macx on 16/9/20.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSRequest.h"
#import "AFNetworking.h"

#define URL_Debug @"127.0.0.1/"
#define URL_Release @"127.0.0.1/"


@interface JSAPI : NSObject

+ (void)request:(JSRequest *)request success:(void (^)(id response))success failure:(void (^)(NSError *error))failue;


@end