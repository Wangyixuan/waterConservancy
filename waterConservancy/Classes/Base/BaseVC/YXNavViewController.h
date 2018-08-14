//
//  YXNavViewController.h
//  河掌治
//
//  Created by 乐凡宝宝 on 2018/3/18.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBaseViewController.h"

@interface YXNavViewController : UINavigationController

- (instancetype)initWithRootViewController:(YXBaseViewController *)rootViewController setNavigationBarHidden:(BOOL)hidden;

@end
