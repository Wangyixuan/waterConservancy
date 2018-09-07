//
//  WLDangerModel.h
//  waterConservancy
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDangerModel : NSObject
//GUID
@property (nonatomic, copy) NSString *guid;
//危险源名称 HAZ_NAME
@property (nonatomic, copy) NSString *name;
//所属工程 ENG_GUID
@property (nonatomic, copy) NSString *engGuid;
@property (nonatomic, copy) NSString *engName;
//危险源等级 HIDD_GRAD
@property (nonatomic, copy) NSString *grad;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end
