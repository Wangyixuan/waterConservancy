//
//  WLActionManager.m
//  waterConservancy
//
//  Created by mac on 2018/8/20.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLActionManager.h"
#import "DJHiddenDrangeChartController.h"
#import "DJElementCheckController.h"
#import "DJOnSpotCheckController.h"


@implementation WLActionManager

static dispatch_once_t once;
static WLActionManager*instance;

+ (instancetype)sharedActionManager {
    
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
-(void)handleAction:(UIViewController *)viewController actionName:(NSString*)action{
    //报表管理
    if ([action isEqualToString:@"隐患报表"]) {
        DJHiddenDrangeChartController *hiddenCtrl = [[DJHiddenDrangeChartController alloc]init];
        [viewController.navigationController pushViewController:hiddenCtrl animated:YES];
    }
    else if ([action isEqualToString:@"事故报表"]){

    }
    else if ([action isEqualToString:@"检查报表"]){
        
    }
    else if ([action isEqualToString:@"考核报表"]){
        
    }

    //安全检查
    else if ([action isEqualToString:@"现场检查"]){
        
    }
    else if ([action isEqualToString:@"检查查询"]){
        
    }
    else if ([action isEqualToString:@"元素检查"]){
        
    }
    
    //隐患
    else if ([action isEqualToString:@"隐患验收"]){
        
    }
    else if ([action isEqualToString:@"隐患督办"]){
        
    }
    else if ([action isEqualToString:@"隐患上报"]){
        
    }
    else if ([action isEqualToString:@"隐患整改"]){
        
    }
    else if ([action isEqualToString:@"隐患销号"]){
        
    }
    
    //事故
    else if ([action isEqualToString:@"快报事故"]){
        
    }
    else if ([action isEqualToString:@"事故查询"]){
        
    }
    
    //风险源
    else if ([action isEqualToString:@"风险源巡查"]){
        
    }
    else if ([action isEqualToString:@"风险源查询"]){
        
    }
    
    //危险源
    else if ([action isEqualToString:@"备案审核"]){
        
    }
    else if ([action isEqualToString:@"核销审核"]){
        
    }
    
    //标准化
    else if ([action isEqualToString:@"形式初审"]){
        
    }
    else if ([action isEqualToString:@"材料初审"]){
        
    }
    else if ([action isEqualToString:@"现场复核"]){
        
    }
    else if ([action isEqualToString:@"审定"]){
        
    }
    else if ([action isEqualToString:@"公示"]){
        
    }
    else if ([action isEqualToString:@"公告"]){
        
    }
    
    //工作考核
    else if ([action isEqualToString:@"安全生产"]){
        
    }
    else if ([action isEqualToString:@"水利稽查"]){
        
    }
    
    //监督执法
    else if ([action isEqualToString:@"现场执法"]){
        
    }
    else if ([action isEqualToString:@"执法查询"]){
        
    }
    
    //水利稽查
    else if ([action isEqualToString:@"现场稽查"]){
        
    }
    else if ([action isEqualToString:@"稽查查询"]){
        
    }
}

@end
