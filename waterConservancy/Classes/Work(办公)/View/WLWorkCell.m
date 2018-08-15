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
@property (nonatomic, weak) UIImageView *img;
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
    @weakify(self);
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
        make.left.mas_equalTo(5);
    }];
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.img.mas_bottom);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(-5);
        make.height.mas_equalTo(15);
    }];
}

-(UILabel*)lab{
    if (!_lab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"1123";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:lab];
        _lab = lab;
    }
    return _lab;
}
-(UIImageView*)img{
    if (!_img) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nitify_cuiban"]];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:img];
        _img = img;
    }
    return _img;
}

@end
