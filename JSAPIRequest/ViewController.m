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
#define document_path  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"%@  %@",paths,NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) );
}

- (IBAction)request:(id)sender {
    UserInfoRequest *request = [[UserInfoRequest alloc] init];
    request.httpMethod = APIHttpMethodPOST;
    request.requestUrl = @"http://www.weather.com.cn/data/sk/101010100.html";
    
    /**  1 **/
    request.userId = 21;
    /**  2  **/
    
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
    
    [JSAPI uploadFileRequest:request fileArray:fileArray progress:^(NSProgress *progress) {
        NSLog(@"progress=%f",progress.fractionCompleted);
    } success:^(id response) {
        NSLog(@"response=%@",response);
    } failure:^(NSError *error) {
        NSLog(@"response=%@",error);
    }];
}


- (IBAction)download:(UIButton *)sender {
    JSUploadFileRequest *request = [[JSUploadFileRequest alloc] init];
    request.requestUrl = @"http://127.0.0.1/123123.7z";
    NSString *pathName = @"address.doc";
    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [homePath stringByAppendingFormat:@"/%@",pathName];
    
    [JSAPI downLoadFileRequest:request downloadFilePath:path progress:^(NSProgress *downloadProgress) {
        NSLog(@"%f",downloadProgress.fractionCompleted);
    } success:^(id response) {
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
