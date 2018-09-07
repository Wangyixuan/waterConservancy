//
//  WLDangerPatrolCell.h
//  waterConservancy
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLDangerModel.h"

@interface WLDangerPatrolCell : UITableViewCell
@property (nonatomic, strong) WLDangerModel *model;
@property (weak, nonatomic) IBOutlet UIButton *patrolBtn;
@property (nonatomic, copy) void(^btnClickBlock)(void);
@end
