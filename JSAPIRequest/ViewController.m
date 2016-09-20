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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UserInfoRequest *request = [[UserInfoRequest alloc] init];
    request.httpMethod = @"GET";
    request.requestUrl = @"http://www.weather.com.cn/data/sk/101010100.html";
    [JSAPI request:request success:^(id response) {
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
