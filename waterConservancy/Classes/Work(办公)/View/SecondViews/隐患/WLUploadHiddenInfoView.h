//
//  WLUploadHiddenInfoView.h
//  waterConservancy
//
//  Created by mac on 2018/9/2.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLUploadHiddenInfoView : UIView
@property (weak, nonatomic) IBOutlet UILabel *engNameLab;

@property (weak, nonatomic) IBOutlet UILabel *tendNameLab;

+(instancetype)showInfOView;
@end
