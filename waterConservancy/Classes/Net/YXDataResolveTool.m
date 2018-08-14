//
//  YXDataResolveTool.m
//  河掌治
//
//  Created by liu on 2018/3/27.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXDataResolveTool.h"

@implementation YXDataResolveTool
+(NSArray *)DataResolve:(id)responseObject{
    NSDictionary *DIC1 = responseObject[@"DataSource"];
    NSArray *array = DIC1[@"Tables"];
    NSDictionary *DIC2 = array.firstObject;
    NSArray *array2 = DIC2[@"Datas"];
    return array2;
}



@end
