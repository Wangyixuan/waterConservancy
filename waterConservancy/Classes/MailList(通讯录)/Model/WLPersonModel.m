//
//  WLPersonModel.m
//  waterConservancy
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLPersonModel.h"

@implementation WLPersonModel
-(instancetype)initWithData:(NSDictionary*)dic{
    if (self = [super init]) {
        self.name = [dic stringForKey:@"persName" defaultValue:@""];
        self.telNub = [dic stringForKey:@"mobilenumb" defaultValue:@""];
        self.orgName = [dic stringForKey:@"orgName" defaultValue:@""];
        self.depName = [dic stringForKey:@"depName" defaultValue:@""];
        self.userCode = [dic stringForKey:@"userName" defaultValue:@""];
    }
    return self;
}
@end
