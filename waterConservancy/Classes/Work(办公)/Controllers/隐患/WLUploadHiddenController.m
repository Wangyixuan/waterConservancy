//
//  WLUploadHiddenController.m
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLUploadHiddenController.h"
#import "WLUploadHiddenInfoCell.h"
#import "WLUploadDetailInfoCell.h"

#import "PhotosController.h"
#import "HVideoViewController.h"

#import "WLRecordView.h"

#import "GCMAssetModel.h"

#define cellInfoIdentifity @"WLUploadHiddenInfoCell"
#define cellDetailIdentifity @"WLUploadDetailInfoCell"
#define RandomNum (arc4random() % 9999999999999999)

@interface WLUploadHiddenController ()<UIActionSheetDelegate,PhotosControllerDelegate>
@property (nonatomic, weak) UIButton *commitBtn;
@property (nonatomic, assign) CGPoint scrolContensize;//scorllview原本的contensize
@property (nonatomic, assign) CGFloat cellH;
@property (nonatomic, strong) WLRecordView *recordView;
@property (nonatomic, strong) NSURL  *videoUrl;
@property (nonatomic, strong) GCMAssetModel *videoModel;//视频转化
@property (nonatomic, assign) int filecount;//附件个数
@property (nonatomic, strong) NSMutableArray *photoArray;//照片数组，拍照和选择都放在这个数组里
@end

@implementation WLUploadHiddenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患上报";
     self.photoArray = [NSMutableArray arrayWithCapacity:3];
    // Do any additional setup after loading the view.
    [self setUpSubViews];
    
}

-(void)setUpSubViews{
     @weakify(self);
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weak_self.view).offset(-15);
        make.height.mas_equalTo(SCALE_W(71));
        make.width.mas_equalTo(SCALE_W(520));
        make.centerX.mas_equalTo(weak_self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.tableView];
   
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(weak_self.view);
        make.bottom.mas_equalTo(weak_self.commitBtn.mas_top).offset(-15);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellInfoIdentifity bundle:nil] forCellReuseIdentifier:cellInfoIdentifity];
    [self.tableView registerClass:[WLUploadDetailInfoCell class] forCellReuseIdentifier:cellDetailIdentifity];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 150;
    }
    return 375+self.cellH;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        WLUploadHiddenInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfoIdentifity forIndexPath:indexPath];
//        cell.model = self.model;
        return cell;
    }
    else{
        WLUploadDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetailIdentifity forIndexPath:indexPath];
        if (!cell) {
            cell = [[WLUploadDetailInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailIdentifity];
        }
        @weakify(self)
        cell.beginEditBlock = ^{
            weak_self.scrolContensize = weak_self.tableView.contentOffset;
            [weak_self.tableView setContentSize:CGSizeMake(ScreenWidth, ScreenHeight+128)];
            [weak_self.tableView setContentOffset:CGPointMake(0,50) animated:YES];
        };
        cell.endEditBlock = ^{
             [weak_self.tableView setContentOffset:weak_self.scrolContensize animated:YES];
             [weak_self.tableView reloadData];
        };
        cell.uploadHeightBlock = ^(CGFloat H) {
            NSLog(@"h %f",H);
            weak_self.cellH = H;
        };
        cell.voiceBlock = ^{
            [weak_self.tabBarController.view addSubview:weak_self.recordView];
        };
        cell.addPhotoBlock = ^{
            [weak_self showPhotoSheet];
        };
        return cell;
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
                if (weak_self.videoUrl == nil) {
                    weak_self.videoUrl = item;
                    //视频url
//                    [weak_self.uploadInfoView loadVideoStr:weak_self.videoUrl];
                    //视频转码
                    weak_self.videoModel = [[GCMAssetModel alloc]init];
                    weak_self.videoModel.fileName = [NSString stringWithFormat:@"%ld.mp4",RandomNum];
                    weak_self.videoModel.imageURL = weak_self.videoUrl;
                    //转码压缩存储至本地（如果想修改存储路径和压缩比例看方法内部）
                    [weak_self.videoModel convertVideoWithModel:weak_self.videoModel];
                    
                    weak_self.filecount++;
//                    [weak_self.uploadInfoView.uploadNameLabel setText:[NSString stringWithFormat:@"现场附件-附件(%d)",weak_self.filecount]];
                }else{
//                    [EasyTextView showText:@"只能上传一个视频"];
                }
                
                
            }else{
                if (item == nil) {
                    return ;
                }
                UIImage *img = item;
                
                if (weak_self.photoArray.count<3) {
                    [weak_self.photoArray addObject:img];
//                    [weak_self.uploadInfoView loadPhotoArray:weak_self.photoArray];
                    weak_self.filecount++;
//                    [weak_self.uploadInfoView.uploadNameLabel setText:[NSString stringWithFormat:@"现场附件-附件(%d)",weak_self.filecount]];
                }else{
//                    [EasyTextView showText:@"最多上传3张照片"];
                }
                
            }
        };
        [self presentViewController:ctrl animated:YES completion:nil];
        
    }else if (buttonIndex==1){
        //相册
        PhotosController *vc = [[PhotosController alloc] init];
        //    vc.title = @"相册";
        vc.delegate          = self;
        vc.maxCount        = 5;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)getImagesArray:(NSArray<UIImage *> *)imagesArray{
    
}

-(UIButton*)commitBtn{
    if (!_commitBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"确认上报" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"commitBtnBg"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:YX36Font];
        [self.view addSubview:btn];
        _commitBtn = btn;
    }
    return _commitBtn;
}
-(void)commitBtnClick{
    
}

-(WLRecordView *)recordView{
    if (!_recordView) {
        self.recordView = [[WLRecordView alloc]init];
        self.recordView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//        @weakify(self);
        self.recordView.endRecordBlock = ^(NSData *data, int second) {
//            @strongify(self);
//            self.voiceSecond = second;
//            [self.uploadInfoView loadvoiceStr:data useSecond:second];
        };
        
    }
    return _recordView;
    
}
@end
