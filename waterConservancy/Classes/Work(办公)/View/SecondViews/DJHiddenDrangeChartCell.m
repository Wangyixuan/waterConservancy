//
//  DJHiddenDrangeChartCell.m
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJHiddenDrangeChartCell.h"
@interface DJHiddenDrangeChartCell()
@property (nonatomic, weak) UIView  *MyContentView;
@property (nonatomic, weak) UIImageView *backImgV;
/** 姓名 */
@property (nonatomic, weak) UILabel *nameLabel;
/**  催办按钮 */
@property (nonatomic, weak) UIButton *cuibanBtn;

@property (nonatomic, strong)DJMonthListModel  *model;
@end
@implementation DJHiddenDrangeChartCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)initDataWithModel:(DJMonthListModel *)model{
    
    [self.nameLabel setText:model.repName];
    
    self.model = model;
}


#pragma mark 催办
-(void)cuibanClick{
    if (self.hiddenChartBtnClickBlock) {
        self.hiddenChartBtnClickBlock(self.model);
    }
}

-(void)initUI{
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
    
    [self.cuibanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.MyContentView.mas_right)
        .offset(SCALE_W(-20));
        make.centerY.mas_equalTo(weak_self.MyContentView.mas_centerY);
        make.width.mas_equalTo(SCALE_W(100));
        make.height.mas_equalTo(SCALE_W(40));
    }];
    self.cuibanBtn.layer.cornerRadius = SCALE_W(20);
    self.cuibanBtn.layer.masksToBounds = YES;
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.MyContentView.mas_left).offset(SCALE_W(20));
        make.centerY.mas_equalTo(weak_self.MyContentView.mas_centerY);
        make.right.mas_equalTo(weak_self.cuibanBtn.mas_left).offset(SCALE_W(20));
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
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setText:@"2018年4月隐患报表"];
        [nameLabel setTextColor:FColor(51.0, 51.0, 51.0, 1.0)];
        [nameLabel setFont:YX30Font];
        [nameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.backImgV addSubview:nameLabel];
        _nameLabel =nameLabel;
    }
    return _nameLabel;
}
-(UIButton *)cuibanBtn{
    if (!_cuibanBtn) {
        UIButton *cuibanBtn = [[UIButton alloc]init];
        [cuibanBtn setTitle:@"上报" forState:UIControlStateNormal];
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


@end
