//
//  DJOnSpotCheckController.m
//  waterConservancy
//
//  Created by liu on 2018/8/16.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJOnSpotCheckController.h"
#import "DJOnSpotCheckCell.h"
#import "WLOnSpotMapViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>

#define PAGESIZW 10

@interface DJOnSpotCheckController ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@end
static NSString *const ONSPOTCHECKCELLREUSEID = @"ONSPOTCHECKCELL";
@implementation DJOnSpotCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现场检查";
    self.dataArr = [NSMutableArray array];
    [self initOnSpotChecktUI];
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
    NSDictionary *param = @{@"pageSize":@(PAGESIZW)};
    [self loadDataWithParam:param];
}

-(void)loadMoreData{
    NSDictionary *param = @{@"pageSize":@(PAGESIZW),@"currentPage":@(self.dataArr.count/PAGESIZW+1)};

    [self loadDataWithParam:param];
}

-(void)loadDataWithParam:(NSDictionary*)param{

    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/sins/bisSinsRecs/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
       
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *data = [respDic objectForKey:@"data"];
        if (data.count>0) {
            for (NSDictionary *dic in data) {
                WLOnSpotCheckModel *model = [[WLOnSpotCheckModel alloc]initWithDic:dic];
                [self.dataArr addObject:model];
            }
            [self tableViewReload:data.count];
        }else{
            [self tableViewReload:0];
        }
       
    } faild:^(NSError *error) {
        NSLog(@"error%@",error);
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
    else if (arrCount==0 &&self.dataArr.count!=0){
        //无数据
    }
    else [self.tableView.mj_footer endRefreshingWithNoMoreData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJOnSpotCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:ONSPOTCHECKCELLREUSEID forIndexPath:indexPath];
    if (!cell) {
        cell = [[DJOnSpotCheckCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ONSPOTCHECKCELLREUSEID];
    }
    @weakify(self);
    cell.onSpotCheckBtnClickBlock  = ^{
        @strongify(self);
        WLOnSpotMapViewController *mapView = [[WLOnSpotMapViewController alloc]init];
        [self.navigationController pushViewController:mapView animated:YES];
    };
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat cellH = [tableView fd_heightForCellWithIdentifier:ONSPOTCHECKCELLREUSEID cacheByIndexPath:indexPath configuration:^(DJOnSpotCheckCell *cell) {
        if (self.dataArr.count>indexPath.row) {
            cell.model = [self.dataArr objectAtIndex:indexPath.row];
        }
    }];

    return cellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark UI
-(void)initOnSpotChecktUI{
    [self.tableView registerClass:[DJOnSpotCheckCell class] forCellReuseIdentifier:ONSPOTCHECKCELLREUSEID];
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}

@end
