//
//  ViewController.m
//  JSAPIRequest
//
//  Created by Macx on 16/9/20.
//  Copyright © 2016年 gaojs. All rights reserved.
//

#import "ViewController.h"
#import "JSAPI.h"
#import "JSRequest.h"
#import "MJExtension.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)request:(id)sender {
    UserInfoRequest *request = [[UserInfoRequest alloc] init];
    request.httpMethod = @"GET";
    request.requestUrl = @"http://www.weather.com.cn/data/sk/101010100.html";
    [JSAPI request:request success:^(id response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (IBAction)uploadFile:(id)sender {
    UIImage *image = [UIImage imageNamed:@"demo"];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSMutableArray *fileArray = [NSMutableArray array];
    NSMutableArray *postArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 5;  i++) {
        JSUploadFileUtil *model = [[JSUploadFileUtil alloc] init];
        model.imageWidth = image.size.width;
        model.imageHeight = image.size.height;
        model.formName = [NSString stringWithFormat:@"file__%ld",i];
        model.fileName = [NSString stringWithFormat:@"fileName__%ld",i];
        model.fileType = @"image/jepg";
        [postArray addObject:model.mj_keyValues];
        model.files = imageData;
        [fileArray addObject:model];
    }
    
    // fileArray  文件上传的信息
    // postArray  文件POST的数据
    // requestUrl 本地服务器地址  php 进行环境测试
    
    JSUploadFileRequest *request = [[JSUploadFileRequest alloc] init];
    request.userId = @"100";
    request.requestUrl = @"http://127.0.0.1/myfirstphp/index.php";
    request.params = [postArray mj_JSONString];
    
    [JSAPI uploadFileRequest:request fileArray:fileArray success:^(id response) {
        NSLog(@"%@",response);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
