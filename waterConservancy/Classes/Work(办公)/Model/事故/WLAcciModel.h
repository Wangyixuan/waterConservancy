//
//  WLAcciModel.h
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.

//事故模型 OBJ_ACCI

//"acciWiunType": "1",
//"acciTreaResu": "1、杜怀义，男，承包施工队负责人。对该事故的发生负有主要责任，其行为涉嫌犯罪，建议司法机关依法追究其刑事责任。 2、杨启彬，男，安。",
//"occuTime": "2014-05-09 07:30:00",
//"PID": null,
//"acciCate": "01",
//"casNum": 1,
//"collTime": "2018-03-29 15:46:13",
//"serInjNum": 0,
//"occuLoc": null,
//"id": "194D6E606AF040949770CC45D88DF6B2",
//"acciGrad": "1",
//"acciSitu": "该项目部管理房施工于2014年5月9日早上7：30发生一起一人触电事故。死者闫奇奇，男，为该项目施工工人，由于在管理房顶层上拆卸模板，未",
//"ifPhoRep": "1",
//"repStat": "0",
//"missNum": null,
//"rescTreaMeas": null,
//"acciCause": "施工工人操作不当",
//"acciWindGuid": null,
//"note": null,
//"ifRespAcci": "2",
//"econLoss": 75

#import <Foundation/Foundation.h>

@interface WLAcciModel : NSObject
//事故名称 acciCause
@property (nonatomic, copy) NSString *accName;
//事故等级 ACCI_GRAD
@property (nonatomic, copy) NSString *accGrad;
//所属工程 ENG_GUID
@property (nonatomic, copy) NSString *engGuid;
//上报时间 COLL_TIME
@property (nonatomic, copy) NSString *collTime;
//补报 or 上报 REP_STAT
@property (nonatomic, copy) NSString *repStat;
//guid
@property (nonatomic, copy) NSString *guid;
//事故单位guid ACCI_WIUN_GUID
@property (nonatomic, copy) NSString *wiunGuid;

-(instancetype)initWithData:(NSDictionary*)dic;
@end
