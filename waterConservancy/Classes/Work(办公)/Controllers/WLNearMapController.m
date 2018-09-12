//
//  WLNearMapController.m
//  waterConservancy
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLNearMapController.h"
#import <WebKit/WebKit.h>
#import <CoreLocation/CoreLocation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WLNearMapController ()<CLLocationManagerDelegate,UIWebViewDelegate>
@property (nonatomic, strong)  UIWebView *webView;

@property (nonatomic, strong) CLLocationManager *locManager;
@property (nonatomic, strong) CLLocation *userLoc;

@property (strong, nonatomic) JSContext *context;
@end

@implementation WLNearMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近隐患";
    // Do any additional setup after loading the view.
//    _locArr = [NSMutableArray array];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
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
        }else{
            CLLocation *loc = [locations firstObject];
            NSString *updateCurrentPoint = [NSString stringWithFormat:@"updateCurrentPoint(%f,%f)",loc.coordinate.longitude , loc.coordinate.latitude];
            [_context evaluateScript:updateCurrentPoint];
            
//            NSString *locStr =[NSString stringWithFormat:@"%f,%f",loc.coordinate.longitude , loc.coordinate.latitude];
////            [_locArr addObject:locStr];
//            NSDictionary *dic3 =@{@"type":@"Feature"};
//            NSDictionary *dic =@{@"HYDC":@"FB010001",
//                                 @"Name":@"长江",
//                                 @"OBJ_CODE":@"FB010001",
//                                 @"OBJ_NAME":@"长江",
//                                 @"UserID":@(0)
//                                 };
//            NSDictionary *dic2 = @{@"properties":dic};
//            NSDictionary *dic1 = @{@"type":@"LineString",
//                                   @"coordinates":_locArr
//                                   };
//            NSArray *features = @[dic1,dic2,dic3];
//            NSDictionary *jsonDic = @{@"type":@"FeatureCollection",
//                                      @"features":features
//                                      };
//            NSString *jsonStr = [jsonDic jsonStringEncoded];
//            NSLog(@"%@",jsonStr)
//            NSString *updateCurrentLine = [NSString stringWithFormat:@"updateCurrentLine(%@)",jsonStr];
//            [_context evaluateScript:updateCurrentLine];
            
        }
    }
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"loc error %@",error);
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *showMap = [NSString stringWithFormat:@"showMap(%f,%f)",self.userLoc.coordinate.longitude , self.userLoc.coordinate.latitude];
    //    NSString *showMap = @"showMap(116.35399257796078,39.88702198584958)";
    [_context evaluateScript:showMap];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


@end
