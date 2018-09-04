//
//  WLAcciModel.h
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.

//事故模型 OBJ_ACCI

//"acciWiunType": "1",
//事故单位类型水利工程建设
//水利工程管理
//农村水电站及配套电网建设与运行
//水文测验
//水利工程勘探设计
//水利科学研究实验与检验
//后勤服务和综合经营
//其他

//"acciTreaResu": "1、杜怀义，男，承包施工队负责人。对该事故的发生负有主要责任，其行为涉嫌犯罪，建议司法机关依法追究其刑事责任。 2、杨启彬，男，安。",
//"occuTime": "2014-05-09 07:30:00",发生时间
//"PID": null,
//"acciCate": "01", 事故类别
//"casNum": 1,死亡人数
//"collTime": "2018-03-29 15:46:13", 采集时间
//"serInjNum": 0,重伤人数
//"occuLoc": null, 事故地点
//"id": "194D6E606AF040949770CC45D88DF6B2", guid
//"acciGrad": "1", 事故级别
//"acciSitu": 事故简要情况 "该项目部管理房施工于2014年5月9日早上7：30发生一起一人触电事故。死者闫奇奇，男，为该项目施工工人，由于在管理房顶层上拆卸模板，未",

//"ifPhoRep": "1", 是否电话上报
//"repStat": "0",快报状态
//"missNum": null, 失踪人数
//"rescTreaMeas": null,
//"acciCause": "施工工人操作不当",
//"acciWindGuid": null, 事故单位guid
//"note": null,
//"ifRespAcci": "2", 是否责任事故
//"econLoss": 75 直接经济损失

#import <Foundation/Foundation.h>

@interface WLAcciModel : NSObject
//事故名称 acciCause
@property (nonatomic, copy) NSString *accName;
//事故等级 ACCI_GRAD
@property (nonatomic, copy) NSString *accGrad;
//上报时间 COLL_TIME
@property (nonatomic, copy) NSString *collTime;
//补报 or 上报 REP_STAT
@property (nonatomic, copy) NSString *repStat;
//guid
@property (nonatomic, copy) NSString *guid;
//事故单位guid ACCI_WIUN_GUID
@property (nonatomic, copy) NSString *wiunGuid;
//事故单位名称
@property (nonatomic, copy) NSString *wiunName;
//"occuTime": "2014-05-09 07:30:00",发生时间
@property (nonatomic, copy) NSString *occuTime;
//"casNum": 1,死亡人数
@property (nonatomic, copy) NSString *deadNub;
//"serInjNum": 0,重伤人数
@property (nonatomic, copy) NSString *serInjNub;
//"acciSitu": 事故简要情况
@property (nonatomic, copy) NSString *accSitu;
//"ifPhoRep": "1", 是否电话上报
@property (nonatomic, strong) NSString *phoRep;
//"ifRespAcci": "2", 是否责任事故
@property (nonatomic, copy) NSString *respAcc;
//"econLoss": 75 直接经济损失
@property (nonatomic, copy) NSString *accLoss;

-(instancetype)initWithData:(NSDictionary*)dic;
@end
