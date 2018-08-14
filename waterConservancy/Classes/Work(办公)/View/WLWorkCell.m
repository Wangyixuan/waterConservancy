//
//  WLWorkCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLWorkCell.h"
@interface WLWorkCell()
@property (nonatomic, weak) UILabel *lab;

@end

@implementation WLWorkCell

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
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
    }];
}

-(UILabel*)lab{
    if (!_lab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"1123";
        lab.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:lab];
        _lab = lab;
    }
    return _lab;
}


@end
