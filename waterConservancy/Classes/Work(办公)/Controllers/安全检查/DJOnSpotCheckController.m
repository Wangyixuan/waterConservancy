//
//  DJOnSpotCheckController.m
//  waterConservancy
//
//  Created by liu on 2018/8/16.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJOnSpotCheckController.h"
#import "DJOnSpotCheckCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

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
    MJRefreshHeader *header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.mj_header = header;
    [header beginRefreshing];

//    [self loadData];
}

-(void)loadData{
    NSDictionary *param = @{@"pageSize":@(10)};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/sins/bisSinsRecs/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        [self.tableView.mj_header endRefreshing];
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *data = [respDic objectForKey:@"data"];
        if (data.count>0) {
            for (NSDictionary *dic in data) {
                WLOnSpotCheckModel *model = [[WLOnSpotCheckModel alloc]initWithDic:dic];
                [self.dataArr addObject:model];
            }
        }
        [self.tableView reloadData];
    } faild:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
    
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
        
    };
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellH = [tableView fd_heightForCellWithIdentifier:ONSPOTCHECKCELLREUSEID cacheByIndexPath:indexPath configuration:^(DJOnSpotCheckCell * cell) {
         cell.model = [self.dataArr objectAtIndex:indexPath.row];
    }];
    
    return cellH;
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
