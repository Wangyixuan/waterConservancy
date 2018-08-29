//
//  WLUploadDetailInfoCell.h
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "YXBaseTableViewCell.h"

@interface WLUploadDetailInfoCell : YXBaseTableViewCell
@property (nonatomic, copy) void(^beginEditBlock)(void);
@property (nonatomic, copy) void(^endEditBlock)(void);
@property (nonatomic, copy) void(^uploadHeightBlock)(CGFloat H);
@property (nonatomic, copy) void(^voiceBlock)(void);
@property (nonatomic, copy) void(^addPhotoBlock)(void);
@property (nonatomic, copy) void(^delPhotoBtnBlock)(NSInteger i);
@property (nonatomic, copy) void(^videodelBlock)(NSInteger i);
@property (nonatomic, copy) void(^videoPlayBlock)(NSURL *url);
@property (nonatomic, copy) NSString *descStr;
@property (nonatomic, strong) NSMutableArray *photoArr;

@end
