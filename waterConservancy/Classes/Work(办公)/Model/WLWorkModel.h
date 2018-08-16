//
//  WLWorkModel.h
//  waterConservancy
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLWorkModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *bgImage;
@property (nonatomic, strong) NSArray *data;


-(instancetype)initWithDic:(NSDictionary*)dic;

@end
