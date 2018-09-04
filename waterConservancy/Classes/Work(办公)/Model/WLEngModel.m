//
//  WLEngModel.m
//  waterConservancy
//
//  Created by mac on 2018/9/4.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLEngModel.h"

@implementation WLEngModel

-(instancetype)initWithEngGuid:(NSString*)engGuid{
    if (self = [super init]) {
        self.engGuid = engGuid;
        [self loadEngNameWithEngGuid:engGuid];
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
            self.engName = [dic stringForKey:@"engName" defaultValue:@"无"];
        }
    } faild:^(NSError *error) {
        
    }];
}
@end
