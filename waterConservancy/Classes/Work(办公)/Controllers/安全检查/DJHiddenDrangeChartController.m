//
//  DJHiddenDrangeChartController.m
//  waterConservancy
//
//  Created by liu on 2018/8/16.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJHiddenDrangeChartController.h"
#import "DJHiddenDrangeChartCell.h"

//#import "DJHiddenDangerModel.h"
#import "DJMonthListModel.h"

@interface DJHiddenDrangeChartController ()
@property (nonatomic, strong) NSArray *monthListArray;
@end
static NSString *const HIDDENDRANGECELLREUSEID = @"HIDDENDRANGECELL";

@implementation DJHiddenDrangeChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患报表";
    
    [self initHiddenDangerChartUI];
    
    //隐患
//    NSString *orgid = (NSString *)ORGID;
//    if (orgid.length == 0) {
//        return;
//    }
//    NSDictionary *parmars = TNParams(@"hiddStat":@"1",@"orgGuid":orgid);
//
////    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/objHidds/")  Parmars:parmars success:^(id responseObject) {
//    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/hazy-objHidds/")  Parmars:nil success:^(id responseObject) {
//        @strongify(self);
//        NSArray *dataArray = [responseObject objectForKey:@"data"];
//        self.hiddenDangerArray = [NSArray modelArrayWithClass:[DJHiddenDangerModel class] json:dataArray];
//        [self.tableView reloadData];
//    } faild:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
     @weakify(self);
//    NSDictionary *parmars = TNParams(@"username":CURRENTUSER);
    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/org/mon/rep/hazy-bisOrgMonRepPeris/")  Parmars:nil success:^(id responseObject) {
        @strongify(self);
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        self.monthListArray = [NSArray modelArrayWithClass:[DJMonthListModel class] json:dataArray];
        [self.tableView reloadData];
        NSLog(@"%@",responseObject);
    } faild:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.monthListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJHiddenDrangeChartCell *cell = [tableView dequeueReusableCellWithIdentifier:HIDDENDRANGECELLREUSEID];
    if (!cell) {
        cell = [[DJHiddenDrangeChartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HIDDENDRANGECELLREUSEID];
    }
    DJMonthListModel *model = self.monthListArray[indexPath.row];
    [cell initDataWithModel:model];
    @weakify(self);
    cell.hiddenChartBtnClickBlock = ^(DJMonthListModel *model) {
        @strongify(self);
        [self uploadHiddenDangerWithModel:model];
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALE_W(200);
}

#pragma mark 请求
-(void)uploadHiddenDangerWithModel:(DJMonthListModel *)model{
    //422错误？？
    NSDictionary *parmars = TNParams(@"hiddGuid":model.guid,@"collTime":model.collTime);
    
    [[YXNetTool shareTool]postRequestWithURL:YXNetAddress(@"sjjk/v1/bis/hidd/rec/bisHiddRecRep/") Parmars:parmars success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } faild:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
}




#pragma mark UI
-(void)initHiddenDangerChartUI{
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}
-(NSArray *)monthListArray{
    if (!_monthListArray) {
        NSArray *monthListArray = [NSArray array];
        _monthListArray = monthListArray;
    }
    return _monthListArray;
}

@end
