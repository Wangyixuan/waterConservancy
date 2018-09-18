//
//  KKHeaderScrollView.h
//  KuaiKuai
//
//  Created by YK on 16/1/18.
//  Copyright © 2016年 liujichang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KKHeaderScrollViewDelegate <NSObject>

- (void)headerScrollViewchoseIndex:(NSInteger)index;

@end

@interface KKHeaderScrollView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *titlesArray;
@property (assign, nonatomic) NSUInteger selectedIndex;

@property (weak, nonatomic) id<KKHeaderScrollViewDelegate> delegate;


- (void)selectedIndex:(NSUInteger)index;

@end
