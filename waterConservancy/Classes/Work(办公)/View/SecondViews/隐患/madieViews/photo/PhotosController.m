//
//  PhotosController.m
//  PhotosAsset
//
//  Created by 77 on 2017/7/4.
//  Copyright © 2017年 77. All rights reserved.
//

#import "PhotosController.h"
#import "SmallCell.h"
//#import "FullCell.h"

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define kSizeThumbnailCollectionView  ([UIScreen mainScreen].bounds.size.width-10)/4
@interface PhotosController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SmallCellDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIView       *_navagationView;
    UIView       *_barView;
    UIButton     *_okButton;
    NSInteger    _pageIndex;
    UILabel      *photosNumLab;
    NSInteger    _photosCount;

}
//UI
@property (nonatomic,retain)UIView                      *keyView;
@property (nonatomic,retain)UICollectionView            *myCo;
//@property (nonatomic,retain)UICollectionView            *FullCollectionView;
@property (nonatomic,retain)UICollectionViewFlowLayout  *layout;

//存储图片信息的数组
@property (nonatomic,retain)NSMutableArray              *assets;

//存储被选中的图片信息
@property (nonatomic,retain)NSMutableArray              *selectedArray;

//显示图片索引号
@property (nonatomic,retain)UILabel                     *indexLable;

//图片是否选中数组
@property (nonatomic,retain)NSMutableArray              *ImagesSelectedArray;

//存储选中图片索引号的数组
@property (nonatomic,retain)NSMutableArray              *selectedPhotosIndexArray;

@end

@implementation PhotosController

static NSString *PhotoCellId = @"PhotosCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _assets                   = [[NSMutableArray alloc] init];
    _selectedArray            = [[NSMutableArray alloc] init];
    _ImagesSelectedArray      = [[NSMutableArray alloc] init];
    _selectedPhotosIndexArray = [[NSMutableArray alloc] init];
     self.title               = @"相册";
    self.automaticallyAdjustsScrollViewInsets = NO;
        [self askForAuthorize];
    NSUserDefaults *firstPush = [NSUserDefaults standardUserDefaults];
    NSString  *firstStr = [firstPush objectForKey:@"firstPush"];
    if (firstStr) {
        [self getImages:NO];
        [self.view addSubview:self.myCo];
        [self createNav];
 
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
   
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
  
}
//
- (void)askForAuthorize {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSUserDefaults *firstPush = [NSUserDefaults standardUserDefaults];
            NSString  *firstStr = [firstPush objectForKey:@"firstPush"];
            if (!firstStr) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [self getImages:NO];
                    [self.view addSubview:self.myCo];
                    [self createNav];
                    NSUserDefaults *firstPush = [NSUserDefaults standardUserDefaults];
                    [firstPush setObject:@"first" forKey:@"firstPush"];
                    
                });
                
            }
            
            
            NSLog(@"相册已授权打开");
        }else{
            NSLog(@"Denied or Restricted");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self openAuthorization:@"相册权限未开启" message:@"相册权限未开启，请在设置中选择当前应用,开启相册功能"];
            });
        }
    }];
}

//判断是否开启了相册权限
- (void)openAuthorization:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *open = [UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:open];
    [alert addAction:cancel];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - buildUI
- (void)createNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav-back"] original] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(wanCheng)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    _keyView = [[UIApplication sharedApplication] keyWindow];
}


//导航返回方法
- (void)Taping {
    //    [_keyView removeFromSuperview];
    [UIView animateWithDuration:0.4 animations:^{
        _barView.frame                = CGRectMake(SCREEN_W,SCREEN_H-49,0,49);
        _navagationView.frame         = CGRectMake(SCREEN_W,0,0,64);
        
    } completion:^(BOOL finished) {
        [_navagationView removeFromSuperview];
        [_barView removeFromSuperview];
    }];
    [_myCo reloadData];
  
}
//图片选择按钮执行方法
- (void)SelectPhotos:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.ImagesSelectedArray[_pageIndex] isEqualToString:@"0"]) {
        [sender setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        [self.ImagesSelectedArray replaceObjectAtIndex:_pageIndex withObject:@"1"];
        [self.selectedArray addObject:self.assets[_pageIndex]];
    }else {
        [sender setImage:[UIImage imageNamed:@"selected_normal"] forState:UIControlStateNormal];
        [self.ImagesSelectedArray replaceObjectAtIndex:_pageIndex withObject:@"0"];
        [self.selectedArray removeObject:self.assets[_pageIndex]];
    }
    [self getPhotosNum];
}

