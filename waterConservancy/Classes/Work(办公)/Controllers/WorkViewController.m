//
//  WorkViewController.m
//  waterConservancy
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WorkViewController.h"
#import "WLWorkTopView.h"

@interface WorkViewController ()

@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupTopView{
 
    WLWorkTopView *topView = [[WLWorkTopView alloc]initWithFrame:CGRectMake(0, 0, WCScreenWidth, 200)];
    [self.view addSubview:topView];
    
}
@end
