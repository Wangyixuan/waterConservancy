//
//  WorkViewController.m
//  waterConservancy
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WorkViewController.h"
#import "WLWorkTopView.h"
#import "WLWorkModel.h"
#import "WLWorkTableViewCell.h"
//二级跳转ctrl
#import "DJHiddenDrangeChartController.h"
#import "DJElementCheckController.h"
#import "DJOnSpotCheckController.h"


@interface WorkViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *workList;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

#define TABLEVIEWCELLIDENTIFITY  @"WLWorkTableViewCell"
@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
 
    [self setupUI];
    [self loadData];
}
-(void)loadData{
    NSDictionary *dic =@{@"title":@"检查查询",@"img":@"anquan_chaxun"};
    for (int i = 0; i < 9; ++i) {
        NSMutableArray *arr1 = [NSMutableArray array];
        int nub = (arc4random()%6)+1;
        for (int i = 0; i < nub; ++i) {
            WLWorkModel *workModel = [[WLWorkModel alloc]initWithDic:dic];
            [arr1 addObject:workModel];
        }
        [self.dataArr addObject:arr1];
    }
    [self.tableView reloadData];
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
    [self.workList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(WC_HOMEBAR_HEIGHT);
    }];
}

-(UITableView*)workList{
    if (!_workList) {
        UITableView *tab = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tab.delegate = self;
        tab.dataSource = self;
        [tab registerNib:[UINib nibWithNibName:TABLEVIEWCELLIDENTIFITY bundle:nil] forCellReuseIdentifier:TABLEVIEWCELLIDENTIFITY];
        if (@available(iOS 11.0, *)) {
            tab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            //没有这个属性，在ios8里面scrollview会向下偏移64像素
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        tab.tableHeaderView = [self setupTopView];
        [self.view addSubview:tab];
        self.workList = tab;
    }
    return _workList;
}

#pragma mark delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return SCALE_W(186);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WLWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEWCELLIDENTIFITY forIndexPath:indexPath];
    if (self.dataArr.count>indexPath.row) {
        cell.modelArr = [self.dataArr objectAtIndex:indexPath.row];
    }
    @weakify(self);
    cell.btnClickBlock = ^(NSString *cellTitle) {
        NSLog(@"item点击%@",cellTitle);
        [weak_self pushControllerWithTitle:cellTitle];
    };
    return cell;
}
#pragma  mark privateMethod
-(WLWorkTopView*)setupTopView{
    WLWorkTopView *topView = [[WLWorkTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
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
    return topView;
}
-(void)pushControllerWithTitle:(NSString *)titie{
//    if ([titie isEqualToString:@"隐患报表"]) {
        DJHiddenDrangeChartController *hiddenCtrl = [[DJHiddenDrangeChartController alloc]init];
        [self.navigationController pushViewController:hiddenCtrl animated:YES];
//    }
//    else if (titie isEqualToString:@"")
}


 @end
        
