//
//  UIViewController+QRCode.h
//  KuaiKuai
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 liujichang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderViewController.h"

@interface UIViewController (QRCode)

@property(strong,nonatomic) QRCodeReaderViewController *qrReader;

-(void)operateQRCode;


@end
