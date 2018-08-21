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
    [self loadGIDData];
}
-(void)loadGIDData{
    //根据用户ID 获取元素GID
    NSDictionary *param = @{@"legPersGuid":@"10bd94958c5c480e8177c043881e0212"};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/se/wiun/bisSeWiunDecos/") Parmars:param success:^(id responseObject) {
        NSLog(@"1%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *dataArr = [respDic objectForKey:@"data"];
        NSMutableArray *gIDArr = [NSMutableArray array];
        for (NSDictionary *dic in dataArr) {
            NSString *seWiunGuid = [dic stringForKey:@"seWiunGuid" defaultValue:@""];
            [gIDArr addObject:seWiunGuid];
        }
        [self loadSeWiunsWithGID:gIDArr];
    } faild:^(NSError *error) {
        NSLog(@"error1%@",error);
    }];
}

-(void)loadSeWiunsWithGID:(NSArray*)GIDArr{
    NSString *IDStr = [GIDArr firstObject];
        NSDictionary *param = @{@"guid":IDStr};
        [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/se/bisSeWiuns") Parmars:param success:^(id responseObject) {
            NSLog(@"2%@",responseObject);
            
        } faild:^(NSError *error) {
            NSLog(@"error2%@",error);
        }];

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
