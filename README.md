# JSAPI
use AFNetworking and MJExsion to package the URL, so that we can more easily to complete net request  
<pre>
JSRequest *request = [[JSRequest alloc] init];
request.httpMethod = APIHttpMethodGET;
request.requestUrl = @"http://wthrcdn.etouch.cn/weather_mini?citykey=101010100";

[JSAPI request:request success:^(id response) {
NSLog(@"%@",response);
} failure:^(NSError *error) {
NSLog(@"%@",error);
}];
</pre>

when you want to upload file,you can use object to upload file 
<pre>
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
    // fileArray  文件上传的信息  file information
    // postArray  文件POST的数据 file data
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
</pre>




when you want to download file,user it to down

<pre>
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
</pre>

