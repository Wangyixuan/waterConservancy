//
//  AppDelegate.m
//  waterConservancy
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "AppDelegate.h"

#import "DJLoadViewController.h"
#import "YXTabbarController.h"
#import "YXNavViewController.h"
@interface AppDelegate ()
@property (nonatomic, strong)  YXTabbarController *tabbarC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
<<<<<<< HEAD
    // Override point for customization after application launch.
=======
    self.window = [[UIWindow alloc]initWithFrame:Screen];
    
    //接受到退出信号 退出
//    if ([isLogout isEqualToString:@"logout"]) {
//        //         [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"currentUser"];
//        //
//        [self showLoadControllers];
//    }
    
    //如果账号或id存在
    if (0) {
        self.tabbarC = [[YXTabbarController alloc]init];
        self.window.rootViewController = self.tabbarC;
    }else{
        DJLoadViewController *loadCtrl = [[DJLoadViewController alloc]init];
        YXNavViewController *nav = [[YXNavViewController alloc]initWithRootViewController:loadCtrl setNavigationBarHidden:YES];
        self.window.rootViewController = nav;
    }
    [self.window makeKeyAndVisible];
>>>>>>> f9d7d9bfe10ced6377fef1342ceced11e0ae4fd6
    
    return YES;
}
- (void)showMainControllers {
    _window.rootViewController = [[YXTabbarController alloc] init];
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)showLoadControllers {
    //    self.window.rootViewController = nil;
    DJLoadViewController *loginCtrl = [[DJLoadViewController alloc]init];
    YXNavViewController *navCtrl = [[YXNavViewController alloc]initWithRootViewController:loginCtrl];
    [navCtrl setNavigationBarHidden:YES];
    self.window.rootViewController = navCtrl;;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
