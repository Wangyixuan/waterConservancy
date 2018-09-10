//
//  WLPatrolRecordDetailController.m
//  waterConservancy
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLPatrolRecordDetailController.h"
#import "WLRecordInfoCell.h"
#import "WLHiddAdviseCell.h"

#define cellInfoIdentifity @"WLRecordInfoCell"
#define cellAdviseIdentifity @"WLHiddAdviseCell"

@interface WLPatrolRecordDetailController ()

@end

@implementation WLPatrolRecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"巡查记录详情";
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellInfoIdentifity bundle:nil] forCellReuseIdentifier:cellInfoIdentifity];
    [self.tableView registerNib:[UINib nibWithNibName:cellAdviseIdentifity bundle:nil] forCellReuseIdentifier:cellAdviseIdentifity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 203;
    }
    return 140;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        WLRecordInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfoIdentifity forIndexPath:indexPath];
        cell.model = self.model;
        return cell;
    }else{
        WLHiddAdviseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellAdviseIdentifity forIndexPath:indexPath];
        if (indexPath.section==1) {
            cell.contentText.text = self.model.probFound;
        }else{
            cell.contentText.text = self.model.treaMeas;
        }
        return cell;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SCALE_W(100))];
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, ScreenWidth-10, SCALE_W(60))];
    [backImgV setImage:[UIImage imageNamed:@"flow1"]];
    [headView addSubview:backImgV];
    
    UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(30), SCALE_W(22), SCALE_W(5), SCALE_W(30))];
    line1View.backgroundColor = FColor(64.0, 114.0, 216.0, 1.0);
    [backImgV addSubview:line1View];
    
    UILabel *SeactionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCALE_W(45), SCALE_W(15), ScreenWidth, SCALE_W(45))];
    if (section==0) {
        [SeactionLabel setText:@"巡查信息"];
    }else if (section==1){
        [SeactionLabel setText:@"发现问题"];
    }else if (section==2){
        [SeactionLabel setText:@"处理措施"];
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
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, ScreenWidth-10, SCALE_W(40))];
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
