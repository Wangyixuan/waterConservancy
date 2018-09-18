//
//  WLSearchView.h
//  waterConservancy
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLSearchView : UIView
@property (weak, nonatomic) IBOutlet UITextField *keyWordText;
+(instancetype)addSearchView;
@end
