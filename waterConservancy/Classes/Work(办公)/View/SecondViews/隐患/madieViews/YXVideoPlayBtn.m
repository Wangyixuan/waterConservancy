
//
//  YXVideoPlayBtn.m
//  河掌治
//
//  Created by liu on 2018/4/16.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXVideoPlayBtn.h"
@interface YXVideoPlayBtn()
@property (nonatomic, weak) UIImageView *imgV;

@end
@implementation YXVideoPlayBtn
-(instancetype)init{
    if (self = [super init]) {
        @weakify(self);
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(weak_self);
        }];
        [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weak_self.mas_right).offset(SCALE_W(30));
            make.bottom.mas_equalTo(weak_self.mas_top).offset(SCALE_W(50));
            make.width.height.mas_equalTo(SCALE_W(80));
        }];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        @weakify(self);
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(weak_self);
            make.height.width.mas_equalTo(SCALE_W(65));
        }];
        [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weak_self.mas_right).offset(SCALE_W(30));
            make.bottom.mas_equalTo(weak_self.mas_top).offset(SCALE_W(50));
            make.width.height.mas_equalTo(SCALE_W(80));
        }];
    }
    return self;
}
-(UIImageView *)imgV{
    if (!_imgV) {
        UIImageView *imgV = [[UIImageView alloc]init];
        UIImage *img = [UIImage imageNamed:@"play"];
        NSLog(@"%@",img);
        [imgV setImage:[UIImage imageNamed:@"play"]];
        [self.imageView addSubview:imgV];
        _imgV = imgV;
    }
    return _imgV;
}
-(UIButton *)delBtn{
    if (!_delBtn) {
        UIButton *delBtn = [[UIButton alloc]init];
        [delBtn setImage:[UIImage imageNamed:@"updel"] forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(delPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:delBtn];
        _delBtn = delBtn;
    }
    
    return _delBtn;
}
-(void)delPhoto{
    if (self.videodelBtnBlock) {
        self.videodelBtnBlock();
    }
    [self removeFromSuperview];
}
@end
