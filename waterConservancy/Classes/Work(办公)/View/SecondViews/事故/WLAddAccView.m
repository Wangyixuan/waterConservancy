//
//  WLAddAccView.m
//  waterConservancy
//
//  Created by mac on 2018/9/5.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAddAccView.h"
#import "YXPhotoImgBtn.h"
#import <XLPhotoBrowser+CoderXL/XLPhotoBrowser.h>
#import "YXVideoPlayBtn.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>


@interface WLAddAccView()<UITextFieldDelegate,YYTextViewDelegate>
@property (nonatomic, weak) UIButton *addPhotoBtn;
@property (nonatomic, weak) YYTextView *descText;
@property (nonatomic, weak) UITextField *placeHoldLab;
@property (weak, nonatomic) IBOutlet UIView *photoImgV;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (nonatomic, strong) NSArray *photoArr;
@end

@implementation WLAddAccView

+(instancetype)createAddAccView{
    return [[NSBundle mainBundle] loadNibNamed:@"WLAddAccView" owner:nil options:nil].firstObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recordText:) name:@"recordText" object:nil];
    self.photoArr = [NSArray array];
    [self initUI];
}

-(void)initUI{
    @weakify(self)
    [self.descText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.textView);
    }];
    [self.placeHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.bottom.right.mas_equalTo(weak_self.textView);
    }];
}

-(void)recordText:(NSNotification*)dic{
    NSString *voiceStr =[dic.userInfo stringForKey:@"text" defaultValue:@""];
    if (self.descText.text.length==0) {
        self.descText.text = voiceStr;
    }else{
        NSString *temp =self.descText.text;
        self.descText.text = [NSString stringWithFormat:@"%@%@",temp,voiceStr];
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

-(void)addPhotoBtnClick{
   
    [self.descText resignFirstResponder];
    if (self.addPhotoBlock) {
        self.addPhotoBlock();
    }
}
#pragma mark - YYTextViewDelagate
- (void)textViewDidBeginEditing:(YYTextView *)textView{
    [textView becomeFirstResponder];
    self.placeHoldLab.hidden = YES;
    if (self.beginEditBlock) {
        self.beginEditBlock();
    }
}
- (void)textViewDidEndEditing:(YYTextView *)textView{
    
    if (textView.text.length==0) {
        self.placeHoldLab.hidden= NO;
    }else{
       

        if (self.endEditBlock) {
            self.endEditBlock();
        }
    }
    [textView resignFirstResponder];
}

- (void)textViewDidChange:(YYTextView *)textView{
//    @weakify(self)
    if (textView.text.length !=0) {
        self.placeHoldLab.hidden= YES;
    }
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![self isExclusiveTouch]) {
        [self endEditing:YES];
        if (self.endEditBlock) {
            self.endEditBlock();
        }
    }
}
- (IBAction)voiceBtnClick:(id)sender {
    [self endEditing:YES];
    if (self.voiceBlock) {
        self.voiceBlock();
    }
}

- (IBAction)dateBtnClick:(id)sender {
    [self endEditing:YES];
    if (self.chooseDateBlock) {
        self.chooseDateBlock();
    }
}

- (IBAction)boolBtnClick:(UIButton*)sender {
    [self endEditing:YES];
    for (UIButton* btn in self.ifRespAcc) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}

- (IBAction)boolBtnClick2:(UIButton*)sender {
    [self endEditing:YES];
    for (UIButton *btn in self.ifPhotoRep) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}


-(YYTextView*)descText{
    if (!_descText) {
        YYTextView *textfiled = [[YYTextView alloc]init];
        textfiled.delegate = self;
        textfiled.scrollsToTop = NO;
        textfiled.font = YX30Font;
        textfiled.textAlignment = NSTextAlignmentLeft;
        textfiled.backgroundColor = [UIColor clearColor];
        [self.textView addSubview:textfiled];
        _descText = textfiled;
    }
    return _descText;
}
-(UITextField*)placeHoldLab{
    if (!_placeHoldLab) {
        UITextField *field = [[UITextField alloc]init];
        field.placeholder = @"请填写详情";
        [self.textView addSubview:field];
        [self.textView insertSubview:field belowSubview:self.descText];
        field.userInteractionEnabled = NO;
        _placeHoldLab = field;
    }
    return _placeHoldLab;
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
