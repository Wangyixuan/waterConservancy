//
//  WLAccidentDetailController.m
//  waterConservancy
//
//  Created by mac on 2018/9/4.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAccidentDetailController.h"
#import "WLAcciDeailCell.h"
#import "WLAcciInfoCell.h"
#import "WLAcciMoreInfoCell.h"

#define cellDetailIdentifity @"WLAcciDeailCell"
#define cellInfoIdentifity @"WLAcciInfoCell"
#define cellMoreIdentifity @"WLAcciMoreInfoCell"

@interface WLAccidentDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WLAccidentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellDetailIdentifity bundle:nil] forCellReuseIdentifier:cellDetailIdentifity ];
    [self.tableView registerNib:[UINib nibWithNibName:cellInfoIdentifity bundle:nil] forCellReuseIdentifier:cellInfoIdentifity ];
    [self.tableView registerNib:[UINib nibWithNibName:cellMoreIdentifity bundle:nil] forCellReuseIdentifier:cellMoreIdentifity ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)loadEngNameWithEngGuid{
    if (self.model.wiunGuid.length>0) {
        NSDictionary *param = @{@"guid":self.model.wiunGuid};
        [[YXNetTool shareTool] getRequestWithURL:YXNetAddress(@"sjjk/v1/jck/obj/objEngs/") Parmars:param success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary *respDic = (NSDictionary*)responseObject;
            NSArray *respArr = [respDic objectForKey:@"data"];
            for (NSDictionary *dic in respArr) {
                self.model.wiunName = [dic stringForKey:@"engName" defaultValue:@"无"];
            }
            [self.tableView reloadData];
        } faild:^(NSError *error) {
            
        }];
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else{
        return 3;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 375;
        }else{
            return 90;
        }
    }else{
        return 50;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            WLAcciDeailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetailIdentifity forIndexPath:indexPath];
            cell.model = self.model;
            return cell;
        }else{
            WLAcciInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfoIdentifity forIndexPath:indexPath];
            cell.model = self.model;
            return cell;
        }
    }else{
        WLAcciMoreInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMoreIdentifity forIndexPath:indexPath];
        cell.model = self.model;
        return cell;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SCALE_W(100))];
        UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, ScreenWidth-10, SCALE_W(60))];
        [backImgV setImage:[UIImage imageNamed:@"flow1"]];
        [headView addSubview:backImgV];
    
        if (section == 0) {
            UIView *line1View = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(30), SCALE_W(22), SCALE_W(5), SCALE_W(30))];
            line1View.backgroundColor = FColor(64.0, 114.0, 216.0, 1.0);
            [backImgV addSubview:line1View];
            
            UILabel *SeactionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCALE_W(45), SCALE_W(15), ScreenWidth, SCALE_W(45))];
            [SeactionLabel setText:@"事故详情"];
            [SeactionLabel setTextColor:FColor(64.0, 114.0, 216.0, 1.0)];
            [SeactionLabel setFont:YX26Font];
            [backImgV addSubview:SeactionLabel];
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(60), ScreenWidth-SCALE_W(80), 1)];
            lineView.backgroundColor = GrayLineColor;
            [backImgV addSubview:lineView];
        }

        return headView;
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
    
    return SCALE_W(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return SCALE_W(40);
    }
    return 0;
}
@end
