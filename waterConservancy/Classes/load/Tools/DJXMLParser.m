//
//  DJXMLParser.m
//  waterConservancy
//
//  Created by liu on 2018/8/14.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJXMLParser.h"

@implementation DJXMLParser
- (void)startXMLWithData:(NSData *)data{
    // 开始解析XML
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
    
    parser.delegate = self;
    
    [parser parse];
    NSLog(@"解析完成。。。");
}
#pragma mark XMLDelegate
// 文档开始的时候触发
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    // 此方法只在解析开始时触发一次，因此可在这个方法中初始化解析过程中用到的一些成员变量
    _notes = [NSMutableArray new];
    
}
// 文档出错的时候触发
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@", parseError);
}
// 遇到一个开始标签的时候触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    // elementName是正在解析的元素的名字
    _currentTagName = elementName;
    // 如果元素名字为Note，取出它的属性id
    if ([_currentTagName isEqualToString:@"Note"]) {
        // 属性在attributeDict参数中传递过来，它是一个字典类型，其中的键的名字就是属性的名字，值是属性的值
        NSString *_id = [attributeDict objectForKey:@"id"];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:_id forKey:@"id"];
        [_notes addObject:dict];
    }
}
// 遇到字符串时候触发，该方法是解析元素文本内容主要场所
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // 剔除回车和空格
    // stringByTrimmingCharactersInSet：方法是剔除字符方法
    // [NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    NSMutableDictionary *dict = [_notes lastObject];
    if ([_currentTagName isEqualToString:@"CDate"] && dict) {
        [dict setObject:string forKey:@"CDate"];
    }
    if ([_currentTagName isEqualToString:@"Content"] && dict) {
        [dict setObject:string forKey:@"Content"];
    }
    if ([_currentTagName isEqualToString:@"UserID"] && dict) {
        [dict setObject:string forKey:@"UserID"];
    }
    
}
// 遇到结束标签时触发，在该方法中主要是清理刚刚解析完成的元素产生的影响，以便于不影响接下来的解析
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // 清理刚才解析的元素的名字，以便于记录接下来解析的元素的名字
    self.currentTagName = nil;
}
// 遇到文档结束时触发
- (void)parserDidEndDocument:(NSXMLParser *)parser {
// 使用通知机制将数据通过广播通知投送回表示层
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.notes userInfo:nil];
    // 解析完成，清理成员变量
    self.notes = nil;
    
}

    
  
@end
