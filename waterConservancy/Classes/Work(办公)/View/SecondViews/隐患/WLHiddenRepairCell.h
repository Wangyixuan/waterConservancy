//
//  WLHiddenRepairCell.h
//  waterConservancy
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "YXBaseTableViewCell.h"
#import "DJHiddenDangerModel.h"

@interface WLHiddenRepairCell : YXBaseTableViewCell
@property (nonatomic, strong) DJHiddenDangerModel *model;
@property (nonatomic, copy) void(^actionBlock)(NSString*hiddGuid);
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@end
