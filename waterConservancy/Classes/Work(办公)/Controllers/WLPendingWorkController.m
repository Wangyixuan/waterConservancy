//
//  WLPendingWorkController.m
//  waterConservancy
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLPendingWorkController.h"
#import "WLPendingWorkCell.h"

#define cellIdentifity @"WLPendingWorkCell"

@interface WLPendingWorkController ()

@end

@implementation WLPendingWorkController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待办工作";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
    [self loadData];
}
-(void)loadData{
    NSDictionary *param = @{@"roleCode":@"130821199103278829"};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddressZJ(@"pprty/WSRest/service/backlog") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } faild:^(NSError *error) {
        
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLPendingWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
//    if (self.dataArr.count>indexPath.row) {
//        cell.model = [self.dataArr objectAtIndex:indexPath.row];
//    }
    return cell;
}
@end
