//
//  WLRecordView.m
//  waterConservancy
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLRecordView.h"
#import <AVFoundation/AVFoundation.h>
#import "WJTimeCircle.h"
#import "YSCCircleRippleView.h"

#define ciciWidth SCALE_W(550)
#define ciciY SCALE_H(140)

@interface WLRecordView()
@property (nonatomic, strong) AVAudioPlayer *play;
@property (nonatomic, weak)  UIButton *endBtn;//结束录音
@property (nonatomic, strong) NSData *voiceData;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger second;
@property (nonatomic,strong)WJTimeCircle *timeCircle;
@property (nonatomic, strong) YSCCircleRippleView *rippleView;

@end

@implementation WLRecordView

-(instancetype)init{
    if (self = [super init]) {
        //已进入就开始录音
        //        self.backgroundColor = [UIColor blackColor];
        //        self.alpha = 0.9;
        self.backgroundColor = FColor(0, 0, 0, 0.8);
        
        CGFloat x = (ScreenWidth-ciciWidth)/2;
        self.rippleView = [[YSCCircleRippleView alloc] initWithFrame:CGRectMake(x, ciciY, ciciWidth, ciciWidth)];
        [self addSubview:_rippleView];
        _rippleView.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    maxTime = 60;
    self.second = 60;
    
    //开始录音
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAnim) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
    mp3 = [[Mp3Recorder alloc]initWithDelegate:self];
    [mp3 startRecord];
    
    [self setUI];
}

-(void)endClick{
    //正常停止录音，开始转换数据
    [mp3 stopRecord];
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self removeFromSuperview];
}


#pragma mark Mp3RecordDelegate
-(void)beginConvert{
}

//录音失败
- (void)failRecord
{
    NSLog(@"失败");
}


//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    //    NSLog(@"%@",voiceData);
    self.voiceData = voiceData;
    int useSecond = 60 - (int)self.second;
    if (voiceData.length>0) {
        if (self.endRecordBlock) {
            self.endRecordBlock(voiceData,useSecond);
        }
    }
}

//超期结束
-(void)recording:(float)recordTime volume:(float)volume{
    if (recordTime>maxTime) {
        [self endClick];
    }
    //    [self removeAllSubviews];
    //    [self removeFromSuperview];
}

- (void)timeAnim{
    
    self.second --;
    self.timeCircle.second = self.second;
    if (self.second < 0) {
        self.second = 0;
    }
    [self.timeCircle.secLabel setText:[NSString stringWithFormat:@"剩余%ld秒",(long)self.second]];
    
}


-(void)setUI{
    @weakify(self);
    
    
    [self.rippleView startAnimation];
    
    [self.timeCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.mas_centerX);
        make.centerY.mas_equalTo(weak_self.rippleView.mas_centerY);
        //        make.top.mas_equalTo(weak_self.mas_top).offset(ciciY);
        make.width.height.mas_equalTo(ciciWidth*0.6);
    }];
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.mas_centerX);
        make.bottom.mas_equalTo(weak_self.mas_bottom).offset(SCALE_H(-180));
        make.width.mas_equalTo(SCALE_W(250));
        make.height.mas_equalTo(SCALE_H(80));
    }];
    self.endBtn.layer.cornerRadius = SCALE_H(40);
    self.endBtn.layer.masksToBounds = YES;
    
    
}


-(UIButton *)endBtn{
    if (!_endBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundColor:COLOR_WITH_HEX(0x0072dd)];
        [btn setTitle:@"我说完了" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(endClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        _endBtn = btn;
    }
    return _endBtn;
}

- (WJTimeCircle *)timeCircle{
    if (_timeCircle == nil) {
        _timeCircle = [[WJTimeCircle alloc] init];
        _timeCircle.arcFinishColor = COLOR_WITH_HEX(0x0072dd);
        _timeCircle.arcUnfinishColor = COLOR_WITH_HEX(0x09ccc0);
        _timeCircle.arcBackColor = [UIColor clearColor];
        _timeCircle.baseColor = COLOR_WITH_HEX(0x0072dd);
        _timeCircle.width = 5;
        _timeCircle.totalSecond = self.second;
        _timeCircle.isStartDisplay = YES;
        [self addSubview:_timeCircle];
    }
    return _timeCircle;
}
-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}


@end
