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
        CGFloat tabbarImgY = SCALE_W(138)-kTabbarHeight;
        if (tabbarImgY>0) {
            tabbarImgY = -tabbarImgY;
        }else{
            tabbarImgY -= SCALE_W(10);
        }
        UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, tabbarImgY, ScreenWidth, SCALE_W(138))];
        [imgv setImage:[UIImage imageNamed:@"bar"]];
        [self insertSubview:imgv atIndex:0];
        
        //创建中间“+”按钮
        UIButton *addBtn = [[UIButton alloc] init];
         //设置默认背景图片
        [addBtn setBackgroundImage:[UIImage imageNamed:@"takePhoto"] forState:UIControlStateNormal];
         //添加响应事件
         [addBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
         //将按钮添加到TabBar
         [self addSubview:addBtn];

         self.addButton = addBtn;
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
