//
//  PhotosController.h
//  PhotosAsset
//
//  Created by 77 on 2017/7/4.
//  Copyright © 2017年 77. All rights reserved.
//

#import "YXBaseViewController.h"

@protocol PhotosControllerDelegate <NSObject>

@optional

- (void)getImagesArray:(NSArray<UIImage *>*)imagesArray;

@required

@end

@interface PhotosController : YXBaseViewController

@property (nonatomic, assign) id<PhotosControllerDelegate>  delegate;
@property (nonatomic, assign) int maxCount;

@end
