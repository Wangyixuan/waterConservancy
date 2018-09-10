//
//  WLDangerModel.h
//  waterConservancy
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//
//appkey = "<null>";
//appsecret = "<null>";
//collTime = "2018-08-11 16:32:32";
//engGuid = f96bed871b39457ea778eabcb3379428;
//guid = 1c1b955e7fe54e50a28c4d38c17e5f1b;
//harmRisk = "<null>";
//hazCode = "<null>";
//hazName = 58;
//hiddGrad = 2;
//ifLiceNoti = 2;
//moniPrec = "<null>";
//nonce = "<null>";
//note = "<null>";
//offiTel = 15858585858;
//orgGuid = 21260E691D454685B61086E7F2074B71;
//partLat = "<null>";
//partLong = "<null>";
//patPers = "<null>";
//proPart = "<null>";
//recPers = "<null>";
//sign = "<null>";
//supPers = 58;
//tendGuid = "<null>";
//timestamp = "<null>";
//updTime = "<null>";
//username = "<null>";
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
//上报时间 collTime
@property (nonatomic, copy) NSString *collTime;
//所属单位 ORG_GUID
@property (nonatomic, copy) NSString *orgGuid;
@property (nonatomic, copy) NSString *orgName;
//监控防范措施 MONI_PREC
@property (nonatomic, copy) NSString *moniPrec;
//可能造成的危害风险 HARM_RISK
@property (nonatomic, copy) NSString *harmRisk;
//监管责任人联系电话 OFFI_TEL
@property (nonatomic, copy) NSString *offiTel;
//监管责任人 SUP_PERS
@property (nonatomic, copy) NSString *supPers;
//是否已立牌公告 IF_LICE_NOTI
@property (nonatomic, copy) NSString *ifLiceNoti;


-(instancetype)initWithDic:(NSDictionary*)dic;

@end
