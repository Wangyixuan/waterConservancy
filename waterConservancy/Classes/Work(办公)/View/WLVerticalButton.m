//
//  WLVerticalButton.m
//  waterConservancy
//
//  Created by mac on 2018/8/14.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLVerticalButton.h"
@interface WLVerticalButton()

@property (nonatomic, weak) UIImageView *redRotImgV;//消息的小圆点
@property (nonatomic, weak) UILabel     *remindNumberLabel;

@end

@implementation WLVerticalButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *0.7;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY , titleW, titleH);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = CGRectGetWidth(contentRect);
    CGFloat imageH = contentRect.size.height * 0.7;
    return CGRectMake(0, 0, imageW, imageH);
}

-(instancetype)init{
    if (self = [super init]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = YX20Font;
        self.titleLabel.textColor = COLOR_WITH_HEX(0x999999);
        [self initUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.font = YX20Font;
        self.titleLabel.textColor = COLOR_WITH_HEX(0x999999);
    }
    return self;
}

-(void)remindButtonWithRemindNum:(int)remindNum{
    if(remindNum<=0){
        [self.remindNumberLabel setHidden:YES];
    }else{
        if (remindNum>9) {
            [self.remindNumberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                 make.width.mas_greaterThanOrEqualTo(25);
            }];
        }
        [self.remindNumberLabel setText:[NSString stringWithFormat:@"%d",remindNum]];

    }
    
}

-(void)initUI{
    @weakify(self);
    [self.remindNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.imageView.mas_centerX).offset(20);
        make.top.mas_equalTo(weak_self.imageView).offset(-5);
        make.width.mas_greaterThanOrEqualTo(20);
        make.height.mas_equalTo(20);
    }];
}


-(UILabel *)remindNumberLabel{
    if (!_remindNumberLabel) {
        UILabel *remindNumberLabel = [[UILabel alloc]init];
        [remindNumberLabel setTextColor:[UIColor whiteColor]];
        [remindNumberLabel setFont:YX22Font];
        remindNumberLabel.backgroundColor = [UIColor redColor];
        remindNumberLabel.layer.cornerRadius = 10.f;
        remindNumberLabel.layer.masksToBounds = YES;
        remindNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:remindNumberLabel];
        _remindNumberLabel = remindNumberLabel;
    }
    return _remindNumberLabel;
}

@end
