//
//  YXRecordModel.h
//  河掌治
//
//  Created by liu on 2018/4/20.
//  Copyright © 2018年 liuDJ. All rights reserved.
//  协同单位整改后详情

#import <Foundation/Foundation.h>

@interface YXRecordModel : NSObject
//"ID": "001875e3-1de5-11e8-9e1d-005056a721d1",
//"userID": "fujianrong",
//"UserName": "付建荣",
//"RecordSerialKey": "92b28292-145b-4798-92af-f3413a3d74f3",
//"RecordContent": "233",
//"CreatedDate": ""
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *UserName;
@property (nonatomic, copy) NSString *RecordSerialKey;
@property (nonatomic, copy) NSString *RecordContent;
@property (nonatomic, copy) NSString *CreatedDate;
@end
