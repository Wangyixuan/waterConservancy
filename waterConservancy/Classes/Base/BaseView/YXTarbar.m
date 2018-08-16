//
//  YXTarbar.m
//  河掌治
//
//  Created by 乐凡宝宝 on 2018/3/18.
//  Copyright © 2018年 乐凡宝宝. All rights reserved.
//


#import "YXTarbar.h"
@interface YXTarbar()
//指向中间“+”按钮
@property (nonatomic,weak) UIButton *addButton;
@property (nonatomic, assign) NSInteger previousClickedTag;
@end
@implementation YXTarbar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置“+”按钮的位置
     self.addButton.centerX = self.centerX;
    
    if (YYISiPhoneX) {
        self.addButton.centerY = self.height * 0.5 - 17;
    }else{
        self.addButton.centerY = self.height * 0.5 -  10 ;
    }
     //设置“+”按钮的大小为图片的大小
    self.addButton.size = CGSizeMake(self.addButton.currentBackgroundImage.size.width, self.addButton.currentBackgroundImage.size.height);
    
    [self setAllTabbarButtonFrames];
    
}
- (void)plusClick {
    //通知代理
    if ([self.tabbarDelegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]){
        [self.tabbarDelegate tabBarDidClickedPlusButton:self];
    }
}
-(void)setAllTabbarButtonFrames{
    int index = 0;
    for (UIButton *tabbarButton in self.subviews) {
        if (![tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        [self setTabbarButtonFrame:tabbarButton atIndex:index];
        index++;
    }
}
-(void)setTabbarButtonFrame:(UIView *)tabBarButton atIndex:(int)index{
    // 计算button的尺寸
    CGFloat buttonW = self.width / (self.items.count+1);
    CGFloat buttonH = self.height-SCALE_W(10);
    NSLog(@"%d",KTabSafeHeight);
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH-KTabSafeHeight;
    if (index>=2) {
        index++;
    }
    [self setBarTintColor:[UIColor whiteColor]];
    self.translucent = YES;
    tabBarButton.left = buttonW * index;
    tabBarButton.top = 0;
    
}


@end
