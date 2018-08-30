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
#import "DJLoadViewController.h"
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
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"updateData" object:nil];
    [self setupUI];
    
}
-(void)loadData{
    //企事业用户数据
    NSMutableArray *BDicArr = [NSMutableArray array];
    //行政用户数据
    NSMutableArray *CDicArr = [NSMutableArray array];
    //用户数据 根据用户类型区分数据（企事业用户包括报表管理、安全检查、事故、隐患、风险源）
 
    NSDictionary *baobiao1 =@{@"text":@"隐患报表",@"img":@"baobiao_yinhuan",@"ctrl":@"DJHiddenDrangeChartController"};
    NSDictionary *baobiao2 =@{@"text":@"事故报表",@"img":@"baobiao_shigu",@"ctrl":@""};
    NSDictionary *baobiao3 =@{@"text":@"检查报表",@"img":@"baobiao_anquan",@"ctrl":@""};
    NSDictionary *baobiao4 =@{@"text":@"考核报表",@"img":@"baobiao_gongzuo",@"ctrl":@""};
    NSArray *baobiaoArr = @[baobiao1,baobiao2,baobiao3,baobiao4];
    NSDictionary *baobiaoDic = @{@"title":@"报表管理",@"data":baobiaoArr,@"bgImage":@"baobiaoguanli"};
    [CDicArr addObject:baobiaoDic];
    [BDicArr addObject:baobiaoDic];
    
    NSDictionary *aq1 =@{@"text":@"现场检查",@"img":@"anquan_xianchang",@"ctrl":@"DJOnSpotCheckController"};
    NSDictionary *aq2 =@{@"text":@"检查查询",@"img":@"anquan_chaxun",@"ctrl":@""};
    NSDictionary *aq3 =@{@"text":@"元素检查",@"img":@"anquan_yuansu",@"ctrl":@"DJElementCheckController"};
    NSArray *aqArr1 = @[aq1,aq2];
    NSDictionary *aqDic1 = @{@"title":@"安全检查",@"data":aqArr1,@"bgImage":@"anquanjiancha"};
    [CDicArr addObject:aqDic1];
    //企事业用户使用
    // 技术服务 施工 监理单位 只有现场检查模块，项目法人和水利工程管理单位有元素检查
     NSArray *aqArr2 = @[aq3,aq1];
    if (WLShareUserManager.bUserType==BUserTypeCJFW||WLShareUserManager.bUserType==BUserTypeCJSG||
        WLShareUserManager.bUserType==BUserTypeCJJL) {
        aqArr2 = @[aq1];
    }
    NSDictionary *aqDic2 = @{@"title":@"安全检查",@"data":aqArr2,@"bgImage":@"anquanjiancha"};

    [BDicArr addObject:aqDic2];
   
    NSDictionary *xh1 =@{@"text":@"隐患验收",@"img":@"yinhuan_yanshou",@"ctrl":@""};
    NSDictionary *xh2 =@{@"text":@"隐患督办",@"img":@"yinhuan_duban",@"ctrl":@""};
    NSDictionary *xh3 =@{@"text":@"隐患上报",@"img":@"yinhuan_shangbao",@"ctrl":@"WLHiddenEngListController"};
    NSDictionary *xh4 =@{@"text":@"隐患整改",@"img":@"yinhuan_zhenggai",@"ctrl":@"WLHiddenRepairListController"};
    NSDictionary *xh5 =@{@"text":@"隐患销号",@"img":@"yinhuan_xiaohao",@"ctrl":@"WLHiddenDeleteListController"};
   //行政用户使用
    NSArray *xhArr1 = @[xh1,xh2];
    NSDictionary *xhDic1 = @{@"title":@"隐患",@"data":xhArr1,@"bgImage":@"yinhuan"};
    [CDicArr addObject:xhDic1];
    //企事业用户使用
    NSArray *xhArr2 = @[xh3,xh4,xh5];
    NSDictionary *xhDic2 = @{@"title":@"隐患",@"data":xhArr2,@"bgImage":@"yinhuan"};
    [BDicArr addObject:xhDic2];
    
    NSDictionary *sg1 =@{@"text":@"快报事故",@"img":@"shigu_kuaibao",@"ctrl":@""};
    NSDictionary *sg2 =@{@"text":@"事故查询",@"img":@"shigu_chaxun",@"ctrl":@""};
    NSArray *sgArr = @[sg1,sg2];
    NSDictionary *sgDic = @{@"title":@"事故",@"data":sgArr,@"bgImage":@"shigu"};
    [CDicArr addObject:sgDic];
    [BDicArr addObject:sgDic];
    //企事业用户使用
    NSDictionary *fx1 =@{@"text":@"风险源巡查",@"img":@"weixian_beian",@"ctrl":@""};
    NSDictionary *fx2 =@{@"text":@"风险源查询",@"img":@"weixian_chaxun",@"ctrl":@""};
    NSArray *fxArr = @[fx1,fx2];
    NSDictionary *fxDic = @{@"title":@"风险源",@"data":fxArr,@"bgImage":@"weixianyuan"};
    [BDicArr addObject:fxDic];
    //行政用户使用
    NSDictionary *wx1 =@{@"text":@"备案审核",@"img":@"weixian_beian",@"ctrl":@""};
    NSDictionary *wx2 =@{@"text":@"核销审核",@"img":@"weixian_hexiao",@"ctrl":@""};
    NSArray *wxArr = @[wx1,wx2];
    NSDictionary *wxDic = @{@"title":@"危险源",@"data":wxArr,@"bgImage":@"weixianyuan"};
    [CDicArr addObject:wxDic];
    
    NSDictionary *bb1 =@{@"text":@"形式初审",@"img":@"biaozhun_xingshi",@"ctrl":@""};
    NSDictionary *bb2 =@{@"text":@"材料初审",@"img":@"biaozhun_cailiao",@"ctrl":@""};
    NSDictionary *bb3 =@{@"text":@"现场复核",@"img":@"biaozhun_fuhe",@"ctrl":@""};
    NSDictionary *bb4 =@{@"text":@"审定",@"img":@"biaozhun_shending",@"ctrl":@""};
    NSDictionary *bb5 =@{@"text":@"公示",@"img":@"biaozhun_gongshi",@"ctrl":@""};
    NSDictionary *bb6 =@{@"text":@"公告",@"img":@"biaozhun_gonggao",@"ctrl":@""};
    NSArray *bbArr = @[bb1,bb2,bb3,bb4,bb5,bb6];
    NSDictionary *bbDic = @{@"title":@"标准化",@"data":bbArr,@"bgImage":@"biaozhunhua"};
    [CDicArr addObject:bbDic];
    
    NSDictionary *gg1 =@{@"text":@"安全生产",@"img":@"gongzuo_shengchan",@"ctrl":@""};
    NSDictionary *gg2 =@{@"text":@"水利稽查",@"img":@"gongzuo_jicha",@"ctrl":@""};
    NSArray *ggArr = @[gg1,gg2];
    NSDictionary *ggDic = @{@"title":@"工作考核",@"data":ggArr,@"bgImage":@"gongzuokaohe"};
    [CDicArr addObject:ggDic];
    
    NSDictionary *jj1 =@{@"text":@"现场执法",@"img":@"jiandu_zhifa",@"ctrl":@""};
    NSDictionary *jj2 =@{@"text":@"执法查询",@"img":@"jiandu_chaxun",@"ctrl":@""};
    NSArray *jjArr = @[jj1,jj2];
    NSDictionary *jjDic = @{@"title":@"监督执法",@"data":jjArr,@"bgImage":@"jianduzhifa"};
    [CDicArr addObject:jjDic];
    
    NSDictionary *ss1 =@{@"text":@"现场稽查",@"img":@"shuili_xianchang",@"ctrl":@""};
    NSDictionary *ss2 =@{@"text":@"稽查查询",@"img":@"shuili_chaxun",@"ctrl":@""};
    NSArray *ssArr = @[ss1,ss2];
    NSDictionary *ssDic = @{@"title":@"水利稽查",@"data":ssArr,@"bgImage":@"shuiliducha"};
    [CDicArr addObject:ssDic];

    if (self.dataArr.count>0) {
        [self.dataArr removeAllObjects];
    }
    for (NSDictionary*dic in BDicArr) {
        WLWorkModel *model = [[WLWorkModel alloc]initWithDic:dic];
        [self.dataArr addObject:model];
    }
    [self.workList reloadData];
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
    cell.btnClickBlock = ^(NSString *ctrlStr) {
        NSLog(@"item点击%@",ctrlStr);
        [weak_self pushControllerWithTitle:ctrlStr];
    };
    return cell;
}
#pragma  mark privateMethod
-(WLWorkTopView*)setupTopView{
    WLWorkTopView *topView = [[WLWorkTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
    @weakify(self)
    topView.noticeBlock = ^{
        NSLog(@"提醒通知");
    };
    topView.agencyWorkBlock = ^{
        NSLog(@"待办工作");
        WLShareUserManager.autoLoginEnabled = NO;
        DJLoadViewController *loadCtrl = [[DJLoadViewController alloc]init];
        [weak_self.navigationController pushViewController:loadCtrl animated:YES];
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

    if (titie.length>0) {
        YXBaseViewController *ctrl = [[NSClassFromString(titie) alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

@end
        
