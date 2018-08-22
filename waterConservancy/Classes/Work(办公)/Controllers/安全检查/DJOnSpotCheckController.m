//
//  DJOnSpotCheckController.m
//  waterConservancy
//
//  Created by liu on 2018/8/16.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJOnSpotCheckController.h"
#import "DJOnSpotCheckCell.h"

@interface DJOnSpotCheckController ()

@end
static NSString *const ONSPOTCHECKCELLREUSEID = @"ONSPOTCHECKCELL";
@implementation DJOnSpotCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"现场检查";
    
    [self initOnSpotChecktUI];
    [self loadData];
}

-(void)loadData{
    
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/sins/bisSinsRecs/") Parmars:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } faild:^(NSError *error) {
        NSLog(@"error%@",error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJOnSpotCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:ONSPOTCHECKCELLREUSEID];
    if (!cell) {
        cell = [[DJOnSpotCheckCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ONSPOTCHECKCELLREUSEID];
    }
    @weakify(self);
    cell.onSpotCheckBtnClickBlock  = ^{
        @strongify(self);
        
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALE_W(200);
}

#pragma mark UI
-(void)initOnSpotChecktUI{
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}

@end
