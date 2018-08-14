//
//  YXBaseTableViewCell.m
//  河掌治
//
//  Created by liu on 2018/5/18.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXBaseTableViewCell.h"

@implementation YXBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).delaysContentTouches = NO; // Remove touch delay for iOS 7
            break;
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}
@end
