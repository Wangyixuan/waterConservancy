//
//  WLPatrolRecordController.m
//  waterConservancy
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLPatrolRecordController.h"
#import "WLPatrolRecordListCell.h"
#import "WLPatrolRecordDetailController.h"

#define cellIdentifity @"WLPatrolRecordListCell"

@interface WLPatrolRecordController ()

@end

@implementation WLPatrolRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"风险源巡查记录";
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
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
    return 70;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLPatrolRecordListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WLPatrolRecordDetailController *detail = [[WLPatrolRecordDetailController alloc]init];
    if (self.dataArr.count>indexPath.row) {
        detail.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
}

@end
