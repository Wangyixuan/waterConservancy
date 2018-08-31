//
//  WLHiddenDelDetailController.m
//  waterConservancy
//
//  Created by mac on 2018/8/31.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddenDelDetailController.h"
#import "YXPhotoImgBtn.h"
#import <XLPhotoBrowser+CoderXL/XLPhotoBrowser.h>
#import "YXVideoPlayBtn.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "PhotosController.h"
#import "HVideoViewController.h"
#import "WLRecordView.h"
#import "GCMAssetModel.h"
#import "AC_AVPlayerViewController.h"
#import <iflyMSC/iflyMSC.h>

#define MARGIN 10
#define RandomNum (arc4random() % 9999999999999999)

@interface WLHiddenDelDetailController ()<YYTextViewDelegate,UIActionSheetDelegate,PhotosControllerDelegate>
@property (nonatomic, weak) UIImageView *topBgImageView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UIImageView *bottomBgImageView;
@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UIView *lineView1;
@property (nonatomic, weak) UIView *lineView2;
@property (nonatomic, weak) UILabel *descTitleLab;
@property (nonatomic, weak) UILabel *onSpotTitleLab;
@property (nonatomic, weak) UIButton *vioceBtn;
@property (nonatomic, weak) UIButton *addPhotoBtn;
@property (nonatomic, weak) UITextField *placeHoldLab;
@property (nonatomic, weak) YYTextView *descText;
@property (nonatomic, weak) UIView *photoImgV;
@property (nonatomic, weak) UILabel *SeactionLabel;
@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, weak) UIButton *commitBtn;
@property (nonatomic, strong) WLRecordView *recordView;
@property (nonatomic, assign) int filecount;//附件个数
@property (nonatomic, strong) NSURL  *videoUrl;
@property (nonatomic, strong) GCMAssetModel *videoModel;//视频转化
@end

@implementation WLHiddenDelDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患销号";
    self.photoArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recordText:) name:@"recordText" object:nil];
    // Do any additional setup after loading the view.
    [self initUI];
    [self showSelectMediaWithData:self.photoArray];
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
-(void)commitBtnClick{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSDictionary *param = @{@"note":@"移动端接口测试",@"hiddGuid":self.hiddGuid,@"accepPers":WLShareUserManager.persID,@"accepOpin":self.descText.text,@"accepDate":currentTimeString};
    [[YXNetTool shareTool] postRequestWithURL:YXNetAddressCJ(@"cjapi/cj/bis/hidd/rectAcce/addObjHiddRectAcce") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"销号成功"];
        [SVProgressHUD dismissWithDelay:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } faild:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        [SVProgressHUD dismissWithDelay:1.5];
    }];
}

