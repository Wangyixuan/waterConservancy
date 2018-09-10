//
//  WLDangerDetailController.m
//  waterConservancy
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLDangerDetailController.h"
#import "WLDangerInfoCell.h"
#import "WLPatrolRecordCell.h"
#import "WLHiddAdviseCell.h"
#import "WLPatrolRecordController.h"
#import "WLPatrolRecordModel.h"

#define cellInfoIdentifity @"WLDangerInfoCell"
#define cellRecordIdentifity @"WLPatrolRecordCell"
#define cellAdviseIdentifity @"WLHiddAdviseCell"

@interface WLDangerDetailController ()
@property (nonatomic, strong) NSMutableArray *recordArr;
@end

@implementation WLDangerDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.name;
    self.recordArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellInfoIdentifity bundle:nil] forCellReuseIdentifier:cellInfoIdentifity ];
    [self.tableView registerNib:[UINib nibWithNibName:cellRecordIdentifity bundle:nil] forCellReuseIdentifier:cellRecordIdentifity ];
    [self.tableView registerNib:[UINib nibWithNibName:cellAdviseIdentifity bundle:nil] forCellReuseIdentifier:cellAdviseIdentifity ];
    [self loadDangerDeatil];
    [self loadPatrolRecordData];
}

-(void)loadDangerDeatil{
    NSDictionary *param = @{@"guid":self.model.guid,@"hazGuid":self.model.guid};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/selectHazInfoDetails/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *respArr = [respDic objectForKey:@"data"];
        for (NSDictionary *dic in respArr) {
            self.model.orgName = [dic stringForKey:@"wiunName" defaultValue:@""];
        }
        [self.tableView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

-(void)loadPatrolRecordData{
    NSDictionary *param = @{@"hazGuid":self.model.guid};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/haz/bisHazPatRecs/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        NSArray *respArr = [respDic objectForKey:@"data"];
        if (respArr.count>0) {
            for (NSDictionary *dic in respArr) {
                WLPatrolRecordModel *model = [[WLPatrolRecordModel alloc]initWithData:dic];
                [self.recordArr addObject:model];
            }
        }
        [self.tableView reloadData];
    } faild:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 300;
    }else if (indexPath.section==1||indexPath.section==2){
        return 140;
    }
    else{
        return 60;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        WLDangerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfoIdentifity forIndexPath:indexPath];
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section==1||indexPath.section==2){
        WLHiddAdviseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellAdviseIdentifity forIndexPath:indexPath];
        if (indexPath.section==1) {
            cell.contentText.text = self.model.harmRisk;
        }else{
            cell.contentText.text = self.model.moniPrec;
        }
        return cell;
    }
    else{
        WLPatrolRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellRecordIdentifity forIndexPath:indexPath];
        cell.recordCountLab.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.recordArr.count];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
//        if (self.recordArr.count>0) {
            WLPatrolRecordController *record = [[WLPatrolRecordController alloc]init];
            record.dataArr = self.recordArr;
            [self.navigationController pushViewController:record animated:YES];
//        }
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
         [SeactionLabel setText:@"风险源信息"];
    }else if (section==1){
         [SeactionLabel setText:@"可能造成的危害风险"];
    }else if (section==2){
         [SeactionLabel setText:@"监控防范措施"];
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
    if (section!=3) {
        return SCALE_W(60);
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section!=3) {
        return SCALE_W(40);
    }
    return 0;
}
@end
