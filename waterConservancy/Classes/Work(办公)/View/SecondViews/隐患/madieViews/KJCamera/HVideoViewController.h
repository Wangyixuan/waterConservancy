//
//  HVideoViewController.h
//  Join
//
//  Created by 黄克瑾 on 2017/1/11.
//  Copyright © 2017年 huangkejin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TakeOperationSureBlock)(id item);
typedef void(^getPhotoURLBlock)(id item);

@interface HVideoViewController : UIViewController

@property (copy, nonatomic) TakeOperationSureBlock takeBlock;
@property (copy, nonatomic) getPhotoURLBlock   getPhotoURLBlock;

@property (assign, nonatomic) NSInteger HSeconds;

@end
