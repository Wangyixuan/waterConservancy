//
//  WLUploadDetailInfoView.h
//  waterConservancy
//
//  Created by mac on 2018/9/2.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLUploadDetailInfoView : UIView
@property (nonatomic, copy) void(^beginEditBlock)(void);
@property (nonatomic, copy) void(^endEditBlock)(void);
@property (nonatomic, copy) void(^voiceBlock)(void);
@property (nonatomic, copy) void(^addPhotoBlock)(void);
@property (nonatomic, copy) void(^delPhotoBtnBlock)(NSInteger i);
@property (nonatomic, copy) void(^videodelBlock)(NSInteger i);
@property (nonatomic, copy) void(^videoPlayBlock)(NSURL *url);
@property (nonatomic, copy) void(^reloadBlock)(void);
@property (nonatomic, copy) void(^chooseGradBlock)(void);
@property (nonatomic, copy) void(^hiddNameBlock)(NSString*hiddName);
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, weak) UITextField *gradText;
@end
