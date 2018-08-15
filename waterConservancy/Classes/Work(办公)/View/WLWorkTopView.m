//
//  WLWorkTopView.m
//  waterConservancy
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLWorkTopView.h"
#import "WLVerticalButton.h"

@interface WLWorkTopView()

@property (nonatomic, weak) UIButton *userInfoBtn;
@property (nonatomic, weak) UIButton *QRCodeBtn;
@property (nonatomic, weak) UIButton *nearBtn;
@property (nonatomic, weak) WLVerticalButton *agencyWorkBtn;
@property (nonatomic, weak) WLVerticalButton *noticeBtn;

@property (nonatomic, weak) UILabel *navTitleLab;
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UIView *lineView;
@end

@implementation WLWorkTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)noticeBtnClick{
    if (self.noticeBlock) {
        self.noticeBlock();
    }
}
-(void)agencyWorkBtnClick{
    if (self.agencyWorkBlock) {
        self.agencyWorkBlock();
    }
}
-(void)userInfoBtnClick{
    if (self.userInfoBlock) {
        self.userInfoBlock();
    }
}
-(void)nearBtnClick{
    if (self.nearBlock) {
        self.nearBlock();
    }
}
-(void)QRCodeBtnClick{
    if (self.QRCodeBlock) {
        self.QRCodeBlock();
    }
}

-(void)setupUI{
    @weakify(self);
    self.backgroundColor = [UIColor redColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat H = KStatusbarHeight;
        make.top.mas_equalTo(70+H);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.bottom.mas_equalTo(-25);
        make.width.mas_equalTo(1);
        make.center.mas_equalTo(weak_self.bgView);
    }];
    [self.noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(-25);
        make.left.mas_equalTo(weak_self.lineView.mas_right).offset(25);
    }];
    [self.agencyWorkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(weak_self.noticeBtn);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(weak_self.lineView.mas_right).offset(-25);
    }];
    [self.userInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(KStatusbarHeight);
    }];
    [self.QRCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(weak_self.userInfoBtn.mas_centerY);
    }];
    [self.nearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.QRCodeBtn.mas_left).offset(-10);
        make.centerY.mas_equalTo(weak_self.userInfoBtn.mas_centerY);
    }];
    [self.navTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weak_self.userInfoBtn.mas_centerY);
        make.centerX.mas_equalTo(0);
    }];
}
-(UIView*)bgView{
    if (!_bgView) {
        UIView *bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 10.f;
        bgView.layer.masksToBounds = YES;
        [self addSubview:bgView];
        _bgView = bgView;
    }
    return _bgView;
}
-(UIImageView*)bgImageView{
    if (!_bgImageView) {
        UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home"]];
        [self addSubview:bg];
        [self insertSubview:bg belowSubview:self.bgView];
        _bgImageView = bg;
    }
    return _bgImageView;
}
-(UIView*)lineView{
    if (!_lineView) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.bgView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

-(WLVerticalButton*)noticeBtn{
    if (!_noticeBtn) {
        WLVerticalButton *btn = [[WLVerticalButton alloc]init];
        [btn remindButtonWithRemindNum:1];
        [btn setTitle:@"通知提醒" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nitify_cuiban"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nitify_cuiban"] forState:UIControlStateHighlighted];
        btn.backgroundColor = [UIColor blueColor];
        [btn addTarget:self action:@selector(noticeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
        _noticeBtn = btn;
        
    }
    return _noticeBtn;
}

-(WLVerticalButton*)agencyWorkBtn{
    if (!_agencyWorkBtn) {
        WLVerticalButton *btn = [[WLVerticalButton alloc]init];
        [btn remindButtonWithRemindNum:1];
        [btn setTitle:@"待办工作" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nitify_cuiban"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"nitify_cuiban"] forState:UIControlStateHighlighted];
        btn.backgroundColor = [UIColor blueColor];
        [btn addTarget:self action:@selector(agencyWorkBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
        _agencyWorkBtn = btn;
        
    }
    return _agencyWorkBtn;
}

-(UIButton*)userInfoBtn{
    if (!_userInfoBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
         btn.backgroundColor = [UIColor blueColor];
         [btn addTarget:self action:@selector(userInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _userInfoBtn = btn;
    }
    return _userInfoBtn;
}
-(UIButton*)nearBtn{
    if (!_nearBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
         btn.backgroundColor = [UIColor blueColor];
         [btn addTarget:self action:@selector(nearBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _nearBtn = btn;
    }
    return _nearBtn;
}
-(UIButton*)QRCodeBtn{
    if (!_QRCodeBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
         btn.backgroundColor = [UIColor blueColor];
         [btn addTarget:self action:@selector(QRCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _QRCodeBtn = btn;
    }
    return _QRCodeBtn;
}
-(UILabel*)navTitleLab{
    if (!_navTitleLab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor whiteColor];
        lab.font = YX30Font;
        lab.backgroundColor = [UIColor blackColor];
        lab.text = @"办公";
        [self addSubview:lab];
        _navTitleLab = lab;
    }
    return _navTitleLab;
}

@end
