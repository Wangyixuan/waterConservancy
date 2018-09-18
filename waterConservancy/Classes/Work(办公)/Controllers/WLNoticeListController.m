//
//  WLNoticeListController.m
//  waterConservancy
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLNoticeListController.h"
#import "WLNoticeCell.h"

#define cellIdentifity @"WLNoticeCell"

@interface WLNoticeListController ()

@end

@implementation WLNoticeListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知提醒";
    // Do any additional setup after loading the view.
    [self loadData];
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"清空" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clearNotice) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn sizeToFit];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)clearNotice{
    
}

-(void)loadData{
    NSDictionary *param = @{@"userGuid":@"10bd94958c5c480e8177c043881e0212"};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddressZJ(@"pprty/WSRest/service/notice/pagelist") Parmars:param success:^(id responseObject) {
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
    return 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    //    if (self.dataArr.count>indexPath.row) {
    //        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    //    }
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationLeft];
    //删除数据，和删除动画
//    [self.myDataArr removeObjectAtIndex:deleteRow];
//    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:deleteRow inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
}
@end