//选出被选择的图片数组（记录被选择图片个数）
- (void)getPhotosNum {
    //     [_selectedPhotosIndexArray removeAllObjects];
    //    for (int i = 0; i<self.ImagesSelectedArray.count; i++) {
    //        if ([self.ImagesSelectedArray[i] isEqualToString:@"1"]) {
    //            [_selectedPhotosIndexArray addObject:@"1"];
    //        }
    //
    //    }
    _photosCount = self.selectedArray.count;
    NSLog(@"lll%ld",_photosCount);
    [photosNumLab setText:[NSString stringWithFormat:@"%ld",_photosCount]];
}

#pragma mark - 导航按钮执行方法
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)wanCheng {
    //如果选中照片数大于可上传的照片
    if (self.maxCount<self.selectedArray.count) {
//        [EasyTextView showText:[NSString stringWithFormat:@"最多可上传%d张照片",self.maxCount]];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate getImagesArray:[self selectImages]];
}
#pragma mark -getImage
- (void)getImages:(BOOL)isFromTakePhoto {
    [_assets removeAllObjects];
    AssetsHelper *ImageAssets = [[AssetsHelper alloc] init];
    [_assets addObjectsFromArray:[ImageAssets getImageAssetSArray]];
    [_ImagesSelectedArray removeAllObjects];
    for (int i=0; i<_assets.count; i++) {
        [_ImagesSelectedArray addObject:@"0"];
    }
    if (isFromTakePhoto) {
        [_ImagesSelectedArray replaceObjectAtIndex:self.assets.count-1 withObject:@"1"];
        [self.selectedArray addObject:[self.assets lastObject]];
    }
    if (_assets.count > 0) {
        [self.myCo reloadData];
    }
    
}

//将选中的图片asset数组转换为image 数组
- (NSArray<UIImage *> *)selectImages {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    WKWAsset *assetObj = [[WKWAsset alloc] init];
    for (int i = 0; i < self.selectedArray.count; i++) {
        PHAsset *asset = self.selectedArray[i];
//        NSURL *url = [asset objectForKey:@"UIImagePickerControllerReferenceURL"];
        UIImage *image = [assetObj OriginalImage:asset];
        image = [self addText:image text:nil];
        [array addObject:image];
    }
    return array;
}
#pragma mark - Delegate + Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"----%ld",self.assets.count);
    if (collectionView.tag == 1000) {
        return self.assets.count;
    }
    return self.assets.count;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"%ld",self.assets.count);
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        SmallCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellId forIndexPath:indexPath];
        cell.checkBtn.tag = indexPath.row+100;
        cell.imageView.tag = indexPath.row;
        if (indexPath.row <self.assets.count) {
            PHAsset *asset = self.assets[indexPath.item];
            //传递图片资源信息
            [cell makeImageCell:asset takePhotos:nil];
            //传递图片是否被选中的状态信息
            [cell checkBtnIsSelected:self.ImagesSelectedArray[indexPath.item]];
        }
        cell.delegate = self;
        return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 2000) {
        return CGSizeMake(SCREEN_W, SCREEN_H);
    }else {
        return CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
    }
}

//判断图片是否被选中
- (void)imageIsSelect {
    if ([self.ImagesSelectedArray[_pageIndex] isEqualToString:@"1"]) {
        [_okButton setImage:[[UIImage imageNamed:@"select"] original] forState:UIControlStateNormal];
        if (![self.selectedArray containsObject:self.assets[_pageIndex]]) {
            [self.selectedArray addObject:self.assets[_pageIndex]];
        }
        
    }else {
        [_okButton setImage:[[UIImage imageNamed:@"selected_normal"]original ]forState:UIControlStateNormal];
        if ([self.selectedArray containsObject:self.assets[_pageIndex]]) {
            [self.selectedArray removeObject:self.assets[_pageIndex]];
        }
        
        
    }
    
}

