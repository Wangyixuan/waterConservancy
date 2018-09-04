//
//  WLAccidentInquiryListController.m
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAccidentInquiryListController.h"
#import "WLAccidentInquiryCell.h"
#import "WLAccidentDetailController.h"

#define cellIdentifity @"WLAccidentInquiryCell"

@interface WLAccidentInquiryListController ()
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation WLAccidentInquiryListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事故查询";
    self.dataArr = [NSMutableArray array];
    [self loadData];
    // Do any additional setup after loading the view.
    [self initUI];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLAccidentInquiryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    if (self.dataArr.count>indexPath.row) {
        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WLAccidentDetailController *detail = [[WLAccidentDetailController alloc]init];
    if (self.dataArr.count>indexPath.row) {
        detail.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
}
@end
