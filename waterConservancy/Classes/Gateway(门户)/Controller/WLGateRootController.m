//
//  WLGateRootController.m
//  waterConservancy
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLGateRootController.h"
#import "KKContainerScrollView.h"
#import "WLEducationViewController.h"


@interface WLGateRootController ()
@property (nonatomic, strong) KKContainerScrollView *topScrollView;
@end

@implementation WLGateRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = nil;
    @weakify(self)
    KKContainerScrollView *topView = [[KKContainerScrollView alloc]init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];

    WLEducationViewController *edu = [[WLEducationViewController alloc]init];
    [self addChildViewController:edu];
    [self addChildViewController:edu];
    [self addChildViewController:edu];
    
    topView.titlesArray = @[@"三类人员",@"标准化",@"培训教育"];
    topView.controllersArray = @[edu,edu,edu];
    topView.selectedIndex = 0;
    self.topScrollView = topView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
