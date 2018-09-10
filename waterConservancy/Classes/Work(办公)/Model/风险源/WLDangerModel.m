//
//  WLDangerModel.m
//  waterConservancy
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLDangerModel.h"

@implementation WLDangerModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.name = [dic stringForKey:@"hazName" defaultValue:@""];
        self.guid = [dic stringForKey:@"guid" defaultValue:@""];
        self.engGuid = [dic stringForKey:@"engGuid" defaultValue:@""];
        self.grad = [dic stringForKey:@"hiddGrad" defaultValue:@""];
        self.collTime = [dic stringForKey:@"collTime" defaultValue:@""];
        self.orgGuid = [dic stringForKey:@"orgGuid" defaultValue:@""];
        self.moniPrec = [dic stringForKey:@"moniPrec" defaultValue:@"无"];
        self.harmRisk = [dic stringForKey:@"harmRisk" defaultValue:@"无"];
        self.offiTel = [dic stringForKey:@"offiTel" defaultValue:@""];
        self.supPers = [dic stringForKey:@"supPers" defaultValue:@""];
        self.ifLiceNoti = [dic stringForKey:@"ifLiceNoti" defaultValue:@""];
    }
    return self;
}

@end