-(void)voiceBtnClick{
    [self.descText resignFirstResponder];
    [self.tabBarController.view addSubview:self.recordView];

}
-(void)addPhotoBtnClick{
  
    [self.descText resignFirstResponder];
    [self showPhotoSheet];
}
-(void)showPhotoSheet{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    @weakify(self)
    if (buttonIndex==0) {
        //拍照
        HVideoViewController *ctrl = [[NSBundle mainBundle] loadNibNamed:@"HVideoViewController" owner:nil options:nil].lastObject;
        ctrl.HSeconds = 10;//设置可录制最长时间
        ctrl.takeBlock = ^(id item) {
            if ([item isKindOfClass:[NSURL class]]) {
                weak_self.videoUrl = item;
                [weak_self.photoArray addObject:item];
                //视频转码
                weak_self.videoModel = [[GCMAssetModel alloc]init];
                weak_self.videoModel.fileName = [NSString stringWithFormat:@"%ld.mp4",RandomNum];
                weak_self.videoModel.imageURL = weak_self.videoUrl;
                //转码压缩存储至本地（如果想修改存储路径和压缩比例看方法内部）
                [weak_self.videoModel convertVideoWithModel:weak_self.videoModel];
                
                weak_self.filecount++;
                [weak_self showSelectMediaWithData:weak_self.photoArray];
            }else{
                if (item == nil) {
                    return ;
                }
                UIImage *img = item;
                
                if (weak_self.photoArray.count<4) {
                    [weak_self.photoArray addObject:img];
                    weak_self.filecount++;
                    [weak_self showSelectMediaWithData:weak_self.photoArray];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"最大上传四个文件"];
                    [SVProgressHUD dismissWithDelay:1.5];
                }
            }
        };
        
        [self presentViewController:ctrl animated:YES completion:nil];
        
    }else if (buttonIndex==1){
        //相册
        PhotosController *vc = [[PhotosController alloc] init];
        vc.delegate          = self;
        vc.maxCount        = 5;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)getImagesArray:(NSArray<UIImage *> *)imagesArray{
    int count = 4 - (int)self.photoArray.count;
    if (imagesArray.count<=count) {
        
        [self.photoArray addObjectsFromArray:imagesArray];
        self.filecount += (int)imagesArray.count;
        [self showSelectMediaWithData:self.photoArray];
    }else{
        [SVProgressHUD showErrorWithStatus:@"最大上传四个文件"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
}

//视频播放
-(void)videoPlay:(YXVideoPlayBtn*)btn{
    NSURL *url = [self.photoArray objectAtIndex:btn.tag];

    AC_VideoModel *model2 = [[AC_VideoModel alloc] initWithName:@"上传视频" url:url];
    AC_AVPlayerViewController *ctr = [[AC_AVPlayerViewController alloc] initWithVideoList:@[model2]];
    [self presentViewController:ctr animated:YES completion:^{
    }];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showSelectMediaWithData:(NSMutableArray *)photoArray{
    [self.photoImgV removeAllSubviews];
    @weakify(self);
    CGFloat imgW = (kScreenWidth-40-30)/4;
    CGFloat imgH = 70;
    
    if (photoArray.count != 4) {
        [self.photoImgV addSubview:self.addPhotoBtn];
        [self.addPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weak_self.photoImgV.mas_left).offset((MARGIN+imgW) *photoArray.count);
            make.width.height.mas_equalTo(70);
            make.centerY.mas_equalTo(weak_self.photoImgV.mas_centerY);
        }];
    }
    
    for (int i = 0; i<photoArray.count;i++) {
        id item = photoArray[i];
        if ([item isKindOfClass:[NSURL class]]) {
            NSURL *url = (NSURL*)item;
            YXVideoPlayBtn *videoBtn = [[YXVideoPlayBtn alloc]initWithFrame:CGRectMake(((MARGIN+imgW) * i), 0, imgW, imgH)];
            videoBtn.tag = i;
            [videoBtn addTarget:self action:@selector(videoPlay:) forControlEvents:UIControlEventTouchUpInside];
            videoBtn.videodelBtnBlock = ^{
                weak_self.filecount--;
                [weak_self.photoArray removeObjectAtIndex:i];
                [weak_self showSelectMediaWithData:weak_self.photoArray];
                weak_self.videoUrl = nil;
                weak_self.videoModel = nil;
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
                weak_self.filecount--;
                [weak_self.photoArray removeObjectAtIndex:i];
                [weak_self showSelectMediaWithData:weak_self.photoArray];
            };
            //点击大图
            @weakify(imgview);
            imgview.biggerBlock = ^{
                @strongify(imgview);
                [XLPhotoBrowser showPhotoBrowserWithImages:photoArray currentImageIndex:imgview.tag];
            };
        }
        
    }
}

#pragma mark - YYTextViewDelagate
- (void)textViewDidBeginEditing:(YYTextView *)textView{
    [textView becomeFirstResponder];
    self.placeHoldLab.hidden = YES;
}

- (void)textViewDidEndEditing:(YYTextView *)textView{
    
    if (textView.text.length==0) {
        self.placeHoldLab.hidden= NO;
        self.commitBtn.enabled = NO;
    }
    [textView resignFirstResponder];
}

- (void)textViewDidChange:(YYTextView *)textView{
    if (textView.text.length !=0) {
        self.placeHoldLab.hidden= YES;
    }
    @weakify(self)
    CGFloat height = textView.textLayout.textBoundingSize.height;
    if (height>55) {
        [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((height-55)+225);
        }];
        [self.lineView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.lineView1.mas_bottom).offset((height-55)+75);
        }];
    }else{
        [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(225);
        }];
        [self.lineView2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.lineView1.mas_bottom).offset(75);
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     if (![self.view isExclusiveTouch]) {
         [self.descText resignFirstResponder];
     }
}

