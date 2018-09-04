//
//  WLAcciModel.m
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.


#import "WLAcciModel.h"
#import "WLEngModel.h"

@implementation WLAcciModel

-(instancetype)initWithData:(NSDictionary *)dic{
    if (self = [super init]) {
        self.accName = [dic stringForKey:@"acciCause" defaultValue:@""];
        self.accGrad = [dic stringForKey:@"acciGrad" defaultValue:@""];
        NSString *timeStr = [dic stringForKey:@"collTime" defaultValue:@""];
        if (timeStr.length>0) {
            self.collTime = [timeStr substringToIndex:10];
        }
        self.repStat = [dic stringForKey:@"repStat" defaultValue:@""];
        self.guid = [dic stringForKey:@"id" defaultValue:@""];
        self.wiunGuid = [dic stringForKey:@"acciWindGuid" defaultValue:@""];
        self.wiunName = @"无";
        NSString *occuTime = [dic stringForKey:@"occuTime" defaultValue:@""];
        if (occuTime.length>0) {
            self.occuTime = [occuTime substringToIndex:10];
        }
        self.deadNub = [dic stringForKey:@"casNum" defaultValue:@"0"];
        self.serInjNub = [dic stringForKey:@"serInjNum" defaultValue:@"0"];
        self.accSitu = [dic stringForKey:@"acciSitu" defaultValue:@""];
        self.phoRep = [dic stringForKey:@"ifPhoRep" defaultValue:@""];
        self.respAcc = [dic stringForKey:@"ifRespAcci" defaultValue:@""];
        self.accLoss = [dic stringForKey:@"econLoss" defaultValue:@"0"];
    }
    return self;
}

@end
