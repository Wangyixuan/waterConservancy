//
//  YXPhotoImgBtn.h
//  河掌治
//
//  Created by liu on 2018/4/16.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^delBtnBlock)(void);
typedef void (^biggerBlock)(void);
@interface YXPhotoImgBtn : UIView
@property (nonatomic, copy) delBtnBlock delBtnBlock;
@property (nonatomic, copy) biggerBlock biggerBlock;

-(void)loadImg:(UIImage *)img;
@end
