//
//  WLUploadDetailInfoCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLUploadDetailInfoCell.h"
#import "YXPhotoImgBtn.h"
#import <XLPhotoBrowser+CoderXL/XLPhotoBrowser.h>
#import "YXVideoPlayBtn.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>


#define MARGIN 10

@interface WLUploadDetailInfoCell()<UITextFieldDelegate,YYTextViewDelegate>
@property (nonatomic, weak) UIImageView *topBgImageView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UIImageView *bottomBgImageView;
@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UIView *lineView1;
@property (nonatomic, weak) UIView *lineView2;
@property (nonatomic, weak) UIView *lineView3;
@property (nonatomic, weak) UILabel *nameTitleLab;
@property (nonatomic, weak) UILabel *gradTitleLab;
@property (nonatomic, weak) UILabel *descTitleLab;
@property (nonatomic, weak) UILabel *onSpotTitleLab;
@property (nonatomic, weak) UIButton *vioceBtn;
@property (nonatomic, weak) UIButton *addPhotoBtn;
@property (nonatomic, weak) UITextField *nameText;
@property (nonatomic, weak) UITextField *gradText;
@property (nonatomic, weak) UITextField *placeHoldLab;
@property (nonatomic, weak) YYTextView *descText;
@property (nonatomic, weak) UIView *photoImgV;


@end

@implementation WLUploadDetailInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)voiceBtnClick{
    if (self.voiceBlock) {
        self.voiceBlock();
    }
}
-(void)addPhotoBtnClick{
    if (self.addPhotoBlock) {
        self.addPhotoBlock();
    }
}

-(void)setDescStr:(NSString *)descStr{
    _descStr = descStr;
    if (descStr.length>0) {
        self.descText.text = descStr;
        self.placeHoldLab.hidden = YES;
    }else{
        self.placeHoldLab.hidden= NO;
    }
    CGFloat height =  self.descText.textLayout.textBoundingSize.height;
   @weakify(self)
    if (height>55) {
        [self.lineView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.lineView2).offset(height+20);
        }];
        if (self.uploadHeightBlock) {
            self.uploadHeightBlock(height-55);
        }
    }else{
        [self.lineView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.lineView2).offset(75);
        }];
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
//                [EasyTextView showText:@"相册权限尚未打开"];
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
-(void)setPhotoArr:(NSMutableArray *)photoArr{
    _photoArr = photoArr;
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

-(void)initUI{
    @weakify(self)
    [self.topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weak_self.contentView).offset(5);
        make.right.mas_equalTo(weak_self.contentView).offset(-5);
        make.height.mas_equalTo(15);
    }];
    [self.bottomBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.contentView).offset(5);
        make.right.bottom.mas_equalTo(weak_self.contentView).offset(-5);
        make.height.mas_equalTo(15);
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.contentView).offset(5);
        make.right.mas_equalTo(weak_self.contentView).offset(-5);
        make.top.mas_equalTo(weak_self.topBgImageView.mas_bottom);
        make.bottom.mas_equalTo(weak_self.bottomBgImageView.mas_top);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.bgImageView.mas_left).offset(15);
        make.right.mas_equalTo(weak_self.bgImageView.mas_right).offset(-15);
        make.top.mas_equalTo(weak_self.contentView).offset(75);
        make.height.mas_equalTo(1);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.lineView1.mas_left);
        make.right.mas_equalTo(weak_self.lineView1.mas_right);
        make.top.mas_equalTo(weak_self.lineView1).offset(75);
        make.height.mas_equalTo(1);
    }];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.lineView1.mas_left);
        make.right.mas_equalTo(weak_self.lineView1.mas_right);
        make.top.mas_equalTo(weak_self.lineView2).offset(75);
        make.height.mas_equalTo(1);
    }];
    [self.nameTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.topBgImageView.mas_top).offset(10);
        make.bottom.mas_equalTo(weak_self.lineView1.mas_top).offset(-10);
        make.left.mas_equalTo(weak_self.lineView1.mas_left);
        make.width.mas_equalTo(68);
    }];
    [self.gradTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68);
        make.left.mas_equalTo(weak_self.lineView1.mas_left);
        make.top.mas_equalTo(weak_self.lineView1.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weak_self.lineView2.mas_top).offset(-10);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(weak_self.lineView1.mas_right);
        make.centerY.mas_equalTo(weak_self.gradTitleLab.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(15);
    }];
    [self.descTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(55);
        make.left.mas_equalTo(weak_self.lineView1.mas_left);
        make.top.mas_equalTo(weak_self.lineView2.mas_bottom).offset(10);
    }];
    [self.vioceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.lineView1.mas_right);
        make.centerY.mas_equalTo(weak_self.descTitleLab.mas_centerY);
    }];

    [self.onSpotTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68);
        make.left.mas_equalTo(weak_self.lineView1.mas_left);
        make.top.mas_equalTo(weak_self.lineView3.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weak_self.photoImgV.mas_top);
        make.height.mas_equalTo(55);
    }];

    [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.nameTitleLab.mas_right).offset(15);
        make.right.mas_equalTo(weak_self.lineView1.mas_right);
        make.centerY.mas_equalTo(weak_self.nameTitleLab.mas_centerY);
    }];
    [self.gradText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.gradTitleLab.mas_right).offset(15);
        make.right.mas_equalTo(weak_self.arrowImageView.mas_left).offset(-10);
        make.centerY.mas_equalTo(weak_self.gradTitleLab.mas_centerY);
    }];
    [self.descText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.descTitleLab.mas_right).offset(15);
        make.right.mas_equalTo(weak_self.vioceBtn.mas_left).offset(-10);
        make.top.mas_equalTo(weak_self.lineView2.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weak_self.lineView3.mas_top).offset(-10);
    }];
    [self.placeHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.descTitleLab.mas_right).offset(15);
        make.right.mas_equalTo(weak_self.vioceBtn.mas_left).offset(-10);
        make.top.mas_equalTo(weak_self.lineView2.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weak_self.lineView3.mas_top).offset(-10);
    }];
    [self.photoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weak_self.lineView1);        make.bottom.mas_equalTo(weak_self.bottomBgImageView.mas_bottom).offset(-10);
    }];

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
   @weakify(self)
    CGFloat height = textView.textLayout.textBoundingSize.height;
    if (height>55) {
        [self.lineView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.lineView2).offset(height+20);
        }];
        if (self.uploadHeightBlock) {
            self.uploadHeightBlock(height-55);
        }
    }else{
        [self.lineView3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.lineView2).offset(75);
        }];
    }
}

