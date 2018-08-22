//
//  DJElemnetModel.h
//  waterConservancy
//
//  Created by liu on 2018/8/20.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJElemnetModel : NSObject
//"username": null,
//"timestamp": null,
//"nonce": null,
//"appkey": null,
//"appsecret": null,
//"sign": null,
//"guid": "99E726D858B9490B9840BC16F79732A4",
//"seChitName": "是否组织开展安全文化活动？",
//"seGuid": "B8B9E3C0294A451E8C86A82B0BEF2DE0",
//"ifUnStan": "0",
//"deduScore": "10",
//"reviItemCode": "1.5.1",
//"deduRegu": "1",
//"ifWhit": "1 ",
//"note": "550",
//"collDate": "2018-04-10 15:14:44",
//"updDate": null,
//"recPers": null,
//"ifReasLack": "0"
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *nonce;
@property (nonatomic, copy) NSString *appkey;
@property (nonatomic, copy) NSString *appsecret;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *guid;
@property (nonatomic, copy) NSString *seChitName;
@property (nonatomic, copy) NSString *seGuid;
@property (nonatomic, copy) NSString *ifUnStan;
@property (nonatomic, copy) NSString *deduScore;
@property (nonatomic, copy) NSString *reviItemCode;
@property (nonatomic, copy) NSString *deduRegu;
@property (nonatomic, copy) NSString *ifWhit;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *collDate;
@property (nonatomic, copy) NSString *updDate;
@property (nonatomic, copy) NSString *recPers;
@property (nonatomic, copy) NSString *ifReasLack;

@property (nonatomic, copy) NSString *seStat;//元素状态
@end
