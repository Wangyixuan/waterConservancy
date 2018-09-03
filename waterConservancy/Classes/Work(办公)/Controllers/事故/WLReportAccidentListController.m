//
//  WLReportAccidentListController.m
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLReportAccidentListController.h"
#import "WLReportAccidentCell.h"

#define cellIdentifity @"WLReportAccidentCell"

@interface WLReportAccidentListController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WLReportAccidentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快报事故";
    // Do any additional setup after loading the view.
    [self initUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    NSDictionary *param = @{@"acciWiunGuid":@"537AD1AB8E7447AAA249AB22A5344955"};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/getAccidentManagements/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } faild:^(NSError *error) {
        
    }];
}

-(void)initUI{
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLReportAccidentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    return cell;
}
@end
