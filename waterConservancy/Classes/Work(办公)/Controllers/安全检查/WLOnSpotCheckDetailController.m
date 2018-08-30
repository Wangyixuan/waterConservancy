//
//  WLOnSpotCheckDetailController.m
//  waterConservancy
//
//  Created by mac on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLOnSpotCheckDetailController.h"
#import "WLCheckInfoCell.h"
#import "WLHiddenCell.h"
#import "DJHiddenDangerModel.h"
#import "WLEngListCell.h"

#define InfoCellIdentifity @"WLCheckInfoCell"
#define RecordCellIdentifity @"WLEngListCell"
#define HiddenItemCellIdentifity @"WLHiddenCell"

@interface WLOnSpotCheckDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *recordArr;
@property (nonatomic, strong) NSMutableArray *hiddArr;
@end

@implementation WLOnSpotCheckDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"检查记录详情";
    // Do any additional setup after loading the view.
    self.recordArr = [NSMutableArray array];
    self.hiddArr = [NSMutableArray array];
    
    [self loadHiddData];
   
    [self setUpSubViews];
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
    [self.tableView registerNib:[UINib nibWithNibName:InfoCellIdentifity bundle:nil] forCellReuseIdentifier:InfoCellIdentifity];
    [self.tableView registerNib:[UINib nibWithNibName:HiddenItemCellIdentifity bundle:nil] forCellReuseIdentifier:HiddenItemCellIdentifity];
     [self.tableView registerNib:[UINib nibWithNibName:RecordCellIdentifity bundle:nil] forCellReuseIdentifier:RecordCellIdentifity];
}

-(void)loadRecordData{
    NSString *str = @"2018-10-10 检查轨迹";
    [self.recordArr addObject:str];
    [self.recordArr addObject:str];
    [self.recordArr addObject:str];
   [self.tableView reloadData];
}

-(void)loadHiddData{
    NSDictionary *param = @{@"orgGuid":WLShareUserManager.orgID,@"inspRecGuid":self.model.sinsGuidStr};
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/objHidds/") Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary*)responseObject;
        NSArray *respArr = [dic objectForKey:@"data"];
        for (NSDictionary *dic in respArr) {
            DJHiddenDangerModel *model = [[DJHiddenDangerModel alloc] initWithDic:dic];
            [self.hiddArr addObject:model];
        }
        [self loadRecordData];
 
    } faild:^(NSError *error) {
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 130;
        return self.tableView.rowHeight;
    }else if (indexPath.section==2){
        return 67;
    }
    return 60;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        WLCheckInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:InfoCellIdentifity forIndexPath:indexPath];
        cell.model = self.model;
        return cell;
    }
    else if (indexPath.section==1){
        WLEngListCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordCellIdentifity forIndexPath:indexPath];
        if (self.recordArr.count>indexPath.row) {
            cell.engNameLab.text = [self.recordArr objectAtIndex:indexPath.row];
        }
        return cell;
    }else{
        WLHiddenCell *cell = [tableView dequeueReusableCellWithIdentifier:HiddenItemCellIdentifity forIndexPath:indexPath];
        if (self.hiddArr.count>indexPath.row) {
             cell.model = [self.hiddArr objectAtIndex:indexPath.row];
        }
        return  cell;
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
    if (section == 0) {
        [SeactionLabel setText:@"检测记录信息"];
    }else if (section==1)
    {
        [SeactionLabel setText:@"检查轨迹"];
    }else{
        [SeactionLabel setText:@"隐患列表"];
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