-(UIImageView*)topBgImageView{
    if (!_topBgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow1"]];
        [self.contentView addSubview:img];
        _topBgImageView = img;
    }
    return _topBgImageView;
}
-(UIImageView*)bottomBgImageView{
    if (!_bottomBgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow3"]];
        [self.contentView addSubview:img];
        _bottomBgImageView = img;
    }
    return _bottomBgImageView;
}
-(UIImageView*)bgImageView{
    if (!_bgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow2"]];
        [self.contentView addSubview:img];
        _bgImageView = img;
    }
    return _bgImageView;
}
-(UIImageView*)arrowImageView{
    if (!_arrowImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detailArrow"]];
        [self.contentView addSubview:img];
        _arrowImageView = img;
    }
    return _arrowImageView;
}
-(UIView*)lineView1{
    if (!_lineView1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:view];
        _lineView1 = view;
    }
    return _lineView1;
}
-(UIView*)lineView3{
    if (!_lineView3) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:view];
        _lineView3 = view;
    }
    return _lineView3;
}
-(UIView*)lineView2{
    if (!_lineView2) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:view];
        _lineView2 = view;
    }
    return _lineView2;
}
-(UILabel*)nameTitleLab{
    if (!_nameTitleLab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"隐患名称";
        lab.font = YX28Font;
        [self.contentView addSubview:lab];
        _nameTitleLab = lab;
    }
    return _nameTitleLab;
}
-(UILabel*)gradTitleLab{
    if (!_gradTitleLab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"隐患级别";
        lab.font = YX28Font;
        [self.contentView addSubview:lab];
        _gradTitleLab = lab;
    }
    return _gradTitleLab;
}
-(UILabel*)descTitleLab{
    if (!_descTitleLab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"隐患描述";
        lab.font = YX28Font;
        [self.contentView addSubview:lab];
        _descTitleLab = lab;
    }
    return _descTitleLab;
}
-(UILabel*)onSpotTitleLab{
    if (!_onSpotTitleLab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"现场情况";
        lab.font = YX28Font;
        [self.contentView addSubview:lab];
        _onSpotTitleLab = lab;
    }
    return _onSpotTitleLab;
}

-(UIButton*)vioceBtn{
    if (!_vioceBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"vioceBtn"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(voiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        _vioceBtn = btn;
    }
    return _vioceBtn;
}

-(UITextField*)nameText{
    if (!_nameText) {
        UITextField *field = [[UITextField alloc]init];
        field.placeholder = @"请输入隐患名称";
        [self.contentView addSubview:field];
        _nameText = field;
    }
    return _nameText;
}

-(UITextField*)gradText{
    if (!_gradText) {
        UITextField *field = [[UITextField alloc]init];
        field.placeholder = @"请选择隐患级别";
        [self.contentView addSubview:field];
        _gradText = field;
    }
    return _gradText;
}

-(YYTextView*)descText{
    if (!_descText) {
        YYTextView *textfiled = [[YYTextView alloc]init];
        textfiled.delegate = self;
        textfiled.scrollsToTop = NO;
        textfiled.font = YX30Font;
        textfiled.textAlignment = NSTextAlignmentLeft;
        textfiled.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:textfiled];
        _descText = textfiled;
    }
    return _descText;
}
-(UITextField*)placeHoldLab{
    if (!_placeHoldLab) {
        UITextField *field = [[UITextField alloc]init];
        field.placeholder = @"请输入问题描述";
        [self.contentView addSubview:field];
        [self.contentView insertSubview:field belowSubview:self.descText];
//        field.backgroundColor = [UIColor blueColor];
        field.userInteractionEnabled = NO;
        _placeHoldLab = field;
    }
    return _placeHoldLab;
}
-(UIView *)photoImgV{
    if (!_photoImgV) {
        UIView *view = [[UIView alloc]init];
        [self.contentView addSubview:view];
        _photoImgV = view;
    }
    return _photoImgV;
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
