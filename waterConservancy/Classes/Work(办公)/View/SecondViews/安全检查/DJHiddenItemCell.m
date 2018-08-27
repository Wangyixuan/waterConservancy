//
//  DJHiddenItemCell.m
//  waterConservancy
//
//  Created by liu on 2018/8/24.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJHiddenItemCell.h"
#import "DJHiddenDangerModel.h"
@interface DJHiddenItemCell()
@property (nonatomic, weak) UIView  *MyContentView;
@property (nonatomic, weak) UIImageView *backImgV;
@property (nonatomic, weak) UIButton *typeLabel;
/** 姓名 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 姓名 */
@property (nonatomic, weak) UILabel *TimeLabel;
/** 内容 */
@property (nonatomic, weak) UILabel *contentLabel;
@end
@implementation DJHiddenItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initHiddenItemUI];
    }
    return self;
}
-(void)initHiddenItemDataWithModel:(NSArray *)modelArray indexPath:(NSIndexPath *)indexpath{
    if (modelArray.count>0) {
        DJHiddenDangerModel *model = modelArray[indexpath.row];
        [self.nameLabel setText:model.hiddName];
        NSString *typeStr = @"2";
        if ([model.hiddStat isEqualToString:@"1"]) {
            typeStr = @"一般隐患";
            [self.typeLabel setBackgroundColor:FColor(64.0, 114.0, 216.0, 1.0)];
        }else if ([model.hiddStat isEqualToString:@"2"]){
            typeStr = @"重大隐患";
            [self.typeLabel setBackgroundColor:FColor(219.0, 44.0, 45.0, 1.0)];
        }else if ([model.hiddStat isEqualToString:@"3"]){
            typeStr = @"正常";
            [self.typeLabel setBackgroundColor:FColor(115.0, 203.0, 192.0, 1.0)];
        }else if ([model.hiddStat isEqualToString:@"4"]){
            typeStr = @"待查";
            [self.typeLabel setBackgroundColor:FColor(233.0, 164.0, 50.0, 1.0)];
        }
        [self.typeLabel setTitle:typeStr forState:UIControlStateNormal];
        NSArray *timeArray = [model.updTime componentsSeparatedByString:@" "];
        
        [self.TimeLabel setText:timeArray.firstObject];
        [self.contentLabel setText:[NSString stringWithFormat:@"所属工程:%@",model.proPart]];
    }
}


-(void)initHiddenItemUI{
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
        make.top.mas_equalTo(weak_self.backImgV.mas_top).offset(SCALE_W(20));
        make.width.mas_equalTo(SCALE_W(120));
        make.height.mas_equalTo(SCALE_W(40));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.typeLabel.mas_right).offset(SCALE_W(20));
        make.width.mas_equalTo(SCALE_W(350));
        make.centerY.mas_equalTo(weak_self.typeLabel.mas_centerY);
    }];
    [self.TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.backImgV.mas_right).offset(SCALE_W(-20));
        make.centerY.mas_equalTo(weak_self.typeLabel.mas_centerY);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.typeLabel.mas_left);
        make.top.mas_equalTo(weak_self.nameLabel.mas_bottom).offset(SCALE_W(20));
        make.right.mas_equalTo(weak_self.backImgV.mas_right).offset(SCALE_W(-20));
       
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
        [TypeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [TypeLabel.titleLabel setFont:YX20Font];
        [TypeLabel setTitle:@"一般隐患" forState:UIControlStateNormal];
        TypeLabel.layer.cornerRadius = 5;
        TypeLabel.layer.masksToBounds = YES;
        [self.backImgV addSubview:TypeLabel];
        _typeLabel = TypeLabel;
    }
    return _typeLabel;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setTextColor:COLOR_WITH_HEX(0x333333)];
        [nameLabel setFont:YX28Font];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        nameLabel.numberOfLines = 1;
        [self.backImgV addSubview:nameLabel];
        _nameLabel =nameLabel;
    }
    return _nameLabel;
}
-(UILabel *)TimeLabel{
    if (!_TimeLabel) {
        UILabel *TimeLabel = [[UILabel alloc]init];
        [TimeLabel setTextColor:COLOR_WITH_HEX(0x999999)];
        [TimeLabel setFont:YX26Font];
        [TimeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.backImgV addSubview:TimeLabel];
        _TimeLabel =TimeLabel;
    }
    return _TimeLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *contentLabel = [[UILabel alloc]init];
        [contentLabel setTextColor:COLOR_WITH_HEX(0x999999)];
        [contentLabel setFont:YX26Font];
        contentLabel.preferredMaxLayoutWidth =SCALE_W(500);
        contentLabel.numberOfLines = 0;
        [contentLabel setTextAlignment:NSTextAlignmentLeft];
        [self.backImgV addSubview:contentLabel];
        _contentLabel =contentLabel;
    }
    return _contentLabel;
}
@end
