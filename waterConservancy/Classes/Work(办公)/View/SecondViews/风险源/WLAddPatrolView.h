//
//  WLAddPatrolView.h
//  waterConservancy
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLAddPatrolView : UIView
@property (weak, nonatomic) IBOutlet UITextView *issueText;
@property (weak, nonatomic) IBOutlet UITextView *measuresText;
@property (nonatomic, copy) void(^addPhotoBlock)(void);
@property (nonatomic, copy) void(^delPhotoBtnBlock)(NSInteger i);
@property (nonatomic, copy) void(^videodelBlock)(NSInteger i);
@property (nonatomic, copy) void(^videoPlayBlock)(NSURL *url);

+(instancetype)loadAddPatrolView;
-(void)showMediaDataWith:(NSMutableArray*)photoArr;
@end
