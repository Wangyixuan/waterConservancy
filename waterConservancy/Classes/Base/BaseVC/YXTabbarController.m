//
//  YXTabbarController.m
//  河掌治
//
//  Created by 乐凡宝宝 on 2018/3/18.
//  Copyright © 2018年 乐凡宝宝. All rights reserved.
//

#import "YXTabbarController.h"
#import "YXTarbar.h"
#import "YXBaseViewController.h"
#import "YXNavViewController.h"
#import "DJOnSpotCheckController.h"
#import "WorkViewController.h"


@interface YXTabbarController ()<TNTabBarDelegate,UITabBarControllerDelegate>
@end
@implementation YXTabbarController
-(instancetype)init{
    self = [super init];
    if (self) {
        self.tabBar.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        [self setUpAllChildViewController];
        [self addCustomTabBar];
    }
    return self;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
     NSLog(@"%@",tabBarController.selectedViewController.childViewControllers.firstObject);
//    if ([tabBarController.selectedViewController.childViewControllers.firstObject isKindOfClass:[YXHomeViewController class]]) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:HOMECHANGEKEY object:nil];
//    }
}


- (void)addCustomTabBar {
    //创建自定义tabbar
    YXTarbar *customTabBar = [[YXTarbar alloc] init];
    customTabBar.tabbarDelegate = self;
    customTabBar.backgroundColor = [UIColor clearColor];
    //更换系统自带的tabbar
    [self setValue:customTabBar forKey:@"tabBar"];
    
}
-(void)setUpAllChildViewController{
    WorkViewController *homeCtrl = [[WorkViewController alloc]init];
    [self setUpOneChildViewController:homeCtrl image:@"home" title:@"首页"];
    
    DJOnSpotCheckController *riverCtrl = [[DJOnSpotCheckController alloc]init];
    [self setUpOneChildViewController:riverCtrl image:@"checkRiver" title:@"巡河"];
    
    UIViewController *reCtrl = [[UIViewController alloc]init];
//    [reCtrl setCurrentTag:1];
    [self setUpOneChildViewController:reCtrl image:@"rectification" title:@"整改"];
    
    UIViewController *meCtrl = [[UIViewController alloc]init];
    [self setUpOneChildViewController:meCtrl image:@"me" title:@"我的"];
    
    
}
- (UINavigationController *)setUpOneChildViewController:(YXBaseViewController *)vc image:(NSString *)imageStr title:(NSString *)title {
    vc.title = title;
    UIImage *ImgNormal = [UIImage imageNamed:imageStr];
    UIImage *imgSelected = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageStr]];
    ImgNormal = [ImgNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = ImgNormal;
    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:YX22Font} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:YX22Font} forState:UIControlStateSelected];
    //声明这张图用原图
    imgSelected = [imgSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = imgSelected;
    YXNavViewController *nav = [[YXNavViewController alloc]initWithRootViewController:vc setNavigationBarHidden:YES];
//    [nav.tabBarItem setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
    [self addChildViewController:nav];
    return nav;
}
#pragma mark tabbarDelegate
-(void)tabBarDidClickedPlusButton:(YXTarbar *)tabBar{
     YXNavViewController *nav =  self.viewControllers[self.selectedIndex];
//    [[YXcheckMethod alloc]nocaheloadDataUseStr:@"1" pindex:@"0" pageno:@"5 "com:^(NSMutableArray *array) {
//        __block YXCheckNewModel *checkingModel = [[YXCheckNewModel alloc]init];//正在巡河的model
//        [array enumerateObjectsUsingBlock:^(YXCheckNewModel *checkModel, NSUInteger idx, BOOL * _Nonnull stop) {
//
//            if ([checkModel.TaskStatus  isEqualToString:@"2"]) {
//                checkingModel = checkModel;
//            }
//
//        }];
//        if (checkingModel.TaskStatus != nil) {
//            YXMapController *mapCtrl = [[YXMapController alloc]init];
//            [mapCtrl setCheckModel:checkingModel];
//            [mapCtrl setIsbarEnter:@"111"];
//            [nav pushViewController:mapCtrl animated:YES];
//        }else{
//            YXUpLoadViewController *uploadCtrl = [[YXUpLoadViewController alloc]init];
//            [uploadCtrl setWorktitle:@"快速上报"];
//            [uploadCtrl setIsbackHiddenBar:YES];
//            [nav pushViewController:uploadCtrl animated:YES];
//        }
//    }];
    
    
    
}

@end
