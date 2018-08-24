
//
//  DJElementCheckItemViewModel.m
//  waterConservancy
//
//  Created by liu on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJElementCheckItemViewModel.h"

#import "DJElementCheckItemModel.h"
#import "DJHiddenDangerModel.h"


@implementation DJElementCheckItemViewModel
//获得检测项数据
-(void)getElementCheckItemWithseGuid:(NSString *)seGuid successBlock:(UploadSuccessBlock)successBlock {
    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/se/bisSeChits/")  Parmars:TNParams(@"seGuid":seGuid) success:^(id responseObject) {
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        NSArray *modelArray = [NSArray modelArrayWithClass:[DJElementCheckItemModel class] json:dataArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successBlock) {
                successBlock(modelArray);
            }
        });
       
    } faild:^(NSError *error) {
    
    }];
}
//获得隐患数据
-(void)getElementHiddenWithGuid:(NSString *)Guid successBlock:(UploadSuccessBlock)successBlock {
//
    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/objHidds/")  Parmars:TNParams(@"guid":Guid) success:^(id responseObject) {
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        NSArray *modelArray = [NSArray modelArrayWithClass:[DJHiddenDangerModel class] json:dataArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successBlock) {
                successBlock(modelArray);
            }
        });
    } faild:^(NSError *error) {
        
    }];
}







@end
