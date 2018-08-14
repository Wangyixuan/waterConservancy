//
//  YXNetTool.h
//  河掌治
//
//  Created by liu on 2018/3/23.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef void (^successBlock)(id responseObject);
typedef void (^faildBlock)(NSError *error);
typedef void (^NoNetBlock)(void);
typedef void (^NetBlock)(void);

@interface YXNetTool : NSObject
+ (instancetype)shareTool;

-(void)judgeNet:(NoNetBlock)noNetBlock;
//xwww格式post请求
+(void)XWWWRequestWithURL:(NSString *)URLStr Parmars:(NSString *)Parmarstr  success:(successBlock)success faild:(faildBlock)faild;
/**
 get请求不带缓存
 
 @param URL      <#URL description#>
 @param Parmars  <#Parmars description#>
 @param success  <#success description#>
 @param faild    <#faild description#>
 */
-(void)getRequestWithURL:(NSString *)URL Parmars:(NSDictionary *)Parmars  success:(successBlock)success faild:(faildBlock)faild;

/**
 post请求不带缓存
 
 @param URL      <#URL description#>
 @param Parmars
 @param success  <#success description#>
 @param faild    <#faild description#>
 */
-(void)postRequestWithURL:(NSString *)URL Parmars:(NSDictionary *)Parmars success:(successBlock)success faild:(faildBlock)faild;
@end
