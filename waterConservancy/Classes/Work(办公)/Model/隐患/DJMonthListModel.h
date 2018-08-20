//
//  DJMonthListModel.h
//  waterConservancy
//
//  Created by liu on 2018/8/17.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJMonthListModel : NSObject
//"username": null,
//"timestamp": null,
//"nonce": null,
//"appkey": null,
//"appsecret": null,
//"sign": null,
//"guid": "0bdb839b81ce4c06b59ce88464b63812",
//"repName": "2018ceshi",
//"repAct": "1",
//"url": null,
//"repType": null,
//"repTime": "2018年03月",
//"startDate": null,
//"endDate": null,
//"repOrgGuid": "61DAD04EDA934484949A202521B28605",
//"note": null,
//"collTime": "2018-03-27 15:24:29",
//"updTime": null,
//"recPers": null
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *nonce;
@property (nonatomic, copy) NSString *appkey;
@property (nonatomic, copy) NSString *appsecret;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *guid;
@property (nonatomic, copy) NSString *repName;
@property (nonatomic, copy) NSString *repAct;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *repType;
@property (nonatomic, copy) NSString *repTime;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *repOrgGuid;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *collTime;
@property (nonatomic, copy) NSString *updTime;
@property (nonatomic, copy) NSString *recPers;
@end
