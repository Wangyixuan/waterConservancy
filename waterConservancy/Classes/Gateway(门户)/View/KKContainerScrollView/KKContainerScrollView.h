//
//  KKContainerScrollView.h
//  KuaiKuai
//
//  Created by YK on 16/1/18.
//  Copyright © 2016年 liujichang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KKHeaderScrollView.h"

#import "KKContentScrollView.h"

@interface KKContainerScrollView : UIView <KKHeaderScrollViewDelegate,KKContentScrollViewDelegate>

@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) NSArray *controllersArray;
@property (assign, nonatomic) NSInteger selectedIndex;

@property (copy, nonatomic) void(^choseCallback)(NSInteger index);

@end
