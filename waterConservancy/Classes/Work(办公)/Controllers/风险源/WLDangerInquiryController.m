//
//  WLDangerInquiryController.m
//  waterConservancy
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLDangerInquiryController.h"
#import "WLDangerPatrolCell.h"
#import "WLDangerModel.h"
#import "WLDangerDetailController.h"

#define cellIdentifity @"WLDangerPatrolCell"

@interface WLDangerInquiryController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation WLDangerInquiryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"风险源查询";
    self.dataArr = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tableView.mj_header = header;
    [header beginRefreshing];
}

-(void)loadNewData{
    if (self.dataArr.count>0) {
        [self.dataArr removeAllObjects];
    }
    NSDictionary *param = @{@"pageSize":@(PAGESIZW),@"orgGuid":@"21260E691D454685B61086E7F2074B71"};
    [self loadDataWithParam:param];
}

-(void)loadMoreData{
    NSDictionary *param = @{@"pageSize":@(PAGESIZW),@"currentPage":@(self.dataArr.count/PAGESIZW+1),@"orgGuid":@"21260E691D454685B61086E7F2074B71"};
    
    [self loadDataWithParam:param];
}

-(void)loadDataWithParam:(NSDictionary*)param{
    
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/objHazs/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *data = [respDic objectForKey:@"data"];
        if (data.count>0) {
            for (NSDictionary *dic in data) {
                WLDangerModel *model = [[WLDangerModel alloc]initWithDic:dic];
                [self.dataArr addObject:model];
            }
            [self tableViewReload:data.count];
        }else{
            [self tableViewReload:0];
        }
        
    } faild:^(NSError *error) {
        NSLog(@"error%@",error);
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
    else if (arrCount==0 &&self.dataArr.count==0){
        //无数据
    }else if (arrCount==-1){
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
    else [self.tableView.mj_footer endRefreshingWithNoMoreData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLDangerPatrolCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    cell.patrolBtn.hidden = YES;
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WLDangerDetailController *detail = [[WLDangerDetailController alloc]init];
    if (self.dataArr.count>indexPath.row) {
        detail.model  = [self.dataArr objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
}
@end
