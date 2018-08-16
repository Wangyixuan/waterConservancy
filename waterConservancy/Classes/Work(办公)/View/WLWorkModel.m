//
//  WLWorkModel.m
//  waterConservancy
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLWorkModel.h"

@implementation WLWorkModel
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        self.title = [dic stringValueForKey:@"title" default:@""];
        self.iconURL = [dic stringValueForKey:@"img" default:@""];
        
    }
    return self;
}

@end
