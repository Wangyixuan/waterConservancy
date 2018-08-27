//
//  CommonMacro.h
//  waterConservancy
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//工程 宏 文件

#ifndef CommonMacro_h
#define CommonMacro_h

//打印
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//StoryBoard
#define WCViewControllerOfMainSB(identifier) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier]
#define WCViewControllerOfWorkSB(identifier) [[UIStoryboard storyboardWithName:@"Work" bundle:nil] instantiateViewControllerWithIdentifier:identifier]
#define WCViewControllerOfMailListSB(identifier) [[UIStoryboard storyboardWithName:@"MailList" bundle:nil] instantiateViewControllerWithIdentifier:identifier]
#define WCViewControllerOfGatewaySB(identifier) [[UIStoryboard storyboardWithName:@"Gateway" bundle:nil] instantiateViewControllerWithIdentifier:identifier]
#define WCViewControllerOfSpecialSB(identifier) [[UIStoryboard storyboardWithName:@"Special" bundle:nil] instantiateViewControllerWithIdentifier:identifier]
#define WCViewControllerOfSecurityCloudSB(identifier) [[UIStoryboard storyboardWithName:@"SecurityCloud" bundle:nil] instantiateViewControllerWithIdentifier:identifier]

//Notification
#define WCNotificationCenter [NSNotificationCenter defaultCenter]
#define WCNotificationCenterAddObserverOfSelf(selectorName, notificationName, ojbect) \
[KKNotificationCenter addObserver:self \
selector:@selector(selectorName) \
name:notificationName \
object:ojbect];
#define WCNotificationCenterRemoveObserverOfSelf [KKNotificationCenter removeObserver:self];

//屏幕相关
#define WCMainScreen      [UIScreen mainScreen]
#define WCScreenSize      [UIScreen mainScreen].bounds.size
#define WCScreenWidth     WCScreenSize.width
#define WCScreenHeight    WCScreenSize.height

#define KKScreenHeightIphone4s 480
#define KKScreenHeightIphone5  568
#define KKScreenHeightIphone6  667
#define KKScreenHeightIphone6p  736
#define KKScreenHeightIphoneX  812

#define KKScreenWidthIphone5  320
#define KKScreenWidthIphone6 375
#define KKScreenWidthIphone6p 414
#define KKScreenWidthIphoneX 375

#define WC_HOMEBAR_HEIGHT ((WCScreenHeight==KKScreenHeightIphoneX)?34:0)
#define WC_STATUSBAR_HEIGHT    [[UIApplication sharedApplication] statusBarFrame].size.height

#define PAGESIZW 10

#endif /* CommonMacro_h */
