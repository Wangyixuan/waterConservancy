//
//  WLPatrolRecordModel.m
//  waterConservancy
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLPatrolRecordModel.h"

@implementation WLPatrolRecordModel

-(instancetype)initWithData:(NSDictionary *)dic{
    if (self = [super init]) {
        self.patTime = [dic stringForKey:@"patTime" defaultValue:@""];
        self.patPers = [dic stringForKey:@"patPers" defaultValue:@""];
        self.probFound = [dic stringForKey:@"probFound" defaultValue:@""];
        self.treaMeas = [dic stringForKey:@"treaMeas" defaultValue:@""];
        
    }
    return self;
}

@end
