//
//  DJHiddenDrangeChartCell.h
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "YXBaseTableViewCell.h"
#import "DJMonthListModel.h"

typedef void (^hiddenChartBtnClickBlock) (DJMonthListModel *model);
@interface DJHiddenDrangeChartCell : YXBaseTableViewCell

@property (nonatomic, copy) hiddenChartBtnClickBlock hiddenChartBtnClickBlock;

-(void)initDataWithModel:(DJMonthListModel *)model;
@end
