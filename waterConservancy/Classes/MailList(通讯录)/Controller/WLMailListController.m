//
//  WLMailListController.m
//  waterConservancy
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLMailListController.h"
#import "WLMailListCell.h"
#import "WLContactDetailController.h"
#import "WLSearchContactController.h"
#import "WLPersonModel.h"

#define cellIdentifity @"WLMailListCell"

@interface WLMailListController ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, weak) UIButton *uploadBtn;
@end

@implementation WLMailListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    @weakify(self)
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"刷新通讯录" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"commitBtnBg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadMailListData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.uploadBtn = btn;
    [self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weak_self.view).offset(-15);
        make.height.mas_equalTo(SCALE_W(71));
        make.width.mas_equalTo(SCALE_W(520));
        make.centerX.mas_equalTo(weak_self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weak_self.view);
        make.bottom.mas_equalTo(weak_self.uploadBtn.mas_top).offset(-15);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.leftBarButtonItem = nil;
  
    NSArray *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"mailListData"];
    self.dataArr = [NSMutableArray array];
    if (data.count>0) {
        [self locData:data];
    }else{        
        [self loadMailListData];
    }
}

-(void)locData:(NSArray*)data{
    for (NSDictionary*dic in data) {
        WLPersonModel *model = [[WLPersonModel alloc]initWithData:dic];
        [self.dataArr addObject:model];
    }
    [self.tableView reloadData];
}

-(void)search{
    WLSearchContactController *search = [[WLSearchContactController alloc]init];
    [self.navigationController pushViewController:search animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadMailListData{
    [SVProgressHUD show];
    [[YXNetTool shareTool] SOAPData:@"http://192.168.1.11:9080/uams/ws/uumsext/UserExt?wsdl" orgGuid:@"21260E691D454685B61086E7F2074B71" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *respArr = (NSArray*)responseObject;
        for (NSDictionary*dic in respArr) {
            WLPersonModel *model = [[WLPersonModel alloc]initWithData:dic];
            [self.dataArr addObject:model];
        }
        [[NSUserDefaults standardUserDefaults] setObject:respArr forKey:@"mailListData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLMailListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
        if (self.dataArr.count>indexPath.row) {
            cell.model = [self.dataArr objectAtIndex:indexPath.row];
        }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WLContactDetailController *detail = WCViewControllerOfMainSB(@"WLContactDetailController");
    if (self.dataArr.count>indexPath.row) {
        detail.model = [self.dataArr objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
}
@end
