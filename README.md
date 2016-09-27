# JSAPI
use AFNetworking and MJExsion to package the URL, so that we can more easily to complete net request  
<pre>
    UserInfoRequest *request = [[UserInfoRequest alloc] init];
    request.httpMethod = @"GET";
    request.requestUrl = @"http://www.weather.com.cn/data/sk/101010100.html";
    [JSAPI request:request success:^(id response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
     NSLog(@"%@",error);
    }];
</pre>
