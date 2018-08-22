//
//  WLUserManager.h
//  waterConservancy
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#define WLShareUserManager [WLUserManager sharedUserManager]

#import <Foundation/Foundation.h>
//企事业用户类型 ToB
//* 1 大中型已建工程运行管理单位 CJYJ
//* 2 大中型在建工程项目法人 CJFR
//* 3 小型工程管理单位和技术服务单位CJFW
//* 4 大中型在建工程施工单位  CJSG
//* 5 大中型在建工程监理单位 CJJL
typedef NS_ENUM(NSInteger,BUserType){
    BUserTypeCJYJ =0, //大中型已建工程运行管理单位
    BUserTypeCJFR =1, //大中型在建工程项目法人
    BUserTypeCJFW =2, //小型工程管理单位和技术服务单位
    BUserTypeCJSG =3, //大中型在建工程施工单位
    BUserTypeCJJL =4  //大中型在建工程监理单位
};
// 行政用户角色 ToC
typedef NS_ENUM(NSInteger,CUserType){
    CUserTypeAcci, // 安监-事故管理
    CUserTypeSins, // 安监-安全检查
    CUserTypeStan, // 安监-标准化评审管理
    CUserTypeMaha, // 安监-风险源监管
    CUserTypeWoas, // 安监-工作考核
    CUserTypeSuen, // 安监-监督执法
    CUserTypeWins, // 安监-水利稽察
    CUserTypeHidd  // 安监-隐患监管
};


@interface WLUserManager : NSObject
//企事业类型
@property (nonatomic, assign) BUserType bUserType;
//行政用户类型
@property (nonatomic, assign) CUserType cUserType;
// 0表示非水利机构  1表示水利机构  无此用户时为3
@property (nonatomic, assign) int isWaterIndustry;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *orgID;
@property (nonatomic, copy) NSString *mobileNub;
@property (nonatomic, copy) NSString *persName;
@property (nonatomic, copy) NSString *persID;
@property (nonatomic, strong) NSArray* roleList;
//自动登陆
@property(assign,nonatomic,getter=isAutoLoginEnabled) BOOL autoLoginEnabled;



+(instancetype)sharedUserManager;
-(void)updateUserInfoWithDataDic:(NSDictionary*)infoDic;

@end
