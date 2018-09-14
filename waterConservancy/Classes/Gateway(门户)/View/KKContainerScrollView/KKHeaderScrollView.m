//
//  KKHeaderScrollView.m
//  KuaiKuai
//
//  Created by YK on 16/1/18.
//  Copyright © 2016年 liujichang. All rights reserved.
//

#import "KKHeaderScrollView.h"


#define  View_width   WCScreenWidth/self.titlesArray.count
#define  LineView_height 2

@implementation KKHeaderScrollView{
    UIScrollView *_headerScrollView;
    UIView *_lineView;
    
    UIButton *_selectedButton;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _headerScrollView.bounces = NO;
        _headerScrollView.showsHorizontalScrollIndicator = NO;
        _headerScrollView.delegate = self;
        _headerScrollView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_headerScrollView];
    }
    return self;
}




- (void)setTitlesArray:(NSArray *)titlesArray {
    _titlesArray = titlesArray;
    [self createTitleView];
}

- (void)createTitleView {
    
    for (UIView *view in _headerScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    NSUInteger titleCount = self.titlesArray.count;
    _headerScrollView.contentSize = CGSizeMake(titleCount * View_width, 0);
    
    
    
    for (int i = 0; i<titleCount; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*View_width, 0, View_width,self.frame.size.height - LineView_height)];
        view.tag = 100+i;
        // 65 63 77
        
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        [button setTitle:[self.titlesArray objectAtIndex:i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor colorWithRed:252/255.0 green:65/255.0 blue:52/255.0 alpha:1] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 200 + i;
        [view addSubview:button];
        
        
        if(i != titleCount - 1){
            UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-0.5, (view.frame.size.height-20)/2.0, 0.5, 20)];
            lineLabel.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
            [view addSubview:lineLabel];
        }
        [_headerScrollView addSubview:view];
    }
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerScrollView.frame.size.height-7, View_width, 7)];
    
    
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((_lineView.frame.size.width-10)/2.0, 0, 10, 5)];
    //    imageView.image = [UIImage imageNamed:@"shop_up"];
    //    [_lineView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, _lineView.frame.size.width, LineView_height)];
    // 252 65 52
    label.backgroundColor = [UIColor colorWithRed:14/255.0 green:166/255.0 blue:226/255.0 alpha:1];
    [_lineView addSubview:label];
    
    [_headerScrollView addSubview:_lineView];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self createTitleView];

     _headerScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [self selectedIndex:self.selectedIndex];

}


- (void)buttonAction:(UIButton *)button {
    if (button.selected) {
        return;
    }
    
    [self selectedIndex:button.tag -200];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerScrollViewchoseIndex:)]) {
        [self.delegate headerScrollViewchoseIndex: button.tag-200];
    }
}


- (void)selectedIndex:(NSUInteger)index {
    
    if (index <= self.titlesArray.count) {
        self.selectedIndex = index;
        UIView *headerView = [_headerScrollView viewWithTag:100 + index];
        UIButton *button = [headerView viewWithTag:200 + index];
        
        if (button != _selectedButton) {
            _selectedButton.selected = NO;
            _selectedButton = button;
            button.selected = YES;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            _lineView.frame = CGRectMake(index *View_width , _lineView.frame.origin.y, _lineView.frame.size.width, _lineView.frame.size.height);
        }];
        
        if (index < 3) {
            [_headerScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else if (index < self.titlesArray.count - 1){
            [_headerScrollView setContentOffset:CGPointMake((index-1) * View_width, 0) animated:YES];
        }
    }
}


@end
