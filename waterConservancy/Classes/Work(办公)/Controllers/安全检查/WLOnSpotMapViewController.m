//
//  WLOnSpotMapViewController.m
//  waterConservancy
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLOnSpotMapViewController.h"
#import <WebKit/WebKit.h>

@interface WLOnSpotMapViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong)  WKWebView *webView;
@end

@implementation WLOnSpotMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"现场检查";
    [self setUpUI];
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    //html 路径
    NSString *indexPath = [NSString stringWithFormat: @"%@/mobile_security_check.html", bundlePath];
    //html 文件中内容
    NSString *indexContent = [NSString stringWithContentsOfFile:
                              indexPath encoding: NSUTF8StringEncoding error:nil];
    
    [_webView loadHTMLString:indexContent baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUI{
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
}

-(WKWebView*)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 设置偏好设置
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        // web内容处理池
        config.processPool = [[WKProcessPool alloc] init];
        // 通过JS与webview内容交互
        config.userContentController = [[WKUserContentController alloc] init];
        
        // 注入JS对象名称，当JS通过名称来调用时，
        // 我们可以在WKScriptMessageHandler代理中接收到
//        if (funcArray && funcArray.count > 0) {
//            for (NSString *str in funcArray) {
//                [config.userContentController addScriptMessageHandler:self name:str];
//            }
//        }

        // 显示WKWebView
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _webView.backgroundColor = [UIColor redColor];
        ((WKWebView *)_webView).UIDelegate = self;
        ((WKWebView *)_webView).navigationDelegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
@end
