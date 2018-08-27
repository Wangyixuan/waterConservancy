//
//  DJHiddenDangerModel.h
//  waterConservancy
//
//  Created by liu on 2018/8/17.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
// 隐患模型

#import <Foundation/Foundation.h>

@interface DJHiddenDangerModel : NSObject
//"guid": "54195AB9F7BA4E648F594281A923FD2C",
//"hiddName": "上游灌浆作业面配电箱内漏电保护器失灵",
//"engGuid": "610102000006                    ",
//"tendGuid": null,
//"seGuid": "1                               ",
//"orgGuid": "537AD1AB8E7447AAA249AB22A5344955",
//"hiddSour": "0",
//"hiddGrad": "2",
//"hiddClas": "20",
//"ifFound": null,
//"proPart": "洞内上游灌浆处",
//"partLong": null,
//"partLat": null,
//"hiddDesc": "上游灌浆作业面配电箱内漏电保护器失灵",
//"inspRecGuid": "55626d530d124a4e8f2a09b0e9bc0dfa",
//"seCheckItemGuid": "a3                              ",
//"hiddStat": "3",
//"hiddMergGuid": "3                               ",
//"recOrgGuid": null,
//"note": null,
//"collTime": "2018-04-08 17:25:03",
//"updTime": "2018-04-08 17:12:24",
//"recPers": null,
//"hiddsGuid": null,
//"occuNum": null,
//"sinsScheGuid": null
@property (nonatomic, copy) NSString *guid;
//隐患名称
@property (nonatomic, copy) NSString *hiddName;
//所属工程ID
@property (nonatomic, copy) NSString *engGuid;
//所属工程
@property (nonatomic, copy) NSString *hiddProjectName;
@property (nonatomic, copy) NSString *tendGuid;
@property (nonatomic, copy) NSString *seGuid;
@property (nonatomic, copy) NSString *orgGuid;
@property (nonatomic, copy) NSString *hiddSour;
//隐患级别
@property (nonatomic, copy) NSString *hiddGrad;
@property (nonatomic, copy) NSString *hiddClas;
@property (nonatomic, copy) NSString *ifFound;
@property (nonatomic, copy) NSString *proPart;
@property (nonatomic, copy) NSString *partLong;
@property (nonatomic, copy) NSString *partLat;
@property (nonatomic, copy) NSString *hiddDesc;
@property (nonatomic, copy) NSString *inspRecGuid;
@property (nonatomic, copy) NSString *seCheckItemGuid;
@property (nonatomic, copy) NSString *hiddStat;
@property (nonatomic, copy) NSString *hiddMergGuid;
@property (nonatomic, copy) NSString *recOrgGuid;
@property (nonatomic, copy) NSString *note;
//采集时间
@property (nonatomic, copy) NSString  *collTime;
@property (nonatomic, copy) NSString  *updTime;
@property (nonatomic, copy) NSString *recPers;
@property (nonatomic, copy) NSString *hiddsGuid;
@property (nonatomic, copy) NSString *occuNum;
@property (nonatomic, copy) NSString *sinsScheGuid;

-(instancetype)initWithDic:(NSDictionary*)dic;

@end
