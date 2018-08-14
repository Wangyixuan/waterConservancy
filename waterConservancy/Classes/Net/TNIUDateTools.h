//
//  TNIUDateTools.h
//  multiChannelApp
//
//  Created by 刘德健 on 17/9/13.
//  Copyright © 2017年 刘德健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNIUDateTools : NSObject

//计算两个时间的时间差 返回的是interval 获取秒数除以60
+(NSTimeInterval )intervalFromLastDateStr: (NSString *) dateString1  toTheDateStr:(NSString *) dateString2;

+(NSString *)HZintervalFromDateStr:(NSString *)dateStr;//距离今天的时间
//String转换为interval (毫秒)
+(NSTimeInterval )intervalFromString: (NSString *) dateString;
+(NSTimeInterval )intervalFromDate: (NSDate *) date;
//时间戳转str yyyymmdd
+(NSString *)stringFromInterval: (NSTimeInterval ) interval;
//yyyymmdd hhmmss
+(NSString *)stringFromInterval2: (NSTimeInterval ) interval;
//date转string yyyy--mm--dd格式
+(NSString *)shortStringFromdate:(NSDate *)date;
//yyyyMMdd HHmmss
+(NSString *)yyyyMMddHHmmssFromdate:(NSDate *)date;
//string转date类型
+(NSDate *)shortDateFromString:(NSString *)dateStr;
//获得今日数据  yyyy-MM-dd HH:mm:ss
+(NSString *)Today;
//yyyyMMdd
+(NSString *)anptherToday;
//计算当月的天数
+(long)howManyDaysInThisMonth:(int)year month:(int)imonth;
//今天的interval
+(NSTimeInterval)nowIntervalFrom1970;
//两个时间相差多久 （分钟，小时，天，月）
+(NSString *)howTimeFromInterval:(long)interval;
//00:00:00
+(NSString *)TimeFormat:(long)interval;
//3'44''
+(NSString *)TimeFormatConversion:(long)time;

+(NSString *)TimeFormatConversionSecond:(long)time;
@end
