//
//  WLWorkTableViewCell.h
//  waterConservancy
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLWorkModel.h"

@interface WLWorkTableViewCell : UITableViewCell
<<<<<<< HEAD
@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic, copy) void(^btnClickBlock)(NSString *cellTitle);
=======
@property (nonatomic, strong) WLWorkModel *model;
@property (nonatomic, copy) void(^btnClickBlock)();
>>>>>>> 802c57d34b2db7c54dcee0f377460f0c756f4398
@end
