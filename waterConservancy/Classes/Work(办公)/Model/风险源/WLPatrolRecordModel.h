//
//  WLPatrolRecordModel.h
//  waterConservancy
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

//"username": null,
//"timestamp": null,
//"nonce": null,
//"appkey": null,
//"appsecret": null,
//"sign": null,
//"guid": "1a8db0061c9445fca5470832cfbfdb30",
//"hazGuid": "12345678901234567890123456789012",
//"patTime": "2017-12-12 12:12:12",
//"patPers": null,
//"probFound": "问题",
//"treaMeas": "222",
//"note": null,
//"collTime": "2017-12-12 12:12:12",
//"updTime": null,
//"recPers": null

#import <Foundation/Foundation.h>

@interface WLPatrolRecordModel : NSObject
//巡视时间 PAT_TIME
@property (nonatomic, copy) NSString *patTime;
//巡视人员 PAT_PERS
@property (nonatomic, copy) NSString *patPers;
//发现问题 PROB_FOUND
@property (nonatomic, copy) NSString *probFound;
//处理措施 TREA_MEAS
@property (nonatomic, copy) NSString *treaMeas;

-(instancetype)initWithData:(NSDictionary*)dic;

@end
