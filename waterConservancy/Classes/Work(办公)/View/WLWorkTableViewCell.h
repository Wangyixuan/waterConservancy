//
//  WLWorkTableViewCell.h
//  waterConservancy
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLWorkTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic, copy) void(^btnClickBlock)(NSString *cellTitle);
@end
