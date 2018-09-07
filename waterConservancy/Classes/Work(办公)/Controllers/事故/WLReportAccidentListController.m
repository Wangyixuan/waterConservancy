//
//  WLReportAccidentListController.m
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLReportAccidentListController.h"
#import "WLReportAccidentCell.h"
#import "WLAcciModel.h"
#import "WLAccidentDetailController.h"
#import "WLAddAccidentController.h"

#define cellIdentifity @"WLReportAccidentCell"

@interface WLReportAccidentListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, weak) UIButton *addAcciBtn;
@end

@implementation WLReportAccidentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"快报事故";
    self.dataArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self initUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
//     NSDictionary *param = @{@"acciWiunGuid":WLShareUserManager.orgID};
    NSDictionary *param = @{@"acciWiunGuid":@"537AD1AB8E7447AAA249AB22A5344955"};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/getAccidentManagements/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *reapArr = [respDic objectForKey:@"data"];
        if (reapArr.count>0) {
            for (NSDictionary *dic in reapArr) {
                WLAcciModel *model = [[WLAcciModel alloc]initWithData:dic];
                    [self.dataArr addObject:model];
            }
            [self loadEngNameWithEngGuid];
        }
    } faild:^(NSError *error) {
        
    }];
}

-(void)loadEngNameWithEngGuid{
    for (WLAcciModel *model in self.dataArr) {
        if (model.wiunGuid.length>0) {
            NSDictionary *param = @{@"guid":model.wiunGuid};
            [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/jck/obj/objEngs/") Parmars:param success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                NSDictionary *respDic = (NSDictionary*)responseObject;
                NSArray *respArr = [respDic objectForKey:@"data"];
                for (NSDictionary *dic in respArr) {
                    model.wiunName = [dic stringForKey:@"engName" defaultValue:@"无"];
                }
                [self.tableView reloadData];
            } faild:^(NSError *error) {
                
            }];
        }
    }
}

-(void)initUI{
    @weakify(self)
    [self.addAcciBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.view.mas_centerX);
        make.bottom.mas_equalTo(weak_self.view.mas_bottom).offset(-15);
        make.width.height.mas_equalTo(70);
    }];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weak_self.view);
        make.bottom.mas_equalTo(weak_self.addAcciBtn.mas_top).offset(-15);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLReportAccidentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    @weakify(self)
    cell.btnClickBlock = ^(WLAcciModel *model) {
        WLAddAccidentController *addacc = [[WLAddAccidentController alloc]init];
        addacc.model = model;
        [weak_self.navigationController pushViewController:addacc animated:YES];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WLAccidentDetailController *detail = [[WLAccidentDetailController alloc]init];
    if (self.dataArr.count>indexPath.row) {
        detail.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
}

-(UIButton*)addAcciBtn{
    if (!_addAcciBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"addAcc"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addAcciBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _addAcciBtn = btn;
    }
    return _addAcciBtn;
}
-(void)addAcciBtnClick{
    WLAddAccidentController *addacc = [[WLAddAccidentController alloc]init];
    [self.navigationController pushViewController:addacc animated:YES];
}
@end
