//
//  KKContainerScrollView.m
//  KuaiKuai
//
//  Created by YK on 16/1/18.
//  Copyright © 2016年 liujichang. All rights reserved.
//

#import "KKContainerScrollView.h"


#define HeaderScorll_height 40


@interface KKContainerScrollView ()

@property (strong, nonatomic) KKHeaderScrollView *headerScrollView;
@property (strong, nonatomic) KKContentScrollView *contentScrollView;



@end

@implementation KKContainerScrollView

- (void)awakeFromNib {
    [super awakeFromNib];

    [self addSubview:self.headerScrollView];
    [self addSubview:self.contentScrollView];

}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headerScrollView];
        [self addSubview:self.contentScrollView];
    }
    return self;
}


- (KKHeaderScrollView *)headerScrollView {
    if(_headerScrollView == nil){
        _headerScrollView = [KKHeaderScrollView new];
        _headerScrollView.delegate = self;
    }
    return _headerScrollView;
}

- (KKContentScrollView *)contentScrollView {
    if(_contentScrollView == nil){
        _contentScrollView = [KKContentScrollView new];
        _contentScrollView.delegate = self;
    }
    return _contentScrollView;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self changeFrame];
}

- (void)changeFrame {
    self.headerScrollView.frame = CGRectMake(0, 0, WCScreenWidth, 40);
    self.contentScrollView.frame = CGRectMake(0, HeaderScorll_height, WCScreenWidth, self.frame.size.height - HeaderScorll_height);
}

- (void)setTitlesArray:(NSArray *)titlesArray {
    _titlesArray = titlesArray;
    _headerScrollView.titlesArray = titlesArray;
}


- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self contentScrollViewChoseIndex:self.selectedIndex];
    [self headerScrollViewchoseIndex:self.selectedIndex];
}

- (void)setControllersArray:(NSArray *)controllersArray {
    _controllersArray = controllersArray;
    _contentScrollView.controllersArray = controllersArray;
}

- (void)contentScrollViewChoseIndex:(NSInteger)index {
    [_headerScrollView selectedIndex:index];
    if (self.choseCallback) {
        self.choseCallback(index);
    }
}

- (void)headerScrollViewchoseIndex:(NSInteger)index {
    [_contentScrollView addChildView:index];
    if (self.choseCallback) {
        self.choseCallback(index);
    }
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
