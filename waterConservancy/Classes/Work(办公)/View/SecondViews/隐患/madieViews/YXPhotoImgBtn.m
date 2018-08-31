//
//  YXPhotoImgBtn.m
//  河掌治
//
//  Created by liu on 2018/4/16.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXPhotoImgBtn.h"
@interface YXPhotoImgBtn()
@property (nonatomic, weak) UIImageView *imgV;
@property (nonatomic, weak) UIButton *delBtn;
@end
@implementation YXPhotoImgBtn


-(instancetype)init{
    if (self = [super init]) {
        @weakify(self);
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(weak_self);
        }];
       
        
        [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weak_self.mas_right).offset(SCALE_W(30));
            make.bottom.mas_equalTo(weak_self.mas_top).offset(SCALE_W(50));
            make.width.height.mas_equalTo(SCALE_W(80));
        }];
    }
    return self;
}
-(void)loadImg:(UIImage *)img{
    [self.imgV setImage:img];
//    [self.imgV setImage:img forState:UIControlStateNormal];
}
-(UIImageView *)imgV{
    if (!_imgV) {
        UIImageView *imgV = [[UIImageView alloc]init];
        imgV.contentMode = UIViewContentModeScaleToFill;
        imgV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigerClick)];
        [imgV addGestureRecognizer:tap];
        [self addSubview:imgV];
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
-(void)bigerClick{
    if (self.biggerBlock) {
        self.biggerBlock();
    }
}
-(void)delPhoto{
    if (self.delBtnBlock) {
        self.delBtnBlock();
    }
    [self removeFromSuperview];
}


@end
