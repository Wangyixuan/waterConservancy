//
//  WLHiddenDetailController.m
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddenDetailController.h"

#import "WLHiddDetailPerInfoCell.h"
#import "WLHiddAdviseCell.h"
#import "WLHiddSuperviseCell.h"
#import "WLHiddRecordCell.h"
#import "WLHiddRepairSchemeCell.h"
#import "WLHiddDetailCell.h"

#define cellPerInfoIdentifity @"WLHiddDetailPerInfoCell"
#define cellAdviseIdentifity @"WLHiddAdviseCell"
#define cellSuperviseIdentifity @"WLHiddSuperviseCell"
#define cellRecordIndentifity @"WLHiddRecordCell"
#define cellSchemeIdentifity @"WLHiddRepairSchemeCell"
#define cellDetailIdentifity @"WLHiddDetailCell"



@interface WLHiddenDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WLHiddenDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.hiddName;
    // Do any additional setup after loading the view.
    [self loadData];
    [self initUI];
    
}

-(void)initUI{
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellPerInfoIdentifity bundle:nil] forCellReuseIdentifier:cellPerInfoIdentifity];
    [self.tableView registerNib:[UINib nibWithNibName:cellAdviseIdentifity bundle:nil] forCellReuseIdentifier:cellAdviseIdentifity];
    [self.tableView registerNib:[UINib nibWithNibName:cellSuperviseIdentifity bundle:nil] forCellReuseIdentifier:cellSuperviseIdentifity];
    [self.tableView registerNib:[UINib nibWithNibName:cellRecordIndentifity bundle:nil] forCellReuseIdentifier:cellRecordIndentifity];
    [self.tableView registerNib:[UINib nibWithNibName:cellSchemeIdentifity bundle:nil] forCellReuseIdentifier:cellSchemeIdentifity];
    [self.tableView registerNib:[UINib nibWithNibName:cellDetailIdentifity bundle:nil] forCellReuseIdentifier:cellDetailIdentifity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    NSDictionary*param = @{@"hiddGuid":self.model.guid};
    //隐患排查信息
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/hidd/bisHiddInves/") Parmars:param success:^(id responseObject) {
        NSLog(@"1-%@",responseObject);
    } faild:^(NSError *error) {
        
    }];
    //整改进度
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/hidd/rect/bisHiddRectProgs/") Parmars:param success:^(id responseObject) {
         NSLog(@"2-%@",responseObject);
    } faild:^(NSError *error) {
        
    }];
    //隐患督办信息
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/maj/bisMajHiddSups/") Parmars:param success:^(id responseObject) {
         NSLog(@"3-%@",responseObject);
    } faild:^(NSError *error) {
        
    }];
    //隐患整改信息
    [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/hidd/rect/selectBisHiddRectImplWithAttOrgBase/") Parmars:param success:^(id responseObject) {
         NSLog(@"4-%@",responseObject);
    } faild:^(NSError *error) {
        
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==5 || section==6) {
        return 2;
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==3) {
        return 95;
    }else if (indexPath.section==5 || indexPath.section==6){
        return 140;
    }else if (indexPath.section==4){
        return 315;
    }else if (indexPath.section==0){
        return 296;
    }
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        WLHiddDetailPerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellPerInfoIdentifity forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==3){
        WLHiddSuperviseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSuperviseIdentifity forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==5 || indexPath.section==6){
        WLHiddRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellRecordIndentifity forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==4){
        WLHiddRepairSchemeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSchemeIdentifity forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section==0){
        WLHiddDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetailIdentifity forIndexPath:indexPath];
        return cell;
    }
    WLHiddAdviseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellAdviseIdentifity forIndexPath:indexPath];
    return cell;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section!=2) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SCALE_W(100))];
        UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, ScreenWidth-10, SCALE_W(60))];
        [backImgV setImage:[UIImage imageNamed:@"flow1"]];
        [headView addSubview:backImgV];
        UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(30), SCALE_W(22), SCALE_W(5), SCALE_W(30))];
        line1View.backgroundColor = FColor(64.0, 114.0, 216.0, 1.0);
        [backImgV addSubview:line1View];
        
        UILabel *SeactionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCALE_W(45), SCALE_W(15), ScreenWidth, SCALE_W(45))];
        if (section == 0) {
            [SeactionLabel setText:@"隐患详情"];
        }
        else if (section==1){
            [SeactionLabel setText:@"建议整改措施"];
        }
        else if (section==3){
            [SeactionLabel setText:@"督办记录"];
        }
        else if (section==4){
            [SeactionLabel setText:@"整改方案"];
        }
        else if (section==5){
            [SeactionLabel setText:@"整改记录"];
        }
        else if (section==6){
            [SeactionLabel setText:@"销号记录"];
        }
        
        [SeactionLabel setTextColor:FColor(64.0, 114.0, 216.0, 1.0)];
        [SeactionLabel setFont:YX26Font];
        [backImgV addSubview:SeactionLabel];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(60), ScreenWidth-SCALE_W(80), 1)];
        lineView.backgroundColor = GrayLineColor;
        [backImgV addSubview:lineView];
        return headView;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section!=2) {
        UIView *footView = [[UIView alloc]init];
        UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, ScreenWidth-10, SCALE_W(40))];
        [backImgV setImage:[UIImage imageNamed:@"flow3"]];
        [footView addSubview:backImgV];
        return footView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section!=2) {
        return SCALE_W(60);
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section!=2) {
        return SCALE_W(40);
    }
    return 0;
}

@end
