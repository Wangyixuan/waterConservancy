
//
//  DJHiddenDangerModel.m
//  waterConservancy
//
//  Created by liu on 2018/8/17.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJHiddenDangerModel.h"

@implementation DJHiddenDangerModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.hiddName = [dic stringForKey:@"hiddName" defaultValue:@""];
        NSString *timeStr = [dic stringForKey:@"collTime" defaultValue:@""];
        if (timeStr.length>0) {
            self.collTime = [timeStr substringToIndex:10];
        }
        self.hiddGrad = [dic stringForKey:@"hiddGrad" defaultValue:@""];
        NSString *engGuid =[dic stringForKey:@"engGuid" defaultValue:@""];
        if (engGuid) {
            self.engGuid = engGuid;
            [self loadEngNameWithEngGuid:engGuid];
        }
        self.hiddProjectName = @"无";
        self.guid = [dic stringForKey:@"guid" defaultValue:@""];
    }
    return self;
}

-(void)loadEngNameWithEngGuid:(NSString*)engGuid{

        NSDictionary *param = @{@"guid":engGuid};
        [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/jck/obj/objEngs/") Parmars:param success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary *respDic = (NSDictionary*)responseObject;
            NSArray *respArr = [respDic objectForKey:@"data"];
            for (NSDictionary *dic in respArr) {
                self.hiddProjectName = [dic stringForKey:@"engName" defaultValue:@"无"];
            }
        } faild:^(NSError *error) {
            
        }];
}
@end
