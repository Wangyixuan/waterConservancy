//
//  WLHiddDetailCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddDetailCell.h"
#import "YXPhotoImgBtn.h"
#import <XLPhotoBrowser+CoderXL/XLPhotoBrowser.h>
#import "YXVideoPlayBtn.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>

#define MARGIN 10
@interface WLHiddDetailCell()

@property (weak, nonatomic) IBOutlet UIScrollView *photoImgV;

@end

@implementation WLHiddDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setPhotoArr:(NSMutableArray *)photoArr{
    _photoArr = photoArr;

    CGFloat imgW = 70;
    CGFloat imgH = 70;
    
    for (int i = 0; i<photoArr.count;i++) {
        id item = photoArr[i];
        if ([item isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL*)item;
            YXVideoPlayBtn *videoBtn = [[YXVideoPlayBtn alloc]initWithFrame:CGRectMake(((MARGIN+imgW) * i), 0, imgW, imgH)];
            videoBtn.tag = i;
            [videoBtn addTarget:self action:@selector(videoPlay:) forControlEvents:UIControlEventTouchUpInside];
            [self.photoImgV addSubview:videoBtn];
            [self thumbnailImagewithVideo:url AndBtn:videoBtn];
            }
        else{
            UIImage *img = (UIImage*)item;
            YXPhotoImgBtn *imgview = [[YXPhotoImgBtn alloc]init];
            imgview.tag = i;
            [imgview loadImg:img];
            
            imgview.frame = CGRectMake(((MARGIN+imgW) * i), 0, imgW, imgH);
            [self.photoImgV addSubview:imgview];
            //点击大图
            @weakify(imgview);
            imgview.biggerBlock = ^{
                @strongify(imgview);
                [XLPhotoBrowser showPhotoBrowserWithImages:photoArr currentImageIndex:imgview.tag];
            };
        }
        
    }
}
//视频播放
-(void)videoPlay:(YXVideoPlayBtn*)btn{
    NSURL *url = [self.photoArr objectAtIndex:btn.tag];
    
    if (self.videoPlayBlock) {
        self.videoPlayBlock(url);
    }
    
}
-(void)thumbnailImagewithVideo:(NSURL *)videoUrl AndBtn:(YXVideoPlayBtn*)btn{
    @weakify(self);
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"相册已授权打开");
            @strongify(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage*subImg = [self thumbnailImageForVideo:videoUrl atTime:1];
                [btn setImage:subImg forState:UIControlStateNormal];
            });
            
            
        }else{
            NSLog(@"Denied or Restricted");
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"相册权限尚未打开"];
                [SVProgressHUD dismissWithDelay:1.5];
            });
        }
    }];
}
- (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}
@end