-(void)initUI{
    @weakify(self)
    [self.topBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weak_self.view).offset(5);
        make.right.mas_equalTo(weak_self.view).offset(-5);
        make.height.mas_equalTo(30);
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.view).offset(5);
        make.right.mas_equalTo(weak_self.view).offset(-5);
        make.top.mas_equalTo(weak_self.topBgImageView.mas_bottom);
        make.height.mas_equalTo(225);
//        make.bottom.mas_equalTo(weak_self.bottomBgImageView.mas_top);
    }];
    [self.bottomBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.view).offset(5);
        make.right.mas_equalTo(weak_self.view).offset(-5);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(weak_self.bgImageView.mas_bottom);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.bgImageView.mas_left).offset(5);
        make.right.mas_equalTo(weak_self.bgImageView.mas_right).offset(-5);
        make.top.mas_equalTo(weak_self.topBgImageView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.bgImageView.mas_left).offset(15);
        make.right.mas_equalTo(weak_self.bgImageView.mas_right).offset(-15);
        make.top.mas_equalTo(weak_self.lineView1.mas_bottom).offset(75);
        make.height.mas_equalTo(1);
    }];
   
    [self.descTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.lineView1.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weak_self.lineView2.mas_top).offset(-10);
        make.left.mas_equalTo(weak_self.lineView2.mas_left);
        make.width.mas_equalTo(68);
    }];
    [self.vioceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.lineView2.mas_right);
        make.centerY.mas_equalTo(weak_self.descTitleLab.mas_centerY);
        make.height.width.mas_equalTo(30);
    }];
    
    [self.onSpotTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68);
        make.left.mas_equalTo(weak_self.lineView2.mas_left);
        make.top.mas_equalTo(weak_self.lineView2.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weak_self.photoImgV.mas_top);
        make.height.mas_equalTo(55);
    }];
  
    [self.descText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.descTitleLab.mas_right).offset(15);
        make.right.mas_equalTo(weak_self.vioceBtn.mas_left).offset(-10);
        make.top.mas_equalTo(weak_self.lineView1.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weak_self.lineView2.mas_top).offset(-10);
    }];
    [self.placeHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.descTitleLab.mas_right).offset(15);
        make.right.mas_equalTo(weak_self.vioceBtn.mas_left).offset(-10);
        make.top.mas_equalTo(weak_self.lineView1.mas_bottom).offset(10);
        make.bottom.mas_equalTo(weak_self.lineView2.mas_top).offset(-10);
    }];
    [self.photoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weak_self.lineView2);     make.bottom.mas_equalTo(weak_self.bottomBgImageView.mas_bottom).offset(-10);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weak_self.view).offset(-15);
        make.height.mas_equalTo(SCALE_W(71));
        make.width.mas_equalTo(SCALE_W(520));
        make.centerX.mas_equalTo(weak_self.view.mas_centerX);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.topBgImageView.mas_top).offset(10);
        make.bottom.mas_equalTo(weak_self.topBgImageView.mas_bottom).offset(-5);
        make.left.mas_equalTo(weak_self.topBgImageView.mas_left).offset(15);
        make.width.mas_equalTo(SCALE_W(5));
    }];
    
    [self.SeactionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.topBgImageView.mas_top).offset(10);
        make.bottom.mas_equalTo(weak_self.topBgImageView.mas_bottom).offset(-5);
        make.left.mas_equalTo(weak_self.lineView.mas_right).offset(10);
        make.right.mas_equalTo(weak_self.topBgImageView.mas_right).offset(-15);
    }];

}
-(UIImageView*)topBgImageView{
    if (!_topBgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow1"]];
        [self.view addSubview:img];
        _topBgImageView = img;
    }
    return _topBgImageView;
}
-(UIImageView*)bottomBgImageView{
    if (!_bottomBgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow3"]];
        [self.view addSubview:img];
        _bottomBgImageView = img;
    }
    return _bottomBgImageView;
}
-(UIImageView*)bgImageView{
    if (!_bgImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"flow2"]];
        [self.view addSubview:img];
        _bgImageView = img;
    }
    return _bgImageView;
}
-(UIImageView*)arrowImageView{
    if (!_arrowImageView) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"detailArrow"]];
        [self.view addSubview:img];
        _arrowImageView = img;
    }
    return _arrowImageView;
}
-(UIView*)lineView1{
    if (!_lineView1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:view];
        _lineView1 = view;
    }
    return _lineView1;
}

