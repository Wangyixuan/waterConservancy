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
        NSString *str = [dic stringForKey:@"inspCont" defaultValue:@""];
        NSString *star = [dic stringForKey:@"startDate" defaultValue:@""];
        NSString *star2 = [star substringToIndex:10];
        NSString *end = [dic stringForKey:@"endDate" defaultValue:@""];
        NSString *end2 = [end substringToIndex:10];
        self.checkNoteStr = [NSString stringWithFormat:@"检查内容：%@",str];
        self.checkTimeStr = [NSString stringWithFormat:@"检查时间：%@-%@",star2,end2];
        self.sinsGuidStr = [dic stringForKey:@"sinsGuid" defaultValue:@""];
    }
    return self;
}
@end