//滑动的偏移量
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat offsetX = targetContentOffset->x;
    NSInteger pageNum = offsetX/SCREEN_W;
    _pageIndex = pageNum;
    [_indexLable setText:[NSString stringWithFormat:@"%ld/%ld",_pageIndex+1,self.assets.count]];
    [self imageIsSelect];
    //    NSLog(@"这是第：%ld页",pageNum);
}

#pragma mark - SmallCellDelegate

//根据SmallCell的点击改变checkBtn的选中状态
- (void)pushCheckBtnIndex:(NSInteger)index StatusString:(NSString *)statusStr {
    [self.ImagesSelectedArray replaceObjectAtIndex:index withObject:statusStr];
    if ([statusStr isEqualToString:@"1"]&&![self.selectedArray containsObject:self.assets[index]]) {
        [self.selectedArray addObject:self.assets[index]];
    }else{
        [self.selectedArray removeObject:self.assets[index]];
    }
}

//使用相机的代理
- (void)takePhotosAction {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        [self openAuthorization:@"相机权限未开启" message:@"相机权限未开启，请在设置中选择当前应用,开启相册功能"];
        NSLog(@"相机权限受限");
        return;
    }
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.allowsEditing = NO;//此处若设为NO 下面代理方法需如此设置才能获取图(UIImage *image = info[UIImagePickerControllerOriginalImage];)
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerController.modalPresentationStyle =  UIModalPresentationOverCurrentContext;
    //    pickerController.showsCameraControls = NO;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    UIImage *image1 = [UIImage imageWithData:data];
    NSLog(@"oooppp%@",image1);
    [self savePhotos:image1];
    [_assets removeAllObjects];
    [self getImages:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 添加水印
- (UIImage *)addText:(UIImage *)img text:(NSString *)mark {
    if (mark.length != 0) {
    } else {
        //将时间戳转换成时间
        NSDate *date = [NSDate date];
        //    限定格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@" yyyy-MM-dd  hh:mm:ss"];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"china"];//时区名字或地区名字
        [formatter setTimeZone:timeZone];
        mark = [formatter stringFromDate:date];
    }
    
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:30],
                                NSParagraphStyleAttributeName: paragraphStyle,
                                NSForegroundColorAttributeName : [UIColor redColor],
                                NSTextEffectAttributeName: NSTextEffectLetterpressStyle
                                };
    [mark drawInRect:CGRectMake(0, h - 40, w , 40) withAttributes:attribute];
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aImage;
}


// savePhotos (调用系统相机拍下一张照片，准备保存到系统相机胶卷，并获取到图片信息)
- (void)savePhotos:(UIImage *)image {
    NSError *error1 = nil;
    __block PHObjectPlaceholder *createdAsset = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        if (@available(iOS 9.0, *)) {
            createdAsset = [PHAssetCreationRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset;
        } else {
            // Fallback on earlier versions
        }
    } error:&error1];
    
}

#pragma mark - LazyLoad
- (UICollectionView *)myCo {
    if (!_myCo) {
        _layout =[[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing =2.0;
        _layout.minimumInteritemSpacing = 2.0;
        _layout.itemSize = CGSizeMake(kSizeThumbnailCollectionView, kSizeThumbnailCollectionView);
        _layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.footerReferenceSize = CGSizeMake(SCREEN_W, 40);
        _myCo = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) collectionViewLayout:self.layout];
        _myCo.backgroundColor = [UIColor clearColor];
        [_myCo registerClass:[SmallCell class] forCellWithReuseIdentifier:PhotoCellId];
        _myCo.delegate = self;
        _myCo.dataSource = self;
        _myCo.tag = 1000;
        _myCo.showsHorizontalScrollIndicator = NO;
        _myCo.showsVerticalScrollIndicator = NO;
        
    }
    return _myCo;
}
@end
