//
//  WLAddAccView.h
//  waterConservancy
//
//  Created by mac on 2018/9/5.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLAddAccView : UIView
@property (nonatomic, copy) void(^beginEditBlock)(void);
@property (nonatomic, copy) void(^endEditBlock)(void);
@property (nonatomic, copy) void(^voiceBlock)(void);
@property (nonatomic, copy) void(^addPhotoBlock)(void);
@property (nonatomic, copy) void(^delPhotoBtnBlock)(NSInteger i);
@property (nonatomic, copy) void(^videodelBlock)(NSInteger i);
@property (nonatomic, copy) void(^videoPlayBlock)(NSURL *url);
@property (nonatomic, copy) void(^reloadBlock)(void);
@property (nonatomic, copy) void(^chooseDateBlock)(void);

@property (weak, nonatomic) IBOutlet UITextField *accName;
@property (weak, nonatomic) IBOutlet UITextField *accWiun;
@property (weak, nonatomic) IBOutlet UITextField *serInjNub;
@property (weak, nonatomic) IBOutlet UITextField *deadNub;
@property (weak, nonatomic) IBOutlet UITextField *accLoss;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ifRespAcc;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *ifPhotoRep;
@property (weak, nonatomic) IBOutlet UITextField *accDate;

-(void)showMediaDataWith:(NSMutableArray*)photoArr;

+(instancetype)createAddAccView;

@end
