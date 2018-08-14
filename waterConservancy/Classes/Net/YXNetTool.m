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
