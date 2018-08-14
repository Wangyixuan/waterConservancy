//
//  YXNetTool.m
//  河掌治
//
//  Created by liu on 2018/3/23.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXNetTool.h"


@interface YXNetTool()
@property(nonatomic , strong) AFHTTPSessionManager * httpManger;
@property(nonatomic , strong) AFURLSessionManager  * urlManager;
//判断网络
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

typedef NS_ENUM(NSInteger,returnType){
    NonetReturnType = 0,
    NetReturnType   = 1
};
@end

@implementation YXNetTool

typedef NS_ENUM(NSInteger,RequestType){
    RequestTypeGet,
    RequestTypePost,
    
};

+ (instancetype)shareTool
{
    static YXNetTool *_netManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _netManager = [[YXNetTool alloc] init];
        _netManager.httpManger = [AFHTTPSessionManager manager];
        _netManager.httpManger.requestSerializer = [AFJSONRequestSerializer serializer];
        [_netManager.httpManger.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        _netManager.httpManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain",nil];
        _netManager.httpManger.requestSerializer.timeoutInterval = 5;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _netManager.urlManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    });
    return _netManager;
}

+(void)XWWWRequestWithURL:(NSString *)URLStr Parmars:(NSString *)Parmarstr  success:(successBlock)success faild:(faildBlock)faild{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain",nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URLStr]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[Parmarstr dataUsingEncoding:NSUTF8StringEncoding]];
//    NSOperation *operation = manager
    NSURLSessionConfiguration *sessionCon = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionCon];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",error);
            if (error) {
                if (faild) {
                    faild(error);
                }
                
            }else{
                if (success) {
                     success(data);
                }
               
            }
        });
       
        
       
    }];
    
    
    [dataTask resume];
}

-(void)getRequestWithURL:(NSString *)URL Parmars:(NSDictionary *)Parmars  success:(successBlock)success faild:(faildBlock)faild{
    
    NSLog(@"get请求的url是%@",URL);
    URL=[URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self.httpManger GET:URL parameters:Parmars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
             success(responseObject);
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (faild) {
            faild(error);
        }
    }];
    

}


-(void)postRequestWithURL:(NSString *)URL Parmars:(NSDictionary *)Parmars  success:(successBlock)success faild:(faildBlock)faild{
    
    URL=[URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"posturl===%@",URL);
    [self.httpManger POST:URL parameters:Parmars progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (faild) {
            faild(error);
        }
    }];
}
- (void)SOAPData:(NSString *)url password:(NSString *)password userName:(NSString *)userName success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    NSString *soapStr =[NSString stringWithFormat:@"<v:Envelope xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:d=\"http://www.w3.org/2001/XMLSchema\" xmlns:c=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:v=\"http://schemas.xmlsoap.org/soap/envelope/\"><v:Header /><v:Body><n0:isUamsValidPhoneUserByPhoneOrCodeOrName id=\"o0\" c:root=\"1\" xmlns:n0=\"http://userext.service.uumsext.dhcc.com.cn/\"><arg1 i:type=\"d:string\">%@</arg1><arg0 i:type=\"d:string\">%@</arg0></n0:isUamsValidPhoneUserByPhoneOrCodeOrName></v:Body></v:Envelope>",password,userName];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 30;
    
    // 返回NSData
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置请求头，也可以不设置
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%zd", soapStr.length] forHTTPHeaderField:@"Content-Length"];
    
    // 设置HTTPBody
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
        return soapStr;
    }];
    [manager POST:url parameters:soapStr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 把返回的二进制数据转为字符串
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
        // 利用正则表达式取出<score></score>之间的字符串
        NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"(?<=scode>).*?(?=</scode)" options:NSRegularExpressionCaseInsensitive error:nil];
        //储存此人身份数组
        NSMutableArray *scodeArray = [NSMutableArray array];
        for (NSTextCheckingResult *checkingResult in [regular matchesInString:result options:0 range:NSMakeRange(0, result.length)]) {
            NSString *scodeStr =  [result substringWithRange:checkingResult.range];
            [scodeArray addObject:scodeStr];
        }
        // 请求成功并且结果有值把结果传出去
        if (success) {
            success(scodeArray);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


#pragma mark -- 处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}

+ (NSString *)translatePassword:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    //转化为小写
    NSString *lowerStr = [hexStr lowercaseString];
    lowerStr = [lowerStr stringByReplacingOccurrencesOfString:@"2" withString:@"g"];
    lowerStr = [lowerStr stringByReplacingOccurrencesOfString:@"6" withString:@"z"];
    lowerStr = [lowerStr stringByReplacingOccurrencesOfString:@"8" withString:@"m"];
    lowerStr = [lowerStr stringByReplacingOccurrencesOfString:@"d" withString:@"q"];
    return lowerStr;
}


@end
