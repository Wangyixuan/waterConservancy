//
//  YXBackBtn.m
//  河掌治
//
//  Created by liu on 2018/4/11.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXBackBtn.h"

@implementation YXBackBtn

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat y = (self.height - self.imgH)/2;
    return CGRectMake(0, y, self.imgW, self.imgH);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat x = self.imgW + self.margin;
    CGFloat width = self.width - self.imgW - 10;
    return CGRectMake(x, 0, width, self.height);
}
@end
