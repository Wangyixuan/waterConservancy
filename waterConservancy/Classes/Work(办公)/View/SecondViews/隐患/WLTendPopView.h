//
//  WLTendPopView.h
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLTendPopView : UIView
@property (nonatomic, copy) void(^uploadHiddenBlock)(NSString*tendName,NSString*tendGuid);

+(instancetype)creatTendPopViewWithData:(NSArray*)dataArr;
@end
