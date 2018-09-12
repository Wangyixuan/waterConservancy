//
//  WLMailListController.m
//  waterConservancy
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLMailListController.h"
#import "WLMailListCell.h"
#import "WLContactDetailController.h"
#import "WLSearchContactController.h"

#define cellIdentifity @"WLMailListCell"

@interface WLMailListController ()

@end

@implementation WLMailListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}

-(void)search{
    WLSearchContactController *search = [[WLSearchContactController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
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
    WLMailListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    //    if (self.dataArr.count>indexPath.row) {
    //        cell.model = [self.dataArr objectAtIndex:indexPath.row];
    //    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WLContactDetailController *detail = [[WLContactDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
@end
