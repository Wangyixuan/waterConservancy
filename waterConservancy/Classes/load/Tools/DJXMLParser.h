//
//  DJXMLParser.h
//  waterConservancy
//
//  Created by liu on 2018/8/14.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJXMLParser : NSObject<NSXMLParserDelegate>
// 解析出的数据内部是字典类型
@property (strong, nonatomic) NSMutableArray *notes;
// 当前标签的名字
@property (strong, nonatomic) NSString *currentTagName;
// 开始解析
- (void)startXMLWithData:(NSData *)data;
@end
