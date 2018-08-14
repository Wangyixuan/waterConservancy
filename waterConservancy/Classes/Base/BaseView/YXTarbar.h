//
//  YXTarbar.h
//  河掌治
//
//  Created by liuDJ on 2018/3/18.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YXTarbar;
@protocol TNTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(YXTarbar *)tabBar;
@end

@interface YXTarbar : UITabBar
@property (nonatomic,weak) id<TNTabBarDelegate> tabbarDelegate;
@end
