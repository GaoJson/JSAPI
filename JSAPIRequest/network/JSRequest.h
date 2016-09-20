//
//  JSRequest.h
//  JSAPIRequest
//
//  Created by Macx on 16/9/20.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSRequest : NSObject
@property (nonatomic, strong) NSString *httpMethod;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, assign) NSString *timeoutInterval;
@property (nonatomic, strong) id params;
@end

@interface UserInfoRequest : JSRequest
@property (nonatomic, assign) NSInteger userId;
@end