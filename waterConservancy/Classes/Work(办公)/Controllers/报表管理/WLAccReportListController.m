//
//  WLAccReportListController.m
//  waterConservancy
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAccReportListController.h"
#import "WLReportListCell.h"
#import "WLReportModel.h"

#define cellIdentifity @"WLReportListCell"

@interface WLAccReportListController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation WLAccReportListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事故报表";
    self.dataArr = [NSMutableArray array];
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSDictionary * param =@{@"repOrgGuid":@"21260E691D454685B61086E7F2074B71",@"repTime":dateStr,@"repType":@"1"};
    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/org/mon/rep/hazy-bisOrgMonRepPeris/")  Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *reapArr = [respDic objectForKey:@"data"];
        for (NSDictionary *dic in reapArr) {
            WLReportModel *model = [[WLReportModel alloc]initWithData:dic];
            [self.dataArr addObject:model];
        }
        [self loadReportAct];
        [self.tableView reloadData];
        
    } faild:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)loadReportAct{
    for (WLReportModel *model in self.dataArr) {
        if (model.guid.length>0) {
            NSDictionary *param = @{@"repGuid":model.guid};
            [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/hidd/rec/bisHiddRecReps/") Parmars:param success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                NSDictionary *respDic = (NSDictionary*)responseObject;
                NSArray *reapArr = [respDic objectForKey:@"data"];
                for (NSDictionary *dic in reapArr) {
                    model.repAct = [dic stringForKey:@"repAct" defaultValue:@""];
                }
            } faild:^(NSError *error) {
                
            }];
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLReportListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    return cell;
}

@end
