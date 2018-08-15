//
//  WorkViewController.m
//  waterConservancy
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WorkViewController.h"
#import "WLWorkTopView.h"
#import "WLWorkCell.h"
#import "WLFirstCell.h"

#define WORKCELLIDENTIFITY @"WLWorkCell"
#define FIRSTCELLIDENTIFITY @"WLFirstCell"

@interface WorkViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *workCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *workCollectionViewLayout;
@property (nonatomic, weak) WLWorkTopView *topView;
@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTopView];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO];
}
-(void)setupUI{
    @weakify(self)
    [self.workCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weak_self.topView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(WC_HOMEBAR_HEIGHT);
    }];
    
}

-(void)setupTopView{
    if (!_topView) {
        WLWorkTopView *topView = [[WLWorkTopView alloc]initWithFrame:CGRectMake(0, 0, WCScreenWidth, 230)];
        [self.view addSubview:topView];
        self.topView = topView;
        topView.noticeBlock = ^{
            NSLog(@"提醒通知");
        };
        topView.agencyWorkBlock = ^{
            NSLog(@"待办工作");
        };
        topView.userInfoBlock = ^{
            NSLog(@"个人中心");
        };
        topView.nearBlock = ^{
            NSLog(@"附近隐患");
        };
        topView.QRCodeBlock = ^{
            NSLog(@"二维码");
        };
    }
}

-(UICollectionView*)workCollectionView{
    if (!_workCollectionView) {
        UICollectionView *colView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.workCollectionViewLayout];
        colView.delegate = self;
        colView.dataSource = self;
        [colView registerClass:[WLWorkCell class] forCellWithReuseIdentifier:WORKCELLIDENTIFITY];
        [colView registerClass:[WLFirstCell class] forCellWithReuseIdentifier:FIRSTCELLIDENTIFITY];
        colView.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:colView];
        _workCollectionView = colView;
    }
    return _workCollectionView;
}

-(UICollectionViewFlowLayout*)workCollectionViewLayout{
    if (!_workCollectionViewLayout) {
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc]init];
        //item大小
        collectionLayout.itemSize = CGSizeMake(50, 50);
        //最小行间距
        collectionLayout.minimumLineSpacing = 20;
        //最小列间距
        collectionLayout.minimumInteritemSpacing = 10;
        //内边距
        collectionLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        //滑动方向
        collectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _workCollectionViewLayout = collectionLayout;
    }
    return _workCollectionViewLayout;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        WLFirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FIRSTCELLIDENTIFITY forIndexPath:indexPath];
        return cell;
    }else{
        WLWorkCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:WORKCELLIDENTIFITY forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return CGSizeMake(50, 100);
    }else{
        return CGSizeMake(100, 100);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
@end
