//
//  YXDownListView.m
//  河掌治
//
//  Created by liu on 2018/3/26.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXDownListView.h"
#import "YXSaveUserCell.h"
#define  cellHeight SCALE_H(60)

@interface YXDownListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UIView   *contantV;

@property (nonatomic, weak) UITableView *downListTable;

//储存登陆成功的用户的数组
@property (nonatomic, strong) NSArray *userArray;

@end
@implementation YXDownListView


-(instancetype)init{
    if (self = [super init]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *userNameArray = [defaults objectForKey:@"loadUserName"];
        self.userArray = userNameArray.copy;
        [self setUI];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewHeight = self.userArray.count * cellHeight;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewHeight);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YXSaveUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YXSaveUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userCell"];
    }
    if (indexPath.row>=self.userArray.count) {
        return cell;
    }
    NSInteger tag = indexPath.row;
    NSDictionary *usepswDic = self.userArray[tag];
    NSString *str = usepswDic.allKeys.firstObject;
    [cell setDataWithStr:str btnTag:tag];
    
    @weakify(self);
    cell.delBlock = ^(NSInteger tag) {
        @strongify(self);
        //删除数组中的数据 重新刷新ui
        NSMutableArray *array = self.userArray.mutableCopy;
        [array removeObjectAtIndex:tag];
        self.userArray = array.copy;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.userArray forKey:@"loadUserName"];
        [defaults synchronize];
        [self.downListTable reloadData];
        CGFloat viewHeight = self.userArray.count * cellHeight;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(viewHeight);
        }];
        
    };
//    cell.textLabel.text =self.userArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 点击该行后，把该行的数据传出去
    if (indexPath.row>=self.userArray.count) {
        return;
    }
    NSDictionary *usepswDic = self.userArray[indexPath.row];
    NSString *userName = usepswDic.allKeys.firstObject;
    NSString *password = [usepswDic objectForKey:userName];
//    NSString *userName = self.userArray[indexPath.row];
    
    if (self.block) {
        self.block(userName,password);
    }
}




-(void)setUI{
    @weakify(self);
    [self.contantV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weak_self);
        make.width.mas_equalTo(weak_self.mas_width);
    }];
    
    [self.downListTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(weak_self.contantV);
        make.bottom.mas_equalTo(weak_self.contantV.mas_bottom);
    }];
   
    
}
-(UIView *)contantV{
    if (!_contantV) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        _contantV = view;
    }
    return _contantV;
}


-(UITableView *)downListTable{
    if (!_downListTable) {
        
        UITableView *tableView = [[UITableView alloc]init];
        [tableView registerClass:[YXSaveUserCell class] forCellReuseIdentifier:@"userCell"];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.contantV addSubview:tableView];
        _downListTable = tableView;
    }
    return _downListTable;
}

@end
