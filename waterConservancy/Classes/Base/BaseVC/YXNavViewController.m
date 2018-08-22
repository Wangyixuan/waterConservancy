//
//  YXNavViewController.m
//  河掌治
//
//  Created by 乐凡宝宝 on 2018/3/18.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXNavViewController.h"
//#import "YXExitAlter.h"

@interface YXNavViewController ()

@end

@implementation YXNavViewController
-(instancetype)initWithRootViewController:(YXBaseViewController *)rootViewController setNavigationBarHidden:(BOOL)hidden{
    YXNavViewController *navCtrl = [[YXNavViewController alloc]initWithRootViewController:rootViewController];
    navCtrl.navigationBar.barStyle = UIStatusBarStyleDefault;
    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"nav_nav"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setTitleTextAttributes:@{
                                    NSForegroundColorAttributeName:[UIColor whiteColor]
                                    }];
    
    return navCtrl;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    // 如果push进来的不是第一个控制器
    if (self.childViewControllers.count > 0) {
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
//        [self customLeftBackButton];
//        viewController.navigationItem.backBarButtonItem =[self customLeftBackButton];
        
        [self setNavigationBarHidden:NO animated:YES];
    }
     [super pushViewController:viewController animated:animated];
//    if (![[super topViewController] isKindOfClass:[viewController class]]) {
//            [super pushViewController:viewController animated:animated];
//    }
}






////#pragma mark - 自定义返回按钮图片
//-(void)customLeftBackButton{
//
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.frame = CGRectMake(0, 0, 60, 40);
//    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //将leftItem设置为自定义按钮
//    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = leftItem;
//
//


//    UIImage *image = [UIImage imageNamed:@"back"];
//
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    backButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//
//
//    [backButton setBackgroundImage:image
//                          forState:UIControlStateNormal];
//    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
//
//    [backButton addTarget:self
//                   action:@selector(popself)
//         forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

//    return backItem;
//}
//
//#pragma mark - 返回按钮事件(pop)
-(void)popself
{
    NSLog(@"%@",self.childViewControllers.lastObject);
    //初始页面count == 2
    if (self.childViewControllers.count == 2) {
        [self setNavigationBarHidden:YES animated:YES];
    }
    [self popViewControllerAnimated:YES];


}
@end