-(UIView*)lineView2{
    if (!_lineView2) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:view];
        _lineView2 = view;
    }
    return _lineView2;
}

-(UILabel*)descTitleLab{
    if (!_descTitleLab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"销号意见";
        lab.font = YX28Font;
        [self.view addSubview:lab];
        _descTitleLab = lab;
    }
    return _descTitleLab;
}
-(UILabel*)onSpotTitleLab{
    if (!_onSpotTitleLab) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"现场情况";
        lab.font = YX28Font;
        [self.view addSubview:lab];
        _onSpotTitleLab = lab;
    }
    return _onSpotTitleLab;
}

-(UIButton*)vioceBtn{
    if (!_vioceBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"vioceBtn"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(voiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _vioceBtn = btn;
    }
    return _vioceBtn;
}

-(YYTextView*)descText{
    if (!_descText) {
        YYTextView *textfiled = [[YYTextView alloc]init];
        textfiled.delegate = self;
        textfiled.scrollsToTop = NO;
        textfiled.font = YX30Font;
        textfiled.textAlignment = NSTextAlignmentLeft;
        textfiled.backgroundColor = [UIColor clearColor];
        [self.view addSubview:textfiled];
        _descText = textfiled;
    }
    return _descText;
}
-(UITextField*)placeHoldLab{
    if (!_placeHoldLab) {
        UITextField *field = [[UITextField alloc]init];
        field.placeholder = @"请填写详情";
        [self.view addSubview:field];
        [self.view insertSubview:field belowSubview:self.descText];
        field.userInteractionEnabled = NO;
        _placeHoldLab = field;
    }
    return _placeHoldLab;
}
-(UIView *)photoImgV{
    if (!_photoImgV) {
        UIView *view = [[UIView alloc]init];
        [self.view addSubview:view];
        [self.view insertSubview:view aboveSubview:self.bgImageView];
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
-(UIButton*)commitBtn{
    if (!_commitBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"提交销号" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"commitBtnBg"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:YX36Font];
        btn.enabled = NO;
        [self.view addSubview:btn];
        _commitBtn = btn;
    }
    return _commitBtn;
}

-(WLRecordView *)recordView{
    if (!_recordView) {
        self.recordView = [[WLRecordView alloc]init];
        self.recordView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        @weakify(self);
        self.recordView.endRecordBlock = ^(NSString *text) {
            weak_self.descText.text = text;
        };
    }
    return _recordView;
}
-(UILabel*)SeactionLabel{
    if (!_SeactionLabel) {
        UILabel *SeactionLabel = [[UILabel alloc]init];
        [SeactionLabel setText:@"销号填写"];
        [SeactionLabel setTextColor:FColor(64.0, 114.0, 216.0, 1.0)];
        [SeactionLabel setFont:YX26Font];
        [self.view addSubview:SeactionLabel];
        _SeactionLabel = SeactionLabel;
    }
    return _SeactionLabel;
}

-(UIView*)lineView{
    if (!_lineView) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = FColor(64.0, 114.0, 216.0, 1.0);
        [self.view addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

@end
