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

@property (nonatomic, weak) UILabel *navTitleBtn;
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

-(void)setupUI{
    @weakify(self);
    self.backgroundColor = [UIColor redColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat H = KStatusbarHeight;
        make.top.mas_equalTo(70+H);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.width.mas_equalTo(1);
        make.center.mas_equalTo(weak_self.bgView);
    }];
    [self.noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.right.mas_equalTo(-25);
        make.left.mas_equalTo(weak_self.lineView.mas_right).offset(25);
    }];
    [self.agencyWorkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(weak_self.lineView.mas_right).offset(-25);
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
        [self.bgView addSubview:btn];
        _agencyWorkBtn = btn;
        
    }
    return _agencyWorkBtn;
}
@end
