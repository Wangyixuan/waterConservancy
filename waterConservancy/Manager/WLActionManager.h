//
//  WLActionManager.h
//  waterConservancy
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WLShareActionManager [WLActionManager sharedActionManager]

@interface WLActionManager : NSObject
+(instancetype)sharedActionManager;
-(void)handleAction:(UIViewController *)viewController actionName:(NSString*)action;
@end
