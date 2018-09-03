//
//  WLUploadHiddenInfoView.m
//  waterConservancy
//
//  Created by mac on 2018/9/2.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLUploadHiddenInfoView.h"

@implementation WLUploadHiddenInfoView


+(instancetype)showInfOView{
    return [[NSBundle mainBundle] loadNibNamed:@"WLUploadHiddenInfoView" owner:nil options:nil].firstObject;
}
@end
