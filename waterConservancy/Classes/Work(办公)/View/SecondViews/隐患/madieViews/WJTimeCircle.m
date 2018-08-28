//
//  WJTimeCircle.m
//  WJTimeCircleDemo
//
//  Created by wenjie on 16/5/31.
//  Copyright © 2016年 com.firsttruck. All rights reserved.
//

#import "WJTimeCircle.h"

@interface WJTimeCircle ()

@property (nonatomic,assign)CGFloat downPercent;

@property (nonatomic, weak) UIImageView *imgView;//帧动画
@property (nonatomic, weak) UILabel     *namelabel;//正在录音

@property (nonatomic, strong) NSMutableArray *imgArray;

@end

@implementation WJTimeCircle

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _downPercent = 0;
        _second = 0;
        _percent = 0;
        _width = 0;
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _downPercent = 0;
        _second = 0;
        _percent = 0;
        _width = 0;
        //创建一个可变数组
        self.imgArray=[NSMutableArray new];
        for(int I=0;I<15;I++){
            //通过for 循环,把我所有的 图片存到数组里面
            NSString *imageName=[NSString stringWithFormat:@"ani%d",I];
            UIImage *image=[UIImage imageNamed:imageName];
            [self.imgArray addObject:image];
        }
    }
    return self;
}


- (void)setSecond:(NSTimeInterval)second{
    if (_isStartDisplay) {
        _second = second;
        _downPercent = _second/_totalSecond;
        [self setNeedsDisplay];
    }
}


- (void)setPercent:(float)percent{
    if (_isStartDisplay) {
        _percent = percent;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect{
    
    [self addArcBackColor];
    [self drawArc];
    
    [self setCenter];
}

- (void)addArcBackColor{
    
    UIColor *color = (_arcBackColor == nil) ? [UIColor lightGrayColor] : _arcBackColor;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    
    CGFloat radius = viewSize.width / 2;
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapButt;
    processPath.lineWidth = viewSize.width;
    CGFloat startAngle = (float)(0.0f * M_PI);
    CGFloat endAngle = (float)(2.0f * M_PI);
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGContextSetBlendMode(contextRef, kCGBlendModeCopy);
    [color set];
    [processPath stroke];
}



- (void)drawArc{
    float width = (_width == 0) ? 5 : _width;
    if (_second <= 0) {
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        UIColor *color = (_arcFinishColor == nil) ? [UIColor greenColor] : _arcFinishColor;
        CGSize viewSize = self.bounds.size;
        CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
        CGFloat radius = viewSize.width / 2 - width/2;
        CGFloat startAngle = - M_PI_2;
        CGFloat endAngle = (2 * (float)M_PI - M_PI_2);
        UIBezierPath *processPath = [UIBezierPath bezierPath];
        processPath.lineCapStyle = kCGLineCapButt;
        processPath.lineWidth = width;
        [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        CGContextSetBlendMode(contextRef, kCGBlendModeCopy);
        [color set];
        [processPath stroke];
        return;
    }
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    float endAngle = - M_PI_2;
    UIColor *color = (_arcUnfinishColor == nil) ? [UIColor blueColor] : _arcUnfinishColor;
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);

    CGFloat radius = viewSize.width / 2 - width/2;
    CGFloat startAngle = 2*M_PI - M_PI_2 - 2*M_PI*_downPercent;
    UIBezierPath *processPath = [UIBezierPath bezierPath];
    processPath.lineCapStyle = kCGLineCapButt;
    processPath.lineWidth = width;
    
    [processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGContextSetBlendMode(contextRef, kCGBlendModeCopy);
    [color set];
    [processPath stroke];
    
    UIColor *baseColor = (_baseColor == nil) ? [UIColor blueColor] : _baseColor;
    UIBezierPath *processPath2 = [UIBezierPath bezierPath];
    processPath2.lineCapStyle = kCGLineCapButt;
    processPath2.lineWidth = width;
    [processPath2 addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:NO];
    CGContextSetBlendMode(contextRef, kCGBlendModeCopy);
    [baseColor set];
    [processPath2 stroke];
    
    
}


-(void)addCenterBack{
    float width = (_width == 0) ? 5 : _width;
    UIColor *color = (_centerColor == nil) ? [UIColor whiteColor] : _centerColor;
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width / 2, viewSize.height / 2);
    CGFloat radius = viewSize.width / 2 - width/2;
    UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
    processBackgroundPath.lineWidth = width;
    processBackgroundPath.lineCapStyle = kCGLineCapButt;
    CGFloat startAngle = - ((float)M_PI / 2);
    CGFloat endAngle = (2 * (float)M_PI) + startAngle;
    [processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [color set];
    [processBackgroundPath stroke];
    
}


-(void)setCenter{
    @weakify(self);
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.mas_centerX);
        make.top.mas_equalTo(weak_self.mas_top).offset(SCALE_H(50));
        make.width.mas_equalTo(SCALE_W(180));
        make.height.mas_equalTo(SCALE_H(60));
    }];
    [self.namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.mas_centerX);
        make.top.mas_equalTo(weak_self.imgView.mas_bottom).offset(SCALE_H(50));
    }];
    [self.secLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.mas_centerX);
        make.top.mas_equalTo(weak_self.namelabel.mas_bottom).offset(SCALE_H(50));
    }];
}


-(UIImageView *)imgView{
    if (!_imgView) {
        UIImageView *imgView = [[UIImageView alloc]init];
        // 设置图片的序列帧 图片数组
        imgView.animationImages=self.imgArray;
        //动画重复次数
        imgView.animationRepeatCount=0;
        //动画执行时间,多长时间执行完动画
        imgView.animationDuration=1.0;
        //开始动画
        [imgView startAnimating];
        [self addSubview:imgView];
        _imgView = imgView;
    }
    return _imgView;
}
-(UILabel *)namelabel{
    if (!_namelabel) {
        UILabel *label = [[UILabel alloc]init];
        [label setFont:YX30Font];
        [label setText:@"正在录音"];
        [label setTextColor:[UIColor whiteColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        _namelabel = label;
    }
    return _namelabel;
}
-(UILabel *)secLabel{
    if (!_secLabel) {
        UILabel *label = [[UILabel alloc]init];
        [label setFont:YX22Font];
        [label setText:[NSString stringWithFormat:@"剩余60秒"]];
        [label setTextColor:COLOR_WITH_HEX(0x333333)];
        [label setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:label];
        _secLabel = label;
    }
    return _secLabel;
}



@end
