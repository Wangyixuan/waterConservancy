//
//  WLUploadHiddenController.m
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLUploadHiddenController.h"
#import "WLUploadHiddenInfoCell.h"
#import "WLUploadDetailInfoCell.h"

#define cellInfoIdentifity @"WLUploadHiddenInfoCell"
#define cellDetailIdentifity @"WLUploadDetailInfoCell"

@interface WLUploadHiddenController ()
@property (nonatomic, weak) UIButton *commitBtn;
@end

@implementation WLUploadHiddenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患上报";
    // Do any additional setup after loading the view.
    [self setUpSubViews];
}

-(void)setUpSubViews{
     @weakify(self);
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weak_self.view).offset(-15);
        make.height.mas_equalTo(SCALE_W(71));
        make.width.mas_equalTo(SCALE_W(520));
        make.centerX.mas_equalTo(weak_self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.tableView];
   
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(weak_self.view);
        make.bottom.mas_equalTo(weak_self.commitBtn.mas_top).offset(-15);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellInfoIdentifity bundle:nil] forCellReuseIdentifier:cellInfoIdentifity];
    [self.tableView registerClass:[WLUploadDetailInfoCell class] forCellReuseIdentifier:cellDetailIdentifity];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 150;
    }
    return 375;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        WLUploadHiddenInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfoIdentifity forIndexPath:indexPath];
//        cell.model = self.model;
        return cell;
    }
    else{
        WLUploadDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetailIdentifity forIndexPath:indexPath];
        if (!cell) {
            cell = [[WLUploadDetailInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailIdentifity];
        }
        return cell;
    }
}

-(UIButton*)commitBtn{
    if (!_commitBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"确认上报" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"commitBtnBg"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:YX36Font];
        [self.view addSubview:btn];
        _commitBtn = btn;
    }
    return _commitBtn;
}
-(void)commitBtnClick{
    
}
@end
