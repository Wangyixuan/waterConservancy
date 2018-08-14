//
//  YXSaveUserCell.m
//  河掌治
//
//  Created by liu on 2018/3/26.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXSaveUserCell.h"
@interface YXSaveUserCell()
@property (nonatomic, weak) UILabel *userNameLabel;

@property (nonatomic, weak) UIButton *delBtn;

@end
@implementation YXSaveUserCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}


-(void)setDataWithStr:(NSString *)str btnTag:(NSInteger)tag{
    [self.userNameLabel setText:str];
    self.delBtn.tag = tag;
}



-(void)delUserClick:(UIButton *)btn{
    if (self.delBlock) {
        self.delBlock(btn.tag);
    }
}
-(void)setUI{
    @weakify(self);
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.contentView.mas_left)
        .offset(SCALE_W(20));
        make.top.bottom.mas_equalTo(weak_self.contentView);
        make.width.mas_equalTo(SCALE_W(300));
    }];
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.contentView.mas_right)
        .offset(SCALE_W(-20));
        make.top.mas_equalTo(weak_self.contentView.mas_top)
        .offset(SCALE_H(5));
        make.bottom.mas_equalTo(weak_self.contentView.mas_bottom)
        .offset(SCALE_H(-5));
        make.width.mas_equalTo(SCALE_W(80));
    }];
    
    
}

-(UILabel *)userNameLabel{
    if (!_userNameLabel) {
        UILabel *label = [[UILabel alloc]init];
        [label setFont:YX28Font];
        [label setTextColor:YXWordColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _userNameLabel = label;
    }
    return _userNameLabel;
}
-(UIButton *)delBtn{
    if (!_delBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:nil forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(delUserClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"loaddel"] forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        _delBtn = btn;
    }
    return _delBtn;
}


@end
