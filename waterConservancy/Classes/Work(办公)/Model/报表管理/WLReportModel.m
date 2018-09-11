//
//  WLReportModel.m
//  waterConservancy
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLReportModel.h"

@implementation WLReportModel
-(instancetype)initWithData:(NSDictionary*)dic{
    if (self = [super init]) {
        self.repName = [dic stringForKey:@"repName" defaultValue:@""];
        self.repAct = [dic stringForKey:@"repAct" defaultValue:@""];
        self.guid = [dic stringForKey:@"guid" defaultValue:@""];
    }
    return self;
}
@end
