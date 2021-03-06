//
//  DJOnSpotCheckCell.m
//  waterConservancy
//
//  Created by liu on 2018/8/16.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJOnSpotCheckCell.h"
#import "NSString+Size.h"

@interface DJOnSpotCheckCell()
//@property (nonatomic, weak) UIView  *MyContentView;
@property (nonatomic, weak) UIImageView *backImgV;
/** 姓名 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/**  催办按钮 */
@property (nonatomic, weak) UIButton *cuibanBtn;
@property (nonatomic, weak) UIView   *lineView;

@property (nonatomic, assign) CGFloat labH;

@end
@implementation DJOnSpotCheckCell
#define contentLabelWidth  ScreenWidth - SCALE_W(250)

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setModel:(WLOnSpotCheckModel *)model{
    _model = model;
    NSString *str = [NSString stringWithFormat:@"检查内容：%@",model.checkNoteStr];
    [self.contentLabel setText:str];
    self.nameLabel.text = model.checkTimeStr;
//    self.contentLabel.text = model.checkNoteStr;
}


#pragma mark 催办
-(void)cuibanClick{
    if (self.onSpotCheckBtnClickBlock) {
        self.onSpotCheckBtnClickBlock();
    }
}

-(void)initUI{
    @weakify(self);

    [self.backImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(weak_self.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(weak_self.backImgV).offset(SCALE_W(20));
        make.top.mas_equalTo(weak_self.backImgV).offset(SCALE_W(20));
        make.right.mas_equalTo(weak_self.backImgV.mas_right).offset(SCALE_W(-20));
        make.height.mas_equalTo(20);
//        make.bottom.mas_equalTo(weak_self.cuibanBtn.mas_top).offset(SCALE_W(-15));
    }];
    
    [self.cuibanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.backImgV.mas_right)
        .offset(SCALE_W(-20));
//        make.top.mas_equalTo(weak_self.nameLabel.mas_bottom);
        make.centerY.mas_equalTo(weak_self.backImgV.mas_centerY);
        make.width.mas_equalTo(SCALE_W(100));
        make.height.mas_equalTo(SCALE_W(45));
    }];
    self.cuibanBtn.layer.cornerRadius = SCALE_W(22.5);
    self.cuibanBtn.layer.masksToBounds = YES;
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.nameLabel.mas_left);
        make.top.mas_equalTo(weak_self.nameLabel.mas_bottom).offset(SCALE_W(20));
        make.width.mas_equalTo(SCALE_W(580));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.contentLabel.mas_bottom).offset(15);
        make.bottom.mas_equalTo(weak_self.contentView.mas_bottom);
        make.left.right.mas_equalTo(weak_self.contentView);
        make.height.mas_equalTo(1);
    }];
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setTextColor:COLOR_WITH_HEX(0x333333)];
//        nameLabel.backgroundColor = [UIColor redColor];

        [nameLabel setFont:YX30Font];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        nameLabel.numberOfLines = 1;
        [self.backImgV addSubview:nameLabel];
        _nameLabel =nameLabel;
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc]init];
        [contentLabel setTextColor:COLOR_WITH_HEX(0x999999)];
        [contentLabel setFont:YX26Font];
        contentLabel.preferredMaxLayoutWidth =SCALE_W(500);
        contentLabel.numberOfLines = 0;
//        contentLabel.backgroundColor = [UIColor redColor];
//        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [contentLabel setTextAlignment:NSTextAlignmentLeft];
        [self.backImgV addSubview:contentLabel];
        _contentLabel =contentLabel;
    }
    return _contentLabel;
}
-(UIButton *)cuibanBtn{
    if (!_cuibanBtn) {
        UIButton *cuibanBtn = [[UIButton alloc]init];
        [cuibanBtn setTitle:@"检查" forState:UIControlStateNormal];
        [cuibanBtn setBackgroundColor:FColor(0, 113.0, 226.0, 1.0)];
        [cuibanBtn.titleLabel setFont:YX26Font];
        [cuibanBtn setTintColor:FColor(255.0, 255.0, 255.0, 1.0)];
        [cuibanBtn addTarget:self action:@selector(cuibanClick) forControlEvents:UIControlEventTouchUpInside];
        [self.backImgV addSubview:cuibanBtn];
        _cuibanBtn = cuibanBtn;
    }
    return _cuibanBtn;
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
-(UIView *)lineView{
    if (!_lineView) {
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor redColor];
        [self.backImgV addSubview:view];
        _lineView = view;
    }
    return _lineView;
}

@end
