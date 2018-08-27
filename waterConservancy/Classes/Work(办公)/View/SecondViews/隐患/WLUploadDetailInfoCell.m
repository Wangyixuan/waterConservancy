//
//  WLUploadDetailInfoCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLUploadDetailInfoCell.h"

@interface WLUploadDetailInfoCell()
@property (nonatomic, weak) UIImageView *topBgImageView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UIImageView *bottomBgImageView;
@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UIView *lineView1;
@property (nonatomic, weak) UIView *lineView2;
@property (nonatomic, weak) UIView *lineView3;
@property (nonatomic, weak) UILabel *nameTitleLab;
@property (nonatomic, weak) UILabel *gradTitleLab;
@property (nonatomic, weak) UILabel *descTitleLab;
@property (nonatomic, weak) UILabel *onSpotTitleLab;
@property (nonatomic, weak) UIButton *vioceBtn;
@property (nonatomic, weak) UIButton *addPhotoBtn;
@property (nonatomic, weak) UITextField *nameText;
@property (nonatomic, weak) UITextField *gradText;
@property (nonatomic, weak) YYTextView *descTextfield;
@end

@implementation WLUploadDetailInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initUI{
    @weakify(self)
    [self.topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weak_self.contentView).offset(5);
        make.right.mas_equalTo(weak_self.contentView).offset(-5);
        make.height.mas_equalTo(15);
    }];
    [self.bottomBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.contentView).offset(5);
        make.right.bottom.mas_equalTo(weak_self.contentView).offset(-5);
        make.height.mas_equalTo(15);
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.contentView).offset(5);
        make.right.mas_equalTo(weak_self.contentView).offset(-5);
        make.top.mas_equalTo(weak_self.topBgImageView.mas_bottom);
        make.bottom.mas_equalTo(weak_self.bottomBgImageView.mas_top);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.bgImageView.mas_left).offset(10);
        make.right.mas_equalTo(weak_self.bgImageView.mas_right).offset(-10);
        make.top.mas_equalTo(weak_self.contentView).offset(75);
        make.height.mas_equalTo(1);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.bgImageView.mas_left).offset(10);
        make.right.mas_equalTo(weak_self.bgImageView.mas_right).offset(-10);
        make.top.mas_equalTo(weak_self.lineView1).offset(75);
        make.height.mas_equalTo(1);
    }];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.bgImageView.mas_left).offset(10);
        make.right.mas_equalTo(weak_self.bgImageView.mas_right).offset(-10);
        make.top.mas_equalTo(weak_self.lineView2).offset(75);
        make.height.mas_equalTo(1);
    }];
}

-(UIImageView*)topBgImageView{
    if (!_topBgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow1"]];
        [self.contentView addSubview:img];
        _topBgImageView = img;
    }
    return _topBgImageView;
}
-(UIImageView*)bottomBgImageView{
    if (!_bottomBgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow3"]];
        [self.contentView addSubview:img];
        _bottomBgImageView = img;
    }
    return _bottomBgImageView;
}
-(UIImageView*)bgImageView{
    if (!_bgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow2"]];
        [self.contentView addSubview:img];
        _bgImageView = img;
    }
    return _bgImageView;
}
-(UIView*)lineView1{
    if (!_lineView1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:view];
        _lineView1 = view;
    }
    return _lineView1;
}
-(UIView*)lineView3{
    if (!_lineView3) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:view];
        _lineView3 = view;
    }
    return _lineView3;
}
-(UIView*)lineView2{
    if (!_lineView2) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:view];
        _lineView2 = view;
    }
    return _lineView2;
}
@end
