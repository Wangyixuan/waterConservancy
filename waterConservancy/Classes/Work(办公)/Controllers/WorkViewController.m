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
    NSMutableArray *dicArr = [NSMutableArray array];

    NSDictionary *baobiao1 =@{@"text":@"隐患报表",@"img":@"baobiao_yinhuan"};
    NSDictionary *baobiao2 =@{@"text":@"事故报表",@"img":@"baobiao_shigu"};
    NSDictionary *baobiao3 =@{@"text":@"检查报表",@"img":@"baobiao_anquan"};
    NSDictionary *baobiao4 =@{@"text":@"考核报表",@"img":@"baobiao_gongzuo"};
    NSArray *baobiaoArr = @[baobiao1,baobiao2,baobiao3,baobiao4];
    NSDictionary *baobiaoDic = @{@"title":@"报表管理",@"data":baobiaoArr,@"bgImage":@"baobiaoguanli"};
    [dicArr addObject:baobiaoDic];
    
    NSDictionary *aq1 =@{@"text":@"现场检查",@"img":@"anquan_xianchang"};
    NSDictionary *aq2 =@{@"text":@"检查查询",@"img":@"anquan_chaxun"};
    NSArray *aqArr = @[aq1,aq2];
    NSDictionary *aqDic = @{@"title":@"安全检查",@"data":aqArr,@"bgImage":@"anquanjiancha"};
    [dicArr addObject:aqDic];
   
    NSDictionary *xh1 =@{@"text":@"隐患验收",@"img":@"yinhuan_yanshou"};
    NSDictionary *xh2 =@{@"text":@"隐患督办",@"img":@"yinhuan_duban"};
    NSArray *xhArr = @[xh1,xh2];
    NSDictionary *xhDic = @{@"title":@"隐患",@"data":xhArr,@"bgImage":@"yinhuan"};
    [dicArr addObject:xhDic];
    
    NSDictionary *sg1 =@{@"text":@"快报事故",@"img":@"shigu_kuaibao"};
    NSDictionary *sg2 =@{@"text":@"事故查询",@"img":@"shigu_chaxun"};
    NSArray *sgArr = @[sg1,sg2];
    NSDictionary *sgDic = @{@"title":@"事故",@"data":sgArr,@"bgImage":@"shigu"};
    [dicArr addObject:sgDic];
    
    NSDictionary *fx1 =@{@"text":@"备案审核",@"img":@"weixian_beian"};
    NSDictionary *fx2 =@{@"text":@"核销审核",@"img":@"weixian_hexiao"};
    NSArray *fxArr = @[fx1,fx2];
    NSDictionary *fxDic = @{@"title":@"风险源",@"data":fxArr,@"bgImage":@"weixianyuan"};
    [dicArr addObject:fxDic];
    
    NSDictionary *bb1 =@{@"text":@"形式初审",@"img":@"biaozhun_xingshi"};
    NSDictionary *bb2 =@{@"text":@"材料初审",@"img":@"biaozhun_cailiao"};
    NSDictionary *bb3 =@{@"text":@"现场复核",@"img":@"biaozhun_fuhe"};
    NSDictionary *bb4 =@{@"text":@"审定",@"img":@"biaozhun_shending"};
    NSDictionary *bb5 =@{@"text":@"公示",@"img":@"biaozhun_gongshi"};
    NSDictionary *bb6 =@{@"text":@"公告",@"img":@"biaozhun_gonggao"};
    NSArray *bbArr = @[bb1,bb2,bb3,bb4,bb5,bb6];
    NSDictionary *bbDic = @{@"title":@"标准化",@"data":bbArr,@"bgImage":@"biaozhunhua"};
    [dicArr addObject:bbDic];
    
    NSDictionary *gg1 =@{@"text":@"安全生产",@"img":@"gongzuo_shengchan"};
    NSDictionary *gg2 =@{@"text":@"水利稽查",@"img":@"gongzuo_jicha"};
    NSArray *ggArr = @[gg1,gg2];
    NSDictionary *ggDic = @{@"title":@"工作考核",@"data":ggArr,@"bgImage":@"gongzuokaohe"};
    [dicArr addObject:ggDic];
    
    NSDictionary *jj1 =@{@"text":@"现场执法",@"img":@"jiandu_zhifa"};
    NSDictionary *jj2 =@{@"text":@"执法查询",@"img":@"jiandu_chaxun"};
    NSArray *jjArr = @[jj1,jj2];
    NSDictionary *jjDic = @{@"title":@"监督执法",@"data":jjArr,@"bgImage":@"jianduzhifa"};
    [dicArr addObject:jjDic];
    
    NSDictionary *ss1 =@{@"text":@"现场稽查",@"img":@"shuili_xianchang"};
    NSDictionary *ss2 =@{@"text":@"稽查查询",@"img":@"shuili_chaxun"};
    NSArray *ssArr = @[ss1,ss2];
    NSDictionary *ssDic = @{@"title":@"水利稽查",@"data":ssArr,@"bgImage":@"shuiliducha"};
    [dicArr addObject:ssDic];
    
    for (NSDictionary*dic in dicArr) {
        WLWorkModel *model = [[WLWorkModel alloc]initWithDic:dic];
        [self.dataArr addObject:model];
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
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return SCALE_W(186);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WLWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLEVIEWCELLIDENTIFITY forIndexPath:indexPath];
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectAtIndex:indexPath.row];
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
//        DJHiddenDrangeChartController *hiddenCtrl = [[DJHiddenDrangeChartController alloc]init];
//        [self.navigationController pushViewController:hiddenCtrl animated:YES];
//    }
//    else if ([titie isEqualToString:@"元素检查"]){
        DJElementCheckController *elementCheckCtrl = [[DJElementCheckController alloc]init];
        [self.navigationController pushViewController:elementCheckCtrl animated:YES];
//    }
}


 @end
        
