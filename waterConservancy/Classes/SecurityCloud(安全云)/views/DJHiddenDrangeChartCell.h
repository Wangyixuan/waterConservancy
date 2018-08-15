//
//  DJHiddenDrangeChartCell.h
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "YXBaseTableViewCell.h"

typedef void (^hiddenChartBtnClickBlock) (void);
@interface DJHiddenDrangeChartCell : YXBaseTableViewCell
@property (nonatomic, copy) hiddenChartBtnClickBlock hiddenChartBtnClickBlock;
@end
