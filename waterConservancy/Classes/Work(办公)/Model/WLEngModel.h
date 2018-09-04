//
//  WLEngModel.h
//  waterConservancy
//
//  Created by mac on 2018/9/4.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//工程模型（隐患所属工程 事故所属工程等 使用engGuid获取工程名称）

#import <Foundation/Foundation.h>

@interface WLEngModel : NSObject
@property (nonatomic, copy) NSString *engGuid;
@property (nonatomic, copy) NSString *engName;
-(instancetype)initWithEngGuid:(NSString*)engGuid;
@end
