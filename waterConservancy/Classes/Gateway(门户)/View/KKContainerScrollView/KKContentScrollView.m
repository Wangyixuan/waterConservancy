//
//  KKContentScrollView.m
//  KuaiKuai
//
//  Created by YK on 16/1/18.
//  Copyright © 2016年 liujichang. All rights reserved.
//

#import "KKContentScrollView.h"


@interface KKContentScrollView ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation KKContentScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
    }
    return self;
}

- (UIScrollView *)scrollView {
    if(_scrollView == nil){
        _scrollView = [UIScrollView new];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}


- (void)setControllersArray:(NSArray *)controllersArray {
    _controllersArray = controllersArray;
    [self setScrollView];
}

- (void)setScrollView {
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(_controllersArray.count * self.frame.size.width, 0);
    [self addChildView:self.selectedIndex];
}






- (void)addChildView:(NSInteger)index {
    if (index <= self.controllersArray.count) {
        self.selectedIndex = index;
        UIView *view = [self.scrollView viewWithTag:100 + index];
        UIViewController *controller = [self.controllersArray objectAtIndex:index];

        if (view == nil) {
            controller.view.frame = CGRectMake(index * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            controller.view.tag = 100 + index;
            [self.scrollView addSubview:controller.view];
        }else{
            controller.view.frame = CGRectMake(index * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        }
        
        [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.frame.size.width , 0) animated:YES];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        NSInteger index = scrollView.contentOffset.x / self.scrollView.frame.size.width;
        [self selectIndex:index];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / self.scrollView.frame.size.width;
    [self selectIndex:index];
}


- (void)selectIndex:(NSInteger)index {
    [self addChildView:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentScrollViewChoseIndex:)]) {
        [self.delegate contentScrollViewChoseIndex:index];
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
