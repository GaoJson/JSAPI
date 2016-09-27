//
//  JSRequest.h
//  JSAPIRequest
//
//  Created by Macx on 16/9/20.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JSRequest : NSObject
@property (nonatomic, strong) NSString *httpMethod;
@property (nonatomic, strong) NSString *requestUrl;
@property (nonatomic, assign) NSString *timeoutInterval;
@property (nonatomic, strong) id params;
@end

@interface JSUploadFileRequest : JSRequest
@property (strong, nonatomic) NSString *userId;
@end


/**
 * 文件格式
 */
@interface JSUploadFileUtil : NSObject
@property (strong, nonatomic) NSString *formName;   // file 字段
@property (strong, nonatomic) NSString *fileName;   // 文件名
@property (strong, nonatomic) NSString *fileType;   // type = "image/jpeg";
@property (strong, nonatomic) NSData *files;             // 文件数据 NSData 类型
@property (assign, nonatomic) CGFloat imageWidth;   
@property (assign, nonatomic) CGFloat imageHeight;
@end

@interface UserInfoRequest : JSRequest
@property (nonatomic, assign) NSInteger userId;
@end