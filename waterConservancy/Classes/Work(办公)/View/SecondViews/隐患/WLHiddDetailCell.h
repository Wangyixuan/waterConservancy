//
//  WLHiddDetailCell.h
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "YXBaseTableViewCell.h"

@interface WLHiddDetailCell : YXBaseTableViewCell
@property (nonatomic, strong) NSMutableArray *photoArr;
@property (nonatomic, copy) void(^videoPlayBlock)(NSURL*url);
@end
