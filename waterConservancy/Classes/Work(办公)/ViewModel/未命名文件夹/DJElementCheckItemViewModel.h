//
//  DJElementCheckItemViewModel.h
//  waterConservancy
//
//  Created by liu on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UploadSuccessBlock) (NSArray *modelArray);
@interface DJElementCheckItemViewModel : NSObject

/** 获得检查项数据 */
-(void)getElementCheckItemWithseGuid:(NSString *)seGuid
                        successBlock:(UploadSuccessBlock)successBlock;
/** 获得隐患数据 */
-(void)getElementHiddenWithGuid:(NSString *)Guid
                   successBlock:(UploadSuccessBlock)successBlock;
@end
