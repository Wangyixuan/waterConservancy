//
//  UIViewController+QRCode.m
//  KuaiKuai
//
//  Created by mac on 15/9/7.
//  Copyright (c) 2015年 liujichang. All rights reserved.
//

#import "UIViewController+QRCode.h"

NSString const *qrReaderKey = @"qrReaderKey";


@implementation UIViewController (QRCode)

@dynamic qrReader;

#pragma mark - getters/setters
//runTime 机制 调用时创建
-(QRCodeReaderViewController*) qrReader {
    return objc_getAssociatedObject(self, &qrReaderKey);
}
-(void)setQrReader:(QRCodeReaderViewController *)qrReader
{
    objc_setAssociatedObject(self, &qrReaderKey, qrReader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



//扫描二维码
-(void)operateQRCode
{
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        
        if (!self.qrReader) {
            self.qrReader = [QRCodeReaderViewController new];
            self.qrReader.modalPresentationStyle = UIModalPresentationFormSheet;
        };
        
        @weakify(self)
        //回调拿到结果
        [self.qrReader setCompletionWithBlock:^(NSString *resultAsString) {
            [weak_self.qrReader dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];
        
        [self presentViewController:self.qrReader animated:YES completion:NULL];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法扫描二维码" message:@"请在“设置-隐私-相机”选项中允许快快访问你的相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
        [alert show];
    }
}


@end
