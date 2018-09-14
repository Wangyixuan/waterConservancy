//
//  WLPersonModel.h
//  waterConservancy
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLPersonModel : NSObject
//人员姓名
@property (nonatomic, copy) NSString *name;
//单位名
@property (nonatomic, copy) NSString *orgName;
//部门名
@property (nonatomic, copy) NSString *depName;
//手机
@property (nonatomic, copy) NSString *telNub;
//账号
@property (nonatomic, copy) NSString *userCode;
-(instancetype)initWithData:(NSDictionary*)dic;
@end
