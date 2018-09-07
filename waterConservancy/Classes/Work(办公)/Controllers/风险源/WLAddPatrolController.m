//
//  WLAddPatrolController.m
//  waterConservancy
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAddPatrolController.h"
#import "WLAddPatrolView.h"
#import "PhotosController.h"
#import "HVideoViewController.h"
#import "WLRecordView.h"
#import "GCMAssetModel.h"
#import "AC_AVPlayerViewController.h"
#import <iflyMSC/iflyMSC.h>

#define RandomNum (arc4random() % 9999999999999999)

@interface WLAddPatrolController ()<UIActionSheetDelegate,PhotosControllerDelegate>
@property (nonatomic, strong) WLAddPatrolView *addView;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, strong) NSURL  *videoUrl;
@property (nonatomic, strong) GCMAssetModel *videoModel;//视频转化
@property (nonatomic, assign) int filecount;//附件个数

@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) UIButton *commitBtn;

@end

@implementation WLAddPatrolController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增巡查记录";
    self.photoArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    @weakify(self)
    WLAddPatrolView *view= [WLAddPatrolView loadAddPatrolView];
    view.frame = CGRectMake(0, 10, kScreenWidth, 330+WC_STATUSBAR_AND_NAVIGATIONBAR_HEIGHT);
    [view showMediaDataWith:self.photoArray];

    view.addPhotoBlock = ^{
        [weak_self showPhotoSheet];
    };
    view.delPhotoBtnBlock = ^(NSInteger i) {
        weak_self.filecount--;
        [weak_self.photoArray removeObjectAtIndex:i];
        [weak_self.addView showMediaDataWith:weak_self.photoArray];
    };
    view.videoPlayBlock = ^(NSURL *url) {
        AC_VideoModel *model2 = [[AC_VideoModel alloc] initWithName:@"上传视频" url:url];
        AC_AVPlayerViewController *ctr = [[AC_AVPlayerViewController alloc] initWithVideoList:@[model2]];
        [weak_self presentViewController:ctr animated:YES completion:^{
        }];
    };
    view.videodelBlock = ^(NSInteger i) {
        weak_self.filecount--;
        [weak_self.photoArray removeObjectAtIndex:i];
        [weak_self.addView showMediaDataWith:weak_self.photoArray];
        
        weak_self.videoUrl = nil;
        weak_self.videoModel = nil;
    };
    [self.view addSubview:view];
    self.addView = view;
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:FColor(64.0, 114.0, 216.0, 1.0) forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"popquxiao"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.cancelBtn = btn;
    
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"确认" forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"popqueren"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    self.commitBtn = btn1;
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.view.mas_left).offset(20);
        make.bottom.mas_equalTo(weak_self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(SCALE_W(70));
        make.right.mas_equalTo(weak_self.view.mas_centerX).offset(-10);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.view.mas_centerX).offset(10);
        make.right.mas_equalTo(weak_self.view.mas_right).offset(-20);
        make.centerY.mas_equalTo(weak_self.cancelBtn.mas_centerY);
        make.height.mas_equalTo(SCALE_W(70));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitBtnClick{
    
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
                [weak_self.addView showMediaDataWith:weak_self.photoArray];
                
                //视频转码
                weak_self.videoModel = [[GCMAssetModel alloc]init];
                weak_self.videoModel.fileName = [NSString stringWithFormat:@"%ld.mp4",RandomNum];
                weak_self.videoModel.imageURL = weak_self.videoUrl;
                //转码压缩存储至本地（如果想修改存储路径和压缩比例看方法内部）
                [weak_self.videoModel convertVideoWithModel:weak_self.videoModel];
                
                weak_self.filecount++;
            }else{
                if (item == nil) {
                    return ;
                }
                UIImage *img = item;
                
                if (weak_self.photoArray.count<4) {
                    [weak_self.photoArray addObject:img];
                    [weak_self.addView showMediaDataWith:weak_self.photoArray];
                    
                    weak_self.filecount++;
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
        //附件数+=照片选择的张数
        self.filecount += (int)imagesArray.count;
        [self.addView showMediaDataWith:self.photoArray];
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"最大上传四个文件"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
}



@end
