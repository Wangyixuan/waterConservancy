//
//  WLEducationViewController.m
//  waterConservancy
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLEducationViewController.h"
#import "WLGateListCell.h"


#define cellIdentifity @"WLGateListCell"

@interface WLEducationViewController ()

@end

@implementation WLEducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self)
    [self.view addSubview:self.tableView];
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
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLGateListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
