//
//  TNIUDateTools.m
//  multiChannelApp
//
//  Created by 刘德健 on 17/9/13.
//  Copyright © 2017年 刘德健. All rights reserved.
//

#import "TNIUDateTools.h"

@implementation TNIUDateTools

//两个时间之差
+(NSTimeInterval )intervalFromLastDateStr: (NSString *) dateString1  toTheDateStr:(NSString *) dateString2
{
    
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    
    
    NSTimeInterval cha=late2-late1;
    return cha;
}

+(NSString *)HZintervalFromDateStr:(NSString *)dateStr{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d1 = [date dateFromString:dateStr];
    
    NSDate* current_date = [[NSDate alloc] init];
    NSTimeInterval late = [d1 timeIntervalSinceDate:current_date];
    int min = (int)late/60;
    int hour = min/60;
    int day = hour/24;
    NSString *str;
    if (min<0) {
        str = @"已逾期";
    }else if (min < 60) {
        if (min == 0) {
            min = 1;
        }
        str = [NSString stringWithFormat:@"%d分钟后逾期",min];
    }else if(hour<24){
        str = [NSString stringWithFormat:@"%d小时后逾期",hour];
    }else if(day>=1){
        str = dateStr;
    }
    
    return str;
}


+(NSTimeInterval )intervalFromString: (NSString *) dateString
{
    
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *d1=[date dateFromString:dateString];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1000;
    
    return late1;
}
+(NSString *)stringFromInterval: (NSTimeInterval ) interval
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;;
}
+(NSString *)stringFromInterval2: (NSTimeInterval ) interval
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;;
}

+(NSTimeInterval )intervalFromDate: (NSDate *) date
{
    
    
//    NSDateFormatter *date=[[NSDateFormatter alloc] init];
//    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *d1=[date dateFromString:dateString];
    
    NSTimeInterval late1=[date timeIntervalSince1970]*1000;
    
    
    
    
    
    
    return late1;
}

+(NSString *)shortStringFromdate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localZone];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
+(NSString *)yyyyMMddHHmmssFromdate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localZone];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
+(NSDate *)shortDateFromString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localZone];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    //NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateStr intValue]];
    //NSString *strDate = [dateFormatter stringFromDate:date];
    return date;
}
+(NSString *)Today{
    NSDate *curDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localZone];
    
    
    NSString *todayS = [dateFormatter stringFromDate:curDate];
    return todayS;
}
+(NSString *)anptherToday{
    NSDate *curDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localZone];
    NSString *todayS = [dateFormatter stringFromDate:curDate];
    return todayS;
}
//获得当月的天数
+(long)howManyDaysInThisMonth:(int)year month:(int)imonth {
    
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11)){
        return 30;
    }else if((year%4 == 01)||(year%4 == 02)||(year%4 == 30))
    {
        return 28;
    }else if(year%400 == 0){
        return 29;
    }else if(year%100 == 0){
        return 28;
    }else{
        return 31;
    }
    
}

//现在的interval
+(NSTimeInterval)nowIntervalFrom1970{
    NSDate *curdate = [NSDate date];
    NSTimeInterval late=[curdate timeIntervalSince1970]*1;
    return late;
    
}

+(NSString *)howTimeFromInterval:(long)interval{
    int min = (int)interval/60;
    int hour = min/60;
    int day = hour/24;
    int month = day/30;
    if (min < 60) {
        NSString *str = [NSString stringWithFormat:@"%d分钟前",min];
        return str;
    }else if(hour<24){
        NSString *str = [NSString stringWithFormat:@"%d小时前",hour];
        return str;
    }else if(day<30){
        NSString *str = [NSString stringWithFormat:@"%d天前",day];
        return str;
    }else {
        NSString *str = [NSString stringWithFormat:@"%d月前",month];
        return str;
    }
    
}
+(NSString *)TimeFormat:(long)interval{
    long minutes = interval%60;
    long min = (int)interval/60;
    long hour = min/60;
    NSString *time = @"";
    if (hour>0) {
        min = (interval-3600 *hour)/60;
        time = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,min,minutes];
    }else{
        time = [NSString stringWithFormat:@"00:%02ld:%02ld",min,minutes];
    }
    return time;
}
+(NSString *)TimeFormatConversion:(long)time{
    NSString *timeStr;
//    NSString *minuteS = @"";
//    NSString *secondS = @"";
    long minute = time/60;
    if (minute == 0) {
        timeStr = @"0.00h";
    }else{
        timeStr = [NSString stringWithFormat:@"%.02fh",((double)minute) / 60];
    }
    return timeStr;
}
+(NSString *)TimeFormatConversionSecond:(long)time{
    NSString *timeStr;
    long minute = time/60;
    if (minute < 60) {
        timeStr = [NSString stringWithFormat:@"%.02fm",((double)time) / 60];
    }else{
        timeStr = [NSString stringWithFormat:@"%.02fh",((double)minute) / 60];
    }
    
    return timeStr;
}




@end
