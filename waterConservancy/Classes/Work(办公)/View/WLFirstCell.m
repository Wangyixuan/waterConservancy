//
//  WLFirstCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLFirstCell.h"
@interface WLFirstCell()
@property (nonatomic, weak) UILabel *lab;

@end

@implementation WLFirstCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor];
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self initUI];
}
-(void)initUI{
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-5);
    }];
}

-(UILabel*)lab{
    if (!_lab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"1123";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor whiteColor];
        lab.numberOfLines = 0;
        [self.contentView addSubview:lab];
        _lab = lab;
    }
    return _lab;
}

@end
