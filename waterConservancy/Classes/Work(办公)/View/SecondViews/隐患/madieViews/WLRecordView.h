//
//  WLRecordView.h
//  waterConservancy
//
//  Created by mac on 2018/8/28.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Mp3Recorder.h"
//#import "lame.h"

@interface WLRecordView : UIView{
    int maxTime;
    NSString *title;
}
@property (nonatomic, copy) void(^endRecordBlock)(NSString *text);

@end
