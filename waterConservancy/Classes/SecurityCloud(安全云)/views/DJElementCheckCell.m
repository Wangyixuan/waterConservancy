//
//  DJElementCheckCell.m
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJElementCheckCell.h"

@interface DJElementCheckCell()
@property (nonatomic, weak) UIView  *MyContentView;
@property (nonatomic, weak) UIImageView *backImgV;
@property (nonatomic, weak) UIButton *typeLabel;
@property (nonatomic, weak) UILabel  *elementLabel;
@end

@implementation DJElementCheckCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initElementCellUI];
    }
    return self;
}


#pragma mark UI
-(void)initElementCellUI{
    @weakify(self);
    [self.MyContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.mas_left).offset(SCALE_W(10));
        make.top.mas_equalTo(weak_self.mas_top).offset(SCALE_W(10));
        make.right.mas_equalTo(weak_self.mas_right).offset(SCALE_W(-10));
        make.bottom.mas_equalTo(weak_self.mas_bottom);
    }];
    [self.backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(weak_self.MyContentView);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.backImgV.mas_left).offset(SCALE_W(20));
        make.centerY.mas_equalTo(weak_self.backImgV.mas_centerY);
        make.width.mas_equalTo(SCALE_W(120));
        make.height.mas_equalTo(SCALE_W(60));
    }];
    self.typeLabel.layer.cornerRadius = 5;
    self.typeLabel.layer.masksToBounds = YES;
    
    [self.elementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.typeLabel.mas_right).offset(SCALE_W(20));
        make.right.mas_equalTo(weak_self.backImgV.mas_right).offset(SCALE_W(-20));
        make.centerY.mas_equalTo(weak_self.backImgV.mas_centerY);
    }];
    
}
-(UIView *)MyContentView{
    if (!_MyContentView) {
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        _MyContentView = view;
    }
    return _MyContentView;
}
-(UIImageView *)backImgV{
    if (!_backImgV) {
        UIImageView *imgV = [[UIImageView alloc]init];
        [imgV setImage:[UIImage imageNamed:@"work_cellbackimg"]];
        imgV.userInteractionEnabled = YES;
        [self.contentView addSubview:imgV];
        _backImgV = imgV;
    }
    return _backImgV;
}
-(UIButton *)typeLabel{
    if (!_typeLabel) {
        UIButton *TypeLabel = [[UIButton alloc]init];
        TypeLabel.backgroundColor = FColor(115.0, 203.0, 192.0, 1.0);
        [TypeLabel.titleLabel setFont:YX20Font];
        [TypeLabel setTitle:@"一般隐患" forState:UIControlStateNormal];
        [self.backImgV addSubview:TypeLabel];
        _typeLabel = TypeLabel;
    }
    return _typeLabel;
}
-(UILabel *)elementLabel{
    if (!_elementLabel) {
        UILabel *elementLabel = [[UILabel alloc]init];
        [elementLabel setText:@"元素名称元素名称元素名称"];
        [elementLabel setFont:YX30Font];
        [elementLabel setTextColor:FColor(51.0, 51.0, 51.0, 1.0)];
        [elementLabel setTextAlignment:NSTextAlignmentLeft];
        [self.backImgV addSubview:elementLabel];
        _elementLabel = elementLabel;
    }
    return _elementLabel;
}


@end
