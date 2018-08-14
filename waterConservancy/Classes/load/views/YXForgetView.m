//
//  YXForgetView.m
//  河掌治
//
//  Created by liu on 2018/3/26.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXForgetView.h"

typedef void(^getPhone)(NSString *phoneNumber);
@interface YXForgetView()
//显示的内容框
@property (nonatomic, weak) UIView *contView;

@property (nonatomic, weak) UILabel *forgetLabel;

@property (nonatomic, weak) UILabel *detailLabel;

@property (nonatomic, weak) UILabel *phoneLabel;

@property (nonatomic, weak) UIButton *cancleBtn;

@property (nonatomic, weak) UIButton *callBtn;

@property (nonatomic, copy) NSString *phoneNumber;


@end
@implementation YXForgetView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self GetManagerPhone:^(NSString *phoneNumber) {
            NSString *str = [NSString stringWithFormat:@"联系电话:%@",phoneNumber];
            int length = (int)str.length;
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 5)];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(5,length-5)];
            self.phoneLabel.attributedText = attrStr;
        }];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setUI];
    
}

#pragma mark Private Method
//取消的方法
-(void)cancleClick{
    [self removeFromSuperview];
}
-(void)callClick{
    if (self.phoneNumber.length<=0) {
        return;
    }
    
    [self removeFromSuperview];
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",self.phoneNumber];

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}


-(void)GetManagerPhone:(getPhone)phoneBlock{
    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"WebApi/DataExchange/GetData/GetContactMobile?dataKey=00-00-00-00") Parmars:nil success:^(id responseObject) {
        NSDictionary *DIC1 = responseObject[@"DataSource"];
        NSArray *array = DIC1[@"Tables"];
        NSDictionary *DIC2 = array.firstObject;
        NSArray *array2 = DIC2[@"Datas"];
        NSDictionary *DIC3 = array2.firstObject;
        NSString *mobile = DIC3[@"Mobile"];
        self.phoneNumber = mobile;
        if (mobile.length<=0) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (phoneBlock) {
                phoneBlock(mobile);
            }
        });
       
    } faild:^ (NSError *error){
        
    }];
    
}


-(void)setUI{
//    self.backgroundColor = [UIColor grayColor];
    self.backgroundColor = FColor(66, 66, 66, 0.8);
    
    @weakify(self);
    [self.contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCALE_W(540));
        make.centerY.mas_equalTo(weak_self.mas_centerY);
        make.centerX.mas_equalTo(weak_self.mas_centerX);
        make.height.mas_equalTo(SCALE_H(334));
    }];
    self.contView.layer.cornerRadius = 10;
    self.contView.layer.masksToBounds = YES;
    
    
    [self.forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weak_self.contView);
        make.top.mas_equalTo(weak_self.contView.mas_top)
        .offset(SCALE_H(30));
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weak_self.contView);
        make.top.mas_equalTo(weak_self.forgetLabel.mas_bottom)
        .offset(SCALE_H(30));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weak_self.contView);
        make.top.mas_equalTo(weak_self.detailLabel.mas_bottom)
        .offset(SCALE_H(20));
    }];
    
    
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.contView.mas_left)
        .offset(SCALE_W(-1));
        make.bottom.mas_equalTo(weak_self.contView.mas_bottom)
        .offset(1);
        make.width.mas_equalTo(SCALE_W(270));
        make.height.mas_equalTo(SCALE_H(88));
    }];

    
    [self.callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.contView.mas_right)
        .offset(SCALE_W(1));
        make.bottom.mas_equalTo(weak_self.contView.mas_bottom)
        .offset(1);
        make.height.mas_equalTo(weak_self.cancleBtn);
        make.width.mas_equalTo(SCALE_W(272));
    }];
    
    
}

-(UIView *)contView{
    if (!_contView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        _contView = view;
    }
    return _contView;
}
-(UILabel *)forgetLabel{
    if (!_forgetLabel) {
        UILabel *label = [[UILabel alloc]init];
        [label setFont:YX34Font];
        [label setTextColor:[UIColor blackColor]];
        [label setText:@"忘记密码"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.contView addSubview:label];
        _forgetLabel = label;
    }
    return _forgetLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *label = [[UILabel alloc]init];
        [label setFont:YX28Font];
        [label setTextColor:[UIColor blackColor]];
        [label setText:@"请联系系统管理员完成密码重置"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.contView addSubview:label];
        _detailLabel = label;
    }
    return _detailLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        UILabel *label = [[UILabel alloc]init];
        [label setFont:YX28Font];
        [label setTextColor:[UIColor blackColor]];
        [label setText:@"联系电话:"];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        [self.contView addSubview:label];
        _phoneLabel = label;
    }
    return _phoneLabel;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn.titleLabel setFont:YX34Font];
        [btn setTitleColor:COLOR_WITH_HEX(0x007aff) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contView addSubview:btn];
        _cancleBtn = btn;
    }
    return _cancleBtn;
}
-(UIButton *)callBtn{
    if (!_callBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"呼叫" forState:UIControlStateNormal];
         btn.layer.borderWidth = 1;
         btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
        [btn.titleLabel setFont:YX34Font];
        [btn setTitleColor:COLOR_WITH_HEX(0x36c377) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(callClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contView addSubview:btn];
        _callBtn = btn;
    }
    return _callBtn;
}


@end
