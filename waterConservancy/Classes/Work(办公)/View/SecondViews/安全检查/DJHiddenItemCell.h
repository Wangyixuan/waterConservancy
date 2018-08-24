//
//  DJHiddenItemCell.h
//  waterConservancy
//
//  Created by liu on 2018/8/24.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//  隐藏项

#import "YXBaseTableViewCell.h"

@interface DJHiddenItemCell : YXBaseTableViewCell
-(void)initHiddenItemDataWithModel:(NSArray *)modelArray indexPath:(NSIndexPath *)indexpath;
@end
