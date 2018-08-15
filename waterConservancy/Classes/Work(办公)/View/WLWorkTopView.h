//
//  WLWorkTopView.h
//  waterConservancy
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLWorkTopView : UIView
@property (nonatomic, copy) void(^userInfoBlock)(void);
@property (nonatomic, copy) void(^nearBlock)(void);
@property (nonatomic, copy) void(^QRCodeBlock)(void);
@property (nonatomic, copy) void(^agencyWorkBlock)(void);
@property (nonatomic, copy) void(^noticeBlock)(void);
@end
