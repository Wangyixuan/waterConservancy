//
//  WLOnSpotMapViewController.m
//  waterConservancy
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLOnSpotMapViewController.h"
#import <WebKit/WebKit.h>
#import <CoreLocation/CoreLocation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WLOnSpotMapViewController ()<CLLocationManagerDelegate,UIWebViewDelegate>
@property (nonatomic, strong)  UIWebView *webView;

@property (nonatomic, strong) CLLocationManager *locManager;
@property (nonatomic, strong) CLLocation *userLoc;

@property (strong, nonatomic) JSContext *context;
@property (nonatomic, weak) UIButton *startBtn;
@property (nonatomic, weak) UIButton *endBtn;
@property (nonatomic, weak) UIButton *hiddBtn;
@property (nonatomic, weak) UIButton *myLocBtn;
@property (nonatomic, strong) NSMutableArray *locArr;
@end

@implementation WLOnSpotMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"现场检查";
    _locArr = [NSMutableArray array];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];


    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    [self.locManager requestWhenInUseAuthorization];
    [self.locManager startUpdatingLocation];

    [self setUpUI];
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
            NSString *htmlPath = [NSString stringWithFormat:@"%@/mobile_security_check.html",basePath];//目标 文件路径
            NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];//把html文件转换成string类型
            [self.webView loadHTMLString:htmlString baseURL:baseUrl];//加载
        }else{
            CLLocation *loc = [locations firstObject];
            NSString *updateCurrentPoint = [NSString stringWithFormat:@"updateCurrentPoint(%f,%f)",loc.coordinate.longitude , loc.coordinate.latitude];
            [_context evaluateScript:updateCurrentPoint];
            
            NSString *locStr =[NSString stringWithFormat:@"%f,%f",loc.coordinate.longitude , loc.coordinate.latitude];
            [_locArr addObject:locStr];
            NSDictionary *dic3 =@{@"type":@"Feature"};
            NSDictionary *dic =@{@"HYDC":@"FB010001",
                                 @"Name":@"长江",
                                 @"OBJ_CODE":@"FB010001",
                                 @"OBJ_NAME":@"长江",
                                 @"UserID":@(0)
                                 };
            NSDictionary *dic2 = @{@"properties":dic};
            NSDictionary *dic1 = @{@"type":@"LineString",
                                   @"coordinates":_locArr
                                   };
            NSArray *features = @[dic1,dic2,dic3];
            NSDictionary *jsonDic = @{@"type":@"FeatureCollection",
                                @"features":features
                                };
            NSString *jsonStr = [jsonDic jsonStringEncoded];
            NSLog(@"%@",jsonStr)
            NSString *updateCurrentLine = [NSString stringWithFormat:@"updateCurrentLine(%@)",jsonStr];
            [_context evaluateScript:updateCurrentLine];

        }
    }
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"loc error %@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *showMap = [NSString stringWithFormat:@"showMap(%f,%f)",self.userLoc.coordinate.longitude , self.userLoc.coordinate.latitude];
    [_context evaluateScript:showMap];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)setUpUI{
    @weakify(self)
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(WC_HOMEBAR_HEIGHT-15);
    }];
    
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.view.mas_centerX).offset(-10);
        make.bottom.mas_equalTo(WC_HOMEBAR_HEIGHT-15);
    }];
    
    [self.hiddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.view.mas_centerX).offset(10);
        make.bottom.mas_equalTo(WC_HOMEBAR_HEIGHT-15);
    }];
    
    [self.myLocBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(-15);
         make.bottom.mas_equalTo(WC_HOMEBAR_HEIGHT-15);
    }];
    
}

-(UIButton *)startBtn{
    if (!_startBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"开始检查" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"mapStartBtnBg"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _startBtn = btn;
    }
    return _startBtn;
}

-(void)startBtnClick{
    self.endBtn.hidden = NO;
    self.hiddBtn.hidden = NO;
    self.startBtn.hidden = YES;
    [self.locManager startUpdatingLocation];
    NSString *updateStartPoint = [NSString stringWithFormat:@"updateStartPoint(%f,%f)",self.userLoc.coordinate.longitude , self.userLoc.coordinate.latitude];
    [_context evaluateScript:updateStartPoint];
}

-(void)endBtnClick{
    self.endBtn.hidden = YES;
    self.hiddBtn.hidden = YES;
    self.startBtn.hidden = NO;
    [self.locManager stopUpdatingLocation];
    
}

-(void)myLocBtnClick{
    
    NSString *centerOnCurrentPoint = [NSString stringWithFormat:@"centerOnCurrentPoint()"];
    [_context evaluateScript:centerOnCurrentPoint];
    
}

-(UIButton *)endBtn{
    if (!_endBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"结束检查" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"mapEndBtnBg"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(endBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        _endBtn = btn;
    }
    return _endBtn;
}
-(UIButton *)hiddBtn{
    if (!_hiddBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"新建隐患" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"mapEndBtnBg"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = YES;
        _hiddBtn = btn;
    }
    return _hiddBtn;
}

-(UIButton*)myLocBtn{
    if (!_myLocBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"myLoc"] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(myLocBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _myLocBtn = btn;
    }
    return _myLocBtn;
}
@end
