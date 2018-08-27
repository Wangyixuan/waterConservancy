
//
//  DJHiddenDangerModel.m
//  waterConservancy
//
//  Created by liu on 2018/8/17.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJHiddenDangerModel.h"

@implementation DJHiddenDangerModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.hiddName =@"上游灌浆作业面配电箱内漏电保护器失灵";// [dic stringForKey:@"hiddName" defaultValue:@""];
        NSString *timeStr = @"2018-04-08 17:25:03";//[dic stringForKey:@"collTime" defaultValue:@""];
        self.collTime = [timeStr substringToIndex:10];
        self.hiddGrad = @"2";//[dic integerForKey:@"hiddGrad" defaultValue:0];
        self.engGuid =@"610102000006"; //[dic stringForKey:@"engGuid" defaultValue:@""];
    }
    return self;
}


@end
