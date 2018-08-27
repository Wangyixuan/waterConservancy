//
//  WLOnSpotCheckModel.h
//  waterConservancy
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLOnSpotCheckModel : NSObject

@property (nonatomic, copy) NSString *checkTimeStr;
@property (nonatomic, copy) NSString *checkNoteStr;
@property (nonatomic, copy) NSString *sinsGuidStr;
@property (nonatomic, copy) NSString *startTimeStr;
@property (nonatomic, copy) NSString *endTimeStr;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end
