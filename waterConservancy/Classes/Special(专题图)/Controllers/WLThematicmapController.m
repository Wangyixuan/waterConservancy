//
//  WLThematicmapController.m
//  waterConservancy
//
//  Created by liu on 2018/9/18.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLThematicmapController.h"
#import <WebKit/WebKit.h>
#import <CoreLocation/CoreLocation.h>
//#import <JavaScriptCore/JavaScriptCore.h>

@interface WLThematicmapController ()<CLLocationManagerDelegate,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)  WKWebView *webView;

@property (nonatomic, strong) CLLocationManager *locManager;
@property (nonatomic, strong) CLLocation *userLoc;

//@property (strong, nonatomic) JSContext *context;
@end

@implementation WLThematicmapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近隐患";
    //    _locArr = [NSMutableArray array];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"getgeoInfo"];
    [self.view addSubview:_webView];
    
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    [self.locManager requestWhenInUseAuthorization];
    [self.locManager startUpdatingLocation];
    
    //    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%@",locations);
    if (locations.count>0) {
        if (!self.userLoc) {
            [self.locManager stopUpdatingLocation];
            self.userLoc = [locations firstObject];
            NSString *mainBundlePath = [[NSBundle mainBundle] bundlePath];//文件根路径
            NSString *basePath = [NSString stringWithFormat:@"%@/assets",mainBundlePath];//获取目标html文件夹路径
            NSURL *baseUrl = [NSURL fileURLWithPath:basePath isDirectory:YES];//转换成url
            NSString *htmlPath = [NSString stringWithFormat:@"%@/mobile_show_nearly_info.html",basePath];//目标 文件路径
            NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];//把html文件转换成string类型
            [self.webView loadHTMLString:htmlString baseURL:baseUrl];//加载
        }
    }
}

- (void)webView:(WKWebView *)tmpWebView didFinishNavigation:(WKNavigation *)navigation{
    //显示地图
    NSString *showMap = [NSString stringWithFormat:@"showMap(%f,%f)",self.userLoc.coordinate.longitude , self.userLoc.coordinate.latitude];
    NSString *latStr = [NSString stringWithFormat:@"%f",self.userLoc.coordinate.latitude];
    NSString *lonStr = [NSString stringWithFormat:@"%f",self.userLoc.coordinate.longitude];
    [self.webView evaluateJavaScript:showMap completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        [self mapShowlat:latStr lon:lonStr];
        NSLog(@"%@\n error==%@",result,error);
        
    }];
}

-(void)mapShowlat:(NSString *)lat lon:(NSString *)lon{
    //获得图层数据
    NSMutableString *sb = [[NSMutableString alloc]init];
    [sb appendString:@"{\"type\":\"FeatureCollection\",\"features\":[{\"geometry\":{\"coordinates\":["];
    [sb appendString:lon];
    [sb appendString:@","];
    [sb appendString:lat];
    [sb appendString:@"],\"type\":\"Point\"},\"properties\":{\"HYDC\":\"FB010001\",\"Name\":\"长江\",\"OBJ_CODE\":\"FB010001\",\"OBJ_NAME\":\"长江\",\"UserID\":0},\"type\":\"Feature\"}]}"];
    //    sb = @"\{\"type\":\"FeatureCollection\",\"features\":[{\"geometry\":{\"coordinates\":[116.35395964354248,39.887023040434634],\"type\":\"Point\"},\"properties\":{\"HYDC\":\"FB010001\",\"Name\":\"长江\",\"OBJ_CODE\":\"FB010001\",\"OBJ_NAME\":\"长江\",\"UserID\":0},\"type\":\"Feature\"}]}";
    //    NSLog(@"%@",sb);
    NSString *newSb = [self noWhiteSpaceString:sb];
    NSString *mapGeoInfo = [NSString stringWithFormat:@"getNearGEOInfo(%@,%@)", newSb, @"20"];
    [self.webView evaluateJavaScript:mapGeoInfo completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        NSLog(@"%@\n error==%@",result,error);
        
    }];
}
//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSDictionary *headers = @{ @"Content-Type": @"application/json",
                               @"Cache-Control": @"no-cache",
                               @"Postman-Token": @"cb0201bd-49b0-40bd-a1d3-4176602283b0" };
    NSDictionary *parameters = @{ @"requestData": @{ @"typeList": @[ @"CWS" ], @"radius": @10, @"targetId": @"search.GeoSearchLogic", @"geo": @"{\"type\":\"Point\",\"coordinates\":[108.9829419,22.796416]}" } };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.11:8088/WEGIS-00-WEB_SERVICE/WSWebService"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                    NSLog(@"%@", error);
            } else {
                NSString *resStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",resStr);
                NSString *showNearInfo = [NSString stringWithFormat:@"showNearInfo(%@)",resStr];
                NSLog(@"%@",showNearInfo);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.webView evaluateJavaScript:showNearInfo completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                        
                        NSLog(@"%@\n error==%@",result,error);
                        
                    }];
                });
                
                
                
            }
        }];
    
    [dataTask resume];
    
}



- (NSString *)noWhiteSpaceString:(NSString *)string{
    NSString *newString = string;
    //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 可以去掉空格，注意此时生成的strUrl是autorelease属性的，所以不必对strUrl进行release操作！
    return newString;
    
}

@end
