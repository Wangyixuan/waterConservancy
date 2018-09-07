//
//  WLAddPatrolView.m
//  waterConservancy
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAddPatrolView.h"
#import "YXPhotoImgBtn.h"
#import <XLPhotoBrowser+CoderXL/XLPhotoBrowser.h>
#import "YXVideoPlayBtn.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>


@interface WLAddPatrolView()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *issHold;
@property (weak, nonatomic) IBOutlet UITextField *meaHold;
@property (weak, nonatomic) IBOutlet UIView *photoImgV;
@property (nonatomic, weak) UIButton *addPhotoBtn;
@property (nonatomic, strong) NSArray *photoArr;
@end

@implementation WLAddPatrolView

+(instancetype)loadAddPatrolView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"WLAddPatrolView" owner:nil options:nil].firstObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.issueText.delegate = self;
    self.measuresText.delegate = self;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
    if (textView.tag==0) {
        self.issHold.hidden = YES;
    }else{
        self.meaHold.hidden = YES;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    if (textView.text.length==0) {
        if (textView.tag==0) {
            self.issHold.hidden = NO;
        }else{
            self.meaHold.hidden = NO;
        }
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![self isExclusiveTouch]) {
        [self endEditing:YES];
    }
}
-(void)showMediaDataWith:(NSMutableArray *)photoArr{
    self.photoArr = photoArr;
    [self.photoImgV removeAllSubviews];
    @weakify(self);
    CGFloat imgW = (kScreenWidth-40-30)/4;
    CGFloat imgH = 70;
    
    if (photoArr.count != 4) {
        [self.photoImgV addSubview:self.addPhotoBtn];
        [self.addPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weak_self.photoImgV.mas_left).offset((MARGIN+imgW) *photoArr.count);
            make.width.height.mas_equalTo(70);
            make.centerY.mas_equalTo(weak_self.photoImgV.mas_centerY);
        }];
    }
    
    for (int i = 0; i<photoArr.count;i++) {
        id item = photoArr[i];
        if ([item isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL*)item;
            YXVideoPlayBtn *videoBtn = [[YXVideoPlayBtn alloc]initWithFrame:CGRectMake(((MARGIN+imgW) * i), 0, imgW, imgH)];
            videoBtn.tag = i;
            [videoBtn addTarget:self action:@selector(videoPlay:) forControlEvents:UIControlEventTouchUpInside];
            @weakify(self);
            videoBtn.videodelBtnBlock = ^{
                
                if (weak_self.videodelBlock) {
                    weak_self.videodelBlock(i);
                }
            };
            [self.photoImgV addSubview:videoBtn];
            [self thumbnailImagewithVideo:url AndBtn:videoBtn];
        }else{
            UIImage *img = (UIImage*)item;
            YXPhotoImgBtn *imgview = [[YXPhotoImgBtn alloc]init];
            imgview.tag = i;
            [imgview loadImg:img];
            
            imgview.frame = CGRectMake(((MARGIN+imgW) * i), 0, imgW, imgH);
            [self.photoImgV addSubview:imgview];
            
            //删除照片
            imgview.delBtnBlock = ^{
                if (weak_self.delPhotoBtnBlock) {
                    weak_self.delPhotoBtnBlock(i);
                }
            };
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

-(void)addPhotoBtnClick{
    
    [self endEditing:YES];
    if (self.addPhotoBlock) {
        self.addPhotoBlock();
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

-(UIButton*)addPhotoBtn{
    if (!_addPhotoBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"addPhotoIcon"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.photoImgV addSubview:btn];
        _addPhotoBtn = btn;
    }
    return _addPhotoBtn;
}
@end
