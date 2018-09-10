//
//  WLHiddenReportViewController.m
//  waterConservancy
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddenReportViewController.h"
#import "WLReportListCell.h"

#define cellIdentifity @"WLReportListCell"

@interface WLHiddenReportViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WLHiddenReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患报表";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
    [self loadReportData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadReportData{
    NSDictionary * param =@{@"repOrgGuid":@"21260E691D454685B61086E7F2074B71",@"repTime":@"2018年08月",@"repType":@"1"};
    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/org/mon/rep/hazy-bisOrgMonRepPeris/")  Parmars:param success:^(id responseObject) {
//        NSArray *dataArray = [responseObject objectForKey:@"data"];
//        self.monthListArray = [NSArray modelArrayWithClass:[DJMonthListModel class] json:dataArray];
//        [self.tableView reloadData];
        NSLog(@"%@",responseObject);
    } faild:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
    WLReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    return cell;
}
@end
