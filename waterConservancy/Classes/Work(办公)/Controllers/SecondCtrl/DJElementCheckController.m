//
//  DJElementCheckController.m
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJElementCheckController.h"
#import "DJElementCheckCell.h"

@interface DJElementCheckController ()

@end
static NSString *const ELEMENTCHECKCELLREUSEID = @"ELEMENTCHECKCELL";
@implementation DJElementCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"元素检查";
    [self initElementChcekUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJElementCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:ELEMENTCHECKCELLREUSEID];
    if (!cell) {
        cell = [[DJElementCheckCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ELEMENTCHECKCELLREUSEID];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALE_W(200);
}

#pragma mark UI
-(void)initElementChcekUI{
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}

@end
