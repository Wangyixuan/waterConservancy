//
//  DJItemCheckController.m
//  waterConservancy
//
//  Created by liu on 2018/8/24.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJItemCheckController.h"

@interface DJItemCheckController ()

@end

@implementation DJItemCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initItemCheckUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALE_W(200);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SCALE_W(100))];
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCALE_W(20), 0, ScreenWidth-SCALE_W(40), SCALE_W(60))];
    [backImgV setImage:[UIImage imageNamed:@"flow1"]];
    [headView addSubview:backImgV];
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(30), SCALE_W(22), SCALE_W(6), SCALE_W(30))];
    line1View.backgroundColor = FColor(64.0, 114.0, 216.0, 1.0);
    [backImgV addSubview:line1View];
    
    UILabel *SeactionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(15), ScreenWidth, SCALE_W(45))];
    [SeactionLabel setText:@"请选择排查工程"];
    [SeactionLabel setTextColor:FColor(64.0, 114.0, 216.0, 1.0)];
    [SeactionLabel setFont:YX26Font];
    [backImgV addSubview:SeactionLabel];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(60), ScreenWidth-SCALE_W(80), 1)];
    lineView.backgroundColor = GrayLineColor;
    [backImgV addSubview:lineView];
    return headView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]init];
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCALE_W(20), 0, ScreenWidth-SCALE_W(40), SCALE_W(40))];
    [backImgV setImage:[UIImage imageNamed:@"flow3"]];
    [footView addSubview:backImgV];
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCALE_W(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return SCALE_W(40);
}



#pragma mark UI
-(void)initItemCheckUI{
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}



@end
