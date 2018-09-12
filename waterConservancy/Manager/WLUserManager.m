//
//  WLUserManager.m
//  waterConservancy
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLUserManager.h"


@interface WLUserManager()

@end

@implementation WLUserManager
@synthesize autoLoginEnabled=_autoLoginEnabled;

static dispatch_once_t once;
static WLUserManager*instance;

+ (instancetype)sharedUserManager {
    
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

+ (void)releaseSingleton {
    
    once = 0;
    instance = nil;
    
}

-(instancetype)init
{
    if(self=[super init])
    {
        
    }
    return self;
}

-(void)updateUserInfoWithDataDic:(NSDictionary *)infoDic{
    WLShareUserManager.persName = [infoDic stringForKey:@"persName" defaultValue:@""];
    WLShareUserManager.persID = [infoDic stringForKey:@"persId" defaultValue:@""];
    NSString *orgIDStr = [infoDic stringForKey:@"orgId" defaultValue:@""];
    WLShareUserManager.orgID =orgIDStr;
    [[NSUserDefaults standardUserDefaults]setObject:orgIDStr forKey:@"ORGID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    WLShareUserManager.mobileNub = [infoDic stringForKey:@"mobilenumb" defaultValue:@""];
    NSString *waterIndustryStr = [infoDic stringForKey:@"isWaterIndustry" defaultValue:@""];
    WLShareUserManager.isWaterIndustry = [waterIndustryStr intValue];
    [[NSUserDefaults standardUserDefaults]setObject:waterIndustryStr forKey:@"isWaterIndustry"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    WLShareUserManager.userCode = [infoDic stringForKey:@"userCode" defaultValue:@""];
}

/** 是否开启了自动登录 */
- (BOOL)isAutoLoginEnabled {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        self.autoLoginEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:@"autoLoginEnabled"];
    });
    return _autoLoginEnabled;
}

/** 设置自动登录状态 */
- (void)setAutoLoginEnabled:(BOOL)autoLoginEnabled {
    
    if (_autoLoginEnabled != autoLoginEnabled) {
        [[NSUserDefaults standardUserDefaults] setBool:autoLoginEnabled forKey:@"autoLoginEnabled"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    _autoLoginEnabled = autoLoginEnabled;
}

-(NSString *)userName{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        self.userName = [[NSUserDefaults standardUserDefaults] stringForKey:@"currentUser"];
    });
    return _userName;
}

-(NSString *)passWord{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
       self.passWord = [[NSUserDefaults standardUserDefaults] stringForKey:@"currentPassword"];
    });
    return _passWord;
}
@end
