//
//  WLAddAccidentController.m
//  waterConservancy
//
//  Created by mac on 2018/9/5.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAddAccidentController.h"
#import "WLAddAccView.h"
#import "PhotosController.h"
#import "HVideoViewController.h"
#import "WLRecordView.h"
#import "GCMAssetModel.h"
#import "AC_AVPlayerViewController.h"
#import <iflyMSC/iflyMSC.h>


#define RandomNum (arc4random() % 9999999999999999)

@interface WLAddAccidentController ()<UIScrollViewDelegate,UIActionSheetDelegate,PhotosControllerDelegate>
@property (nonatomic, weak) UIButton *commitBtn;
@property (nonatomic, weak) UIScrollView *bgView;
@property (nonatomic, strong) WLAddAccView *addView;
@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, assign) CGSize bgViewConSize;
@property (nonatomic, strong) WLRecordView *recordView;
@property (nonatomic, strong) NSURL  *videoUrl;
@property (nonatomic, strong) GCMAssetModel *videoModel;//视频转化
@property (nonatomic, assign) int filecount;//附件个数
@property (nonatomic, weak) UIView *datePopView;
@property (nonatomic, weak) UIDatePicker *picker;

@end

@implementation WLAddAccidentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增事故";
    self.photoArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
   [self registerForKeyboardNotifications];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height-30-SCALE_W(70)-WC_STATUSBAR_AND_NAVIGATIONBAR_HEIGHT)];
    scrollView.delegate = self;
    if (scrollView.frame.size.height<690) {
         scrollView.contentSize = CGSizeMake(0, 695);
    }
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    _bgView = scrollView;
    @weakify(self)
    WLAddAccView *view = [WLAddAccView createAddAccView];
    view.frame = CGRectMake(0, 5, kScreenWidth, 690);
    if (self.model) {
        view.accName.text = self.model.accName;
    }
    [view showMediaDataWith:self.photoArray];
    view.voiceBlock = ^{
        [weak_self.tabBarController.view addSubview:weak_self.recordView];
    };
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
    view.chooseDateBlock = ^{
        [weak_self chooseDate];
    };
    [self.bgView addSubview:view];
    _addView = view;

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-SCALE_W(520))*0.5, kScreenHeight-SCALE_W(70)-WC_STATUSBAR_AND_NAVIGATIONBAR_HEIGHT-15, SCALE_W(520), SCALE_W(70))];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"commitBtnBg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn.titleLabel setFont:YX36Font];
    [self.view addSubview:btn];
    _commitBtn = btn;
    
    self.recordView = [[WLRecordView alloc]init];
    self.recordView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

-(void)chooseDate{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-250-WC_STATUSBAR_AND_NAVIGATIONBAR_HEIGHT, kScreenWidth, 250)];
    view.layer.cornerRadius = 5.f;
    view.layer.borderColor = FColor(64.0, 114.0, 216.0, 1.0).CGColor;
    view.layer.borderWidth = 1.f;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    UIDatePicker *pick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, 200)];
    pick.datePickerMode = UIDatePickerModeDateAndTime;
    // 设置日期选择控件的地区
    [pick setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    [view addSubview:pick];
    self.picker = pick;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    [btn1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"取 消" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancelPick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80, 0, 80, 50)];
    [btn2 setTitleColor:FColor(64.0, 114.0, 216.0, 1.0) forState:UIControlStateNormal];
    [btn2 setTitle:@"确 认" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(selectPick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn2];
    
    self.datePopView = view;
}

-(void)cancelPick{
    [self.datePopView removeFromSuperview];
}

-(void)selectPick{
    
    NSTimeInterval timeInt = [[NSDate date] timeIntervalSinceDate:self.picker.date];
    if (timeInt>0) {
        [self.datePopView removeFromSuperview];
        NSDateFormatter *date=[[NSDateFormatter alloc] init];
        [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateStr = [date stringFromDate:self.picker.date];
        self.addView.accDate.text = dateStr;
    }else{
        [SVProgressHUD showErrorWithStatus:@"不可选取未来时间"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
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

#pragma mark 监听事件
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"%f",kbSize.height);
    self.bgViewConSize = self.bgView.contentSize;
    
    self.bgView.contentSize = CGSizeMake(0,  self.bgView.contentSize.height+(kbSize.height-(self.bgView.contentSize.height-kScreenHeight)));
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  self.bgView.contentSize = self.bgViewConSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)commitBtnClick{
    
    
}

@end
