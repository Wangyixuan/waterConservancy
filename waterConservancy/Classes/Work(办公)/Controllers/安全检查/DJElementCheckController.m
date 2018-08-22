//
//  DJElementCheckController.m
//  waterConservancy
//
//  Created by liu on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJElementCheckController.h"
#import "DJElementCheckCell.h"

#import "DJElemnetModel.h"
#import "DJOrgElementModel.h"

@interface DJElementCheckController ()
/** 原始列表数据 总表 */
@property (nonatomic, strong) NSArray *elementListArray;
/** 当前组织下elementid */
@property (nonatomic, strong) NSMutableArray *elementStaListArray;

/** 单位元素model  存元素状态和guid */
@property (nonatomic, strong) NSArray *orgEModelArray;
@end
static NSString *const ELEMENTCHECKCELLREUSEID = @"ELEMENTCHECKCELL";
@implementation DJElementCheckController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"元素检查";
    //页面布局
    [self initElementChcekUI];
    //获得元素列表
    [self GetElementList];
  
    
    
    
    
    
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.elementStaListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJElementCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:ELEMENTCHECKCELLREUSEID];
    if (!cell) {
        cell = [[DJElementCheckCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ELEMENTCHECKCELLREUSEID];
    }
    DJElemnetModel *model = self.elementListArray[indexPath.row];
    [cell setElementDataWithModel:model];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALE_W(200);
}

#pragma mark Net
//获得元素列表
-(void)GetElementList{
    //创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    @weakify(self);
    dispatch_queue_t queue = dispatch_queue_create("com.dj", NULL);
    
    //获得元素的seguid 和 状态
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSString *urlStr = [NSString stringWithFormat:@"sjjk/v1/bis/se/bisSeWiuns/?orgGuid=%@",ORGID];
        [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(urlStr)  Parmars:nil success:^(id responseObject) {
            @strongify(self);
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            self.orgEModelArray = [NSArray modelArrayWithClass:[DJOrgElementModel class] json:dataArray];
            dispatch_semaphore_signal(semaphore);
        } faild:^(NSError *error) {
            NSLog(@"%@",error);
             dispatch_semaphore_signal(semaphore);
        }];
    });
   
    //获得元素的名称
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/se/bisSeChits/")  Parmars:nil success:^(id responseObject) {
            @strongify(self);
          
            NSArray *dataArray = [responseObject objectForKey:@"data"];
            self.elementListArray = [NSArray modelArrayWithClass:[DJElemnetModel class] json:dataArray];
          dispatch_semaphore_signal(semaphore);
        } faild:^(NSError *error) {
            NSLog(@"%@",error);
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
   //拼接数据
    dispatch_async(queue, ^{
         dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self.elementStaListArray removeAllObjects];
        for (DJOrgElementModel *orgModel in self.orgEModelArray) {
            DJOrgElementModel *model = [[DJOrgElementModel alloc]init];
            [model setSeGuid:@"B8B9E3C0294A451E8C86A82B0BEF2DE0"];
            [model setSeStat:@"3"];
            for (DJElemnetModel *eleModel in self.elementListArray) {
                NSLog(@"%@",eleModel.seGuid);
                if ([eleModel.seGuid isEqualToString:model.seGuid]) {
                    [eleModel setSeStat:model.seStat];
                    [self.elementStaListArray addObject:eleModel];
                }
            }
        }
        NSLog(@"%@",self.elementStaListArray);
      
        dispatch_semaphore_signal(semaphore);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
//
     });

}



#pragma mark UI
-(void)initElementChcekUI{
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}

-(NSArray *)elementListArray{
    if (!_elementListArray) {
        NSArray *elementListArray = [NSArray array];
        _elementListArray = elementListArray;
    }
    return _elementListArray;
}
-(NSMutableArray *)elementStaListArray{
    if (!_elementStaListArray) {
        NSMutableArray *elementStaListArray = [NSMutableArray array];
        _elementStaListArray = elementStaListArray;
    }
    return _elementStaListArray;
}
-(NSArray *)orgEModelArray{
    if (!_orgEModelArray) {
        NSArray *orgEModelArray = [NSArray array];
        _orgEModelArray = orgEModelArray;
    }
    return _orgEModelArray;
}

@end
