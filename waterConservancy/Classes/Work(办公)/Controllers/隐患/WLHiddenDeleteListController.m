//
//  WLHiddenDeleteListController.m
//  waterConservancy
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddenDeleteListController.h"
#import "DJHiddenDangerModel.h"
#import "WLHiddenRepairCell.h"

#define cellIdentifity @"WLHiddenRepairCell"

@interface WLHiddenDeleteListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation WLHiddenDeleteListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患整改";
    self.dataArr = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
    [self loadData];
    [self setUpSubViews];
}

-(void)setUpSubViews{
    
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    NSDictionary *param = @{@"hiddStat":@(1),@"orgGuid":WLShareUserManager.orgID};
    
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/objHidds/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *reapArr = [respDic objectForKey:@"data"];
        if (reapArr.count>0) {
            for (NSDictionary *dic in reapArr) {
                DJHiddenDangerModel *model = [[DJHiddenDangerModel alloc]initWithDic:dic];
                [self loadEngNameWithEngGuid:model];
            }
        }
    } faild:^(NSError *error) {
        
    }];
}

-(void)loadEngNameWithEngGuid:(DJHiddenDangerModel*)model{
    NSDictionary *param = @{@"guid":model.engGuid};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/jck/obj/objEngs/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *respArr = [respDic objectForKey:@"data"];
        for (NSDictionary *dic in respArr) {
            model.hiddProjectName = [dic stringForKey:@"engName" defaultValue:@""];
            [self.dataArr addObject:model];
        }
        [self.tableView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLHiddenRepairCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    [cell.actionBtn setTitle:@"销号" forState:UIControlStateNormal];
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectOrNilAtIndex:indexPath.row];
    }
    return cell;
}
@end
