//
//  DJHiddenDrangeChartController.m
//  waterConservancy
//
//  Created by liu on 2018/8/16.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJHiddenDrangeChartController.h"
#import "DJHiddenDrangeChartCell.h"

@interface DJHiddenDrangeChartController ()

@end
static NSString *const HIDDENDRANGECELLREUSEID = @"HIDDENDRANGECELL";

@implementation DJHiddenDrangeChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患报表";
    
    [self initHiddenDangerChartUI];
    
    NSDictionary *parmars = @{@"hiddStat":@"1",
                              @"orgGuid":@"3CC7C07191394F959D55F098B23281F6",
                              };
    [[YXNetTool shareTool]getRequestWithURL:@"http://192.168.1.8:8080/sjjk/v1/bis/obj/objHidds/" Parmars:parmars success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } faild:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
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
