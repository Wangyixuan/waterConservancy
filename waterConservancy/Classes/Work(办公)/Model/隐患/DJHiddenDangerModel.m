
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
        self.hiddName = [dic stringForKey:@"hiddName" defaultValue:@""];
        NSString *timeStr = [dic stringForKey:@"collTime" defaultValue:@""];
        if (timeStr.length>0) {
            self.collTime = [timeStr substringToIndex:10];
        }
        self.hiddGrad = [dic stringForKey:@"hiddGrad" defaultValue:@""];
        self.engGuid =[dic stringForKey:@"engGuid" defaultValue:@""];
        self.hiddProjectName = @"无";
        self.guid = [dic stringForKey:@"guid" defaultValue:@""];
    }
    return self;
}


@end
