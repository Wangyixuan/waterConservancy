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

    }
    return self;
}

@end
