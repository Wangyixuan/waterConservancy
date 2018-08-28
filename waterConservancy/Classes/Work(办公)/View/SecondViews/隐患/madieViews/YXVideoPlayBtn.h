//
//  YXVideoPlayBtn.h
//  河掌治
//
//  Created by liu on 2018/4/16.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^delBtnBlock)(void);

@interface YXVideoPlayBtn : UIButton
@property (nonatomic, weak) UIButton *delBtn;
@property (nonatomic, copy) delBtnBlock videodelBtnBlock;
@end
