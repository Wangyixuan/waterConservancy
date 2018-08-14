//
//  YXSaveUserCell.h
//  河掌治
//
//  Created by liu on 2018/3/26.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^delUserBlock)(NSInteger tag);
@interface YXSaveUserCell : UITableViewCell

@property (nonatomic, copy) delUserBlock delBlock;

-(void)setDataWithStr:(NSString *)str btnTag:(NSInteger)tag;

@end
