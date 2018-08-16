//
//  DJSectionReuseView.m
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJSectionReuseView.h"

@implementation DJSectionReuseView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.bounds];
    [imgV setImage:[UIImage imageNamed:@"nav_nav"]];
    [self insertSubview:imgV atIndex:0];
    
}

@end
