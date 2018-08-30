//
//  WLHiddenRepairPopView.h
//  waterConservancy
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLHiddenRepairPopView : UIView
+(instancetype)showRepairPopView;
@property (nonatomic, copy) void(^commitBlock)(NSString*text);
@end
