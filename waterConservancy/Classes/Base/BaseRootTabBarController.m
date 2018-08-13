//
//  BaseRootTabBarController.m
//  waterConservancy
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "BaseRootTabBarController.h"
#import "WorkViewController.h"

@interface BaseRootTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BaseRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    NSArray *titleArr = @[@"办公",@"安全云",@"专题图",@"通讯录",@"门户"];
    NSArray *imgNameArr = @[@"checkRiver",@"home",@"me",@"news",@"rectification"];
    WorkViewController *workCV = WCViewControllerOfWorkSB(@"WorkViewController");
    NSArray *controllerArr = @[workCV];
    [self tabBarSetupChildViewControllersWithcontrollers:controllerArr Titles:titleArr images:imgNameArr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarSetupChildViewControllersWithcontrollers:(NSArray*)controllers Titles:(NSArray*)titles images:(NSArray*)images {
    for (int i = 0; i < titles.count; ++i) {
        BaseViewController *vc = [[BaseViewController alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
         vc.tabBarItem.title = titles[i];
        
        NSString *imgName = images[i];
        NSString *imgSelectName = [NSString stringWithFormat:@"%@_selected",imgName];
        
        UIImage *normalImage = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage = [[UIImage imageNamed:imgSelectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.image=normalImage;
        vc.tabBarItem.selectedImage = selectImage;
        
        [self addChildViewController:vc];
        
    }
    
    
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
