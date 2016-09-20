//
//  JSRequest.m
//  JSAPIRequest
//
//  Created by Macx on 16/9/20.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import "JSRequest.h"

@implementation JSRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestUrl = @"";
        self.httpMethod = @"POST";
        self.timeoutInterval = @"30";
    }
    return self;
}
@end

@implementation UserInfoRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestUrl = @"app/UserInfo";
    }
    return self;
}
@end