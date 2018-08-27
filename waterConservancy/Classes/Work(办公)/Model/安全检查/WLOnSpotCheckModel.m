//
//  WLOnSpotCheckModel.m
//  waterConservancy
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLOnSpotCheckModel.h"

@implementation WLOnSpotCheckModel
-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        self.startTimeStr = [dic stringForKey:@"startDate" defaultValue:@""];
        NSString *star2 = [self.startTimeStr substringToIndex:10];
        self.endTimeStr = [dic stringForKey:@"endDate" defaultValue:@""];
        NSString *end2 = [self.endTimeStr substringToIndex:10];
        self.checkNoteStr = [dic stringForKey:@"inspCont" defaultValue:@""];
        self.checkTimeStr = [NSString stringWithFormat:@"检查时间：%@-%@",star2,end2];
        self.sinsGuidStr = [dic stringForKey:@"sinsGuid" defaultValue:@""];
    }
    return self;
}
@end
