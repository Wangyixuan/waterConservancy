//
//  WLSearchContactController.m
//  waterConservancy
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLSearchContactController.h"
#import "WLSearchView.h"
#import "WLMailListCell.h"
#import "WLContactDetailController.h"

#define cellIdentifity @"WLMailListCell"

@interface WLSearchContactController ()
@property (nonatomic, strong) WLSearchView *searchView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *resultArr;
@end

@implementation WLSearchContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    self.dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"mailListData"];
    self.resultArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    WLSearchView *searchView = [WLSearchView addSearchView];
    searchView.frame = CGRectMake(0, 0, SCALE_W(260), 35);
    self.navigationItem.titleView = searchView;
    self.searchView = searchView;
    
    [self showSearchResult];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchKeyWord) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)showSearchResult{
    [self.view addSubview:self.tableView];
    @weakify(self)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:cellIdentifity bundle:nil] forCellReuseIdentifier:cellIdentifity];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WLMailListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity forIndexPath:indexPath];
    if (self.resultArr.count>indexPath.row) {
        cell.model = [self.resultArr objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WLContactDetailController *detail = WCViewControllerOfMainSB(@"WLContactDetailController");
    if (self.resultArr.count>indexPath.row) {
        detail.model = [self.resultArr objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchKeyWord{
    NSString *keyStr = self.searchView.keyWordText.text;
    [self.resultArr removeAllObjects];
    if (keyStr.length==0) {
       
        [self.tableView reloadData];
    }else{
        for (NSDictionary*dic in self.dataArr) {
            NSString *name = [dic stringForKey:@"persName" defaultValue:@""];
            NSString *tel = [dic stringForKey:@"mobilenumb" defaultValue:@""];
            NSMutableString *nameChar = [name mutableCopy];
            
            CFStringTransform((__bridge CFMutableStringRef)nameChar, NULL, kCFStringTransformMandarinLatin, NO);
            CFStringTransform((__bridge CFMutableStringRef)nameChar, NULL, kCFStringTransformStripCombiningMarks, NO);
            NSString *namePinyin = nameChar;
            if ([name containsString:keyStr] || [tel containsString:keyStr] || [namePinyin containsString:keyStr] ) {
                
                WLPersonModel *model = [[WLPersonModel alloc]initWithData:dic];
                [self.resultArr addObject:model];
            }
        }
        [self.tableView reloadData];
    }
}

@end
