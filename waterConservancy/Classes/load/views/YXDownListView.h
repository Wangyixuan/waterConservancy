//
//  YXDownListView.h
//  河掌治
//
//  Created by liu on 2018/3/26.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^userCellBlock)(NSString *userName,NSString *password);
@interface YXDownListView : UIView

//点击cell的操作
@property (nonatomic ,copy) userCellBlock block;


@end
