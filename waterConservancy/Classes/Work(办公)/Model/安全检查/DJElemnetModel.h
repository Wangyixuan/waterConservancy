//
//  DJElemnetModel.h
//  waterConservancy
//
//  Created by liu on 2018/8/20.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJElemnetModel : NSObject
//"guid": "1AEC2C6E5850410F9E7A555D8A3CF6D2",
//"seName": "职责目标",
//"seCode": null,
//"seType": null,
//"note": null,
//"collTime": "2013-09-16 17:03:03",
//"updTime": "2018-03-05 15:37:27",
//"recPers": null,
//"engStat": "2",
//"pGuid": null
@property (nonatomic, copy) NSString *guid;
@property (nonatomic, copy) NSString *seName;
@property (nonatomic, copy) NSString *seCode;
@property (nonatomic, copy) NSString *seType;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *collTime;
@property (nonatomic, copy) NSString *updTime;
@property (nonatomic, copy) NSString *recPers;
@property (nonatomic, copy) NSString *engStat;
@property (nonatomic, copy) NSString *pGuid;

@property (nonatomic, copy) NSString *seStat;//元素状态
@property (nonatomic, copy) NSString *seGuid;
@end
