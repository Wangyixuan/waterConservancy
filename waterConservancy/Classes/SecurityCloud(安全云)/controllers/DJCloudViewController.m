
//
//  DJCloudViewController.m
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJCloudViewController.h"
#import "DJHiddenDrangeChartCell.h"

@interface DJCloudViewController ()

@end
static NSString *const HIDDENDRANGECELLREUSEID = @"HIDDENDRANGECELL";
@implementation DJCloudViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患报表";
    
    [self initHiddenDangerChartUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJHiddenDrangeChartCell *cell = [tableView dequeueReusableCellWithIdentifier:HIDDENDRANGECELLREUSEID];
    if (!cell) {
        cell = [[DJHiddenDrangeChartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HIDDENDRANGECELLREUSEID];
    }
    @weakify(self);
    cell.hiddenChartBtnClickBlock  = ^{
        @strongify(self);
        
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALE_W(200);
}

#pragma mark UI
-(void)initHiddenDangerChartUI{
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}
@end
