//
//  WLReportModel.h
//  waterConservancy
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLReportModel : NSObject

@property (nonatomic, copy) NSString *repName;
//上报状态 1已上报 2未上报已经上报  1退回重报2已撤销3申请撤销4同意撤销5不同意撤销6

@property (nonatomic, copy) NSString *repAct;
@property (nonatomic, copy) NSString *guid;

-(instancetype)initWithData:(NSDictionary*)dic;
@end
