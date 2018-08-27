//
//  WLHiddenEngListController.m
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddenEngListController.h"
#import "WLEngListCell.h"
#import "WLTendPopView.h"
#import "WLUploadHiddenController.h"

#define EngListCellIdentifity @"WLEngListCell"

@interface WLHiddenEngListController ()
@property (nonatomic, strong) NSMutableArray *engArr;
@end

@implementation WLHiddenEngListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患上报";
    self.engArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self loadNewData];
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self loadNewData];
//    }];
//    self.tableView.mj_header = header;
//    [header beginRefreshing];
    [self setUpSubViews];
}


-(void)loadNewData{
    if (self.engArr.count>0) {
        [self.engArr removeAllObjects];
    }
    NSDictionary *param = @{@"pageSize":@(PAGESIZW),@"orgguid":WLShareUserManager.orgID};
    [self loadDataWithParam:param];
}

-(void)loadMoreData{
    NSDictionary *param = @{@"pageSize":@(PAGESIZW),@"currentPage":@(self.engArr.count/PAGESIZW+1),@"orgguid":WLShareUserManager.orgID};
    
    [self loadDataWithParam:param];
}

-(void)loadDataWithParam:(NSDictionary*)param{
    
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/mv/eng/coll/mvEngColls/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *respArr = [respDic objectForKey:@"data"];
        if (respArr.count>0) {
            for (NSDictionary *dic in respArr) {
                [self.engArr addObject:dic];
            }
            [self tableViewReload:respArr.count];
        }else{
            [self tableViewReload:0];
        }
    } faild:^(NSError *error) {
        [self tableViewReload:-1];
    }];
}

-(void)tableViewReload:(NSInteger)arrCount{
    @weakify(self)
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    if(arrCount==PAGESIZW)
    {
        //显示加载更多
        self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weak_self loadMoreData];
        }];
    }
    else if (arrCount==0 &&self.engArr.count!=0){
        //无数据
    }else if (arrCount==-1){
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
    else [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

-(void)setUpSubViews{
    
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:EngListCellIdentifity bundle:nil] forCellReuseIdentifier:EngListCellIdentifity];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.engArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLEngListCell *cell = [tableView dequeueReusableCellWithIdentifier:EngListCellIdentifity forIndexPath:indexPath];
        if (self.engArr.count>indexPath.row) {
            NSDictionary *dic =[self.engArr objectAtIndex:indexPath.row];
            cell.engNameLab.text = [dic stringForKey:@"name" defaultValue:@""];
        }
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WLTendPopView *popView = [WLTendPopView creatTendPopViewWithData:self.engArr];
    popView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    @weakify(self)
    popView.uploadHiddenBlock = ^{
        WLUploadHiddenController *upload = [[WLUploadHiddenController alloc]init];
        [weak_self.navigationController pushViewController:upload animated:YES];
    };
    [self.tabBarController.view addSubview:popView];
   
    if (self.engArr.count>indexPath.row) {
         NSDictionary *dic = [self.engArr objectAtIndex:indexPath.row];
        NSString *engID = [dic stringForKey:@"engId" defaultValue:@""];
        [self loadTendDataWith:engID];
    }
   
}

-(void)loadTendDataWith:(NSString*)engGuid{
    NSDictionary *param = @{@"engGuid":engGuid};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/jck/obj/objTends/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } faild:^(NSError *error) {
        
    }];
    
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SCALE_W(100))];
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, ScreenWidth-10, SCALE_W(60))];
    [backImgV setImage:[UIImage imageNamed:@"flow1"]];
    [headView addSubview:backImgV];
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(30), SCALE_W(22), SCALE_W(5), SCALE_W(30))];
    line1View.backgroundColor = FColor(64.0, 114.0, 216.0, 1.0);
    [backImgV addSubview:line1View];
    
    UILabel *SeactionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCALE_W(45), SCALE_W(15), ScreenWidth, SCALE_W(45))];
    [SeactionLabel setText:@"请选择排查工程"];
    [SeactionLabel setTextColor:FColor(64.0, 114.0, 216.0, 1.0)];
    [SeactionLabel setFont:YX26Font];
    [backImgV addSubview:SeactionLabel];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(60), ScreenWidth-SCALE_W(80), 1)];
    lineView.backgroundColor = GrayLineColor;
    [backImgV addSubview:lineView];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCALE_W(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SCALE_W(40);
}

@end
