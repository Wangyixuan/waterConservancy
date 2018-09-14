//
//  KKContentScrollView.h
//  KuaiKuai
//
//  Created by YK on 16/1/18.
//  Copyright © 2016年 liujichang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KKContentScrollViewDelegate <NSObject>

- (void)contentScrollViewChoseIndex:(NSInteger)index;


@end


@interface KKContentScrollView : UIView <UIScrollViewDelegate>


@property (strong, nonatomic) NSArray *controllersArray;
@property (assign, nonatomic) NSInteger selectedIndex;

@property (weak, nonatomic) id<KKContentScrollViewDelegate> delegate;

- (void)addChildView:(NSInteger)index;


@end
