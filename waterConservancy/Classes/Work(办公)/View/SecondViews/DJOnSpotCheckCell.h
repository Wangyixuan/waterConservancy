//
//  DJOnSpotCheckCell.h
//  waterConservancy
//
//  Created by liu on 2018/8/16.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "YXBaseTableViewCell.h"
#import "WLOnSpotCheckModel.h"

typedef void (^onSpotCheckBtnClickBlock) (void);
@interface DJOnSpotCheckCell : YXBaseTableViewCell
@property (nonatomic, copy) onSpotCheckBtnClickBlock onSpotCheckBtnClickBlock;
@property (nonatomic, strong) WLOnSpotCheckModel *model;
@property (nonatomic, copy) void(^cellHBlock)(CGFloat cellH);
@end
