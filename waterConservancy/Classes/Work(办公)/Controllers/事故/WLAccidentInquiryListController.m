//
//  WLAccidentInquiryListController.m
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAccidentInquiryListController.h"
#import "WLAccidentInquiryCell.h"

#define cellIdentifity @"WLAccidentInquiryCell"

@interface WLAccidentInquiryListController ()

@end

@implementation WLAccidentInquiryListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"事故查询";
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUI{
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLAccidentInquiryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    return cell;
}

@end
