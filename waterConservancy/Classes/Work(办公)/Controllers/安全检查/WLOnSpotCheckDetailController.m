//
//  WLOnSpotCheckDetailController.m
//  waterConservancy
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLOnSpotCheckDetailController.h"
#import "DJElementCheckCell.h"



@interface WLOnSpotCheckDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WLOnSpotCheckDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"检查记录详情";
    // Do any additional setup after loading the view.
    [self loadHiddData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpSubViews{
    
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
//    [self.tableView registerClass:[DJElementCheckitemCell class] forCellReuseIdentifier:ELEMENTDETAILCELLREUSEID];
    
}

-(void)loadHiddData{
    NSDictionary *param = @{@"orgGuid":WLShareUserManager.orgID,@"inspRecGuid":self.model.sinsGuidStr};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/objHidds/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
    } faild:^(NSError *error) {
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJElementCheckCell *cell = [[DJElementCheckCell alloc]init];
    return cell;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SCALE_W(100))];
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCALE_W(20), 0, ScreenWidth-SCALE_W(40), SCALE_W(60))];
    [backImgV setImage:[UIImage imageNamed:@"flow1"]];
    [headView addSubview:backImgV];
    UILabel *SeactionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(15), ScreenWidth, SCALE_W(45))];
    if (section == 0) {
        [SeactionLabel setText:@"检测项"];
    }else{
        [SeactionLabel setText:@"可能存在的隐患"];
    }
    
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

@end
