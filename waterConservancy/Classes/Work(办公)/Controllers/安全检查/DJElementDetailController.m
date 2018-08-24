//
//  DJElementDetailController.m
//  waterConservancy
//
//  Created by liu on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJElementDetailController.h"

#import "DJElementCheckItemViewModel.h"

#import "DJElementCheckitemCell.h"
#import "DJHiddenItemCell.h"

#import <UITableView+FDTemplateLayoutCell.h>

@interface DJElementDetailController ()
@property (nonatomic, strong) DJElementCheckItemViewModel *tableViewModel;

//SeactionHeadview
@property (nonatomic, strong)  UIView *seactionView;

/**  是否有检查项数据，存在为YES */
@property (nonatomic, assign) BOOL isCheckItem;
/**  检查项信息数组 */
@property (nonatomic, strong) NSArray *checkItemArray;
/**  是否有隐患信息数据，存在为YES */
@property (nonatomic, assign) BOOL isHiddenItem;
/**  检查项信息数组 */
@property (nonatomic, strong) NSArray *hiddenItemArray;
@end
static NSString *const ELEMENTDETAILCELLREUSEID = @"ELEMENTDETAILCELL";
static NSString *const ELEMENTHIDDENCELLREUSEID = @"ELEMENTHIDDENCELL";
@implementation DJElementDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"元素名称元素名称元素名称";
    
    [self initElementDetailUI];
    
    
    self.tableViewModel = [[DJElementCheckItemViewModel alloc]init];
    @weakify(self);
    [self.tableViewModel getElementCheckItemWithseGuid:self.seGuid successBlock:^(NSArray *modelArray) {
        @strongify(self);
        if (modelArray.count>0) {
            self.isCheckItem = YES;
            self.checkItemArray = [NSArray arrayWithArray:modelArray];
             [self.tableView reloadData];
        }
       
    }];
    [self.tableViewModel getElementHiddenWithGuid:self.Guid successBlock:^(NSArray *modelArray) {
        if (modelArray.count>0) {
            self.isHiddenItem = YES;
            self.hiddenItemArray = [NSArray arrayWithArray:modelArray];
            [self.tableView reloadData];
        }
    }];
    
}

#pragma mark tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.isCheckItem == YES) {
//        if (section == 0) {
//             return self.checkItemArray.count;
//        }else{
//        return 0;
//        }
//    }else if(self.isHiddenItem == YES){
//        if (section == 1) {
//            return  self.hiddenItemArray.count;
//        }else{
//            return 0;
//        }
//    }else{
//        return 0;
//    }
    if (section == 0) {
        return self.checkItemArray.count;
    }else if(section == 1){
        return self.hiddenItemArray.count;
    }else{
        return 0;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        DJElementCheckitemCell *cell = [tableView dequeueReusableCellWithIdentifier:ELEMENTDETAILCELLREUSEID];
        if (!cell) {
            cell = [[DJElementCheckitemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ELEMENTDETAILCELLREUSEID];
        }
        [cell initDataWithModel:self.checkItemArray indexPath:indexPath];
        
        return cell;
    }else  if (indexPath.section == 1) {
        DJHiddenItemCell *cell = [tableView dequeueReusableCellWithIdentifier:ELEMENTHIDDENCELLREUSEID];
        if (!cell) {
            cell = [[DJHiddenItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ELEMENTHIDDENCELLREUSEID];
        }
        [cell initHiddenItemDataWithModel:self.hiddenItemArray indexPath:indexPath];
        
        return cell;
    }else{
        return nil;
    }
    
  
    
    
  
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return  [tableView fd_heightForCellWithIdentifier:ELEMENTDETAILCELLREUSEID cacheByIndexPath:indexPath configuration:^(DJElementCheckitemCell* cell) {
            [cell initDataWithModel:self.checkItemArray indexPath:indexPath];
        }];
    }else if (indexPath.section == 1){
        return SCALE_W(150);
    }else{
        return 0;
    }

}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, SCALE_W(100))];
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCALE_W(20), 0, ScreenWidth-SCALE_W(40), SCALE_W(60))];
    [backImgV setImage:[UIImage imageNamed:@"flow1"]];
    [headView addSubview:backImgV];
    UILabel *SeactionLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCALE_W(20), SCALE_W(15), ScreenWidth, SCALE_W(45))];
    if (section == 0) {
         [SeactionLabel setText:@"检测项"];
    }else{
        [SeactionLabel setText:@"可能存在的隐患"];
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
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCALE_W(20), 0, ScreenWidth-SCALE_W(40), SCALE_W(40))];
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




#pragma mark UI
-(void)initElementDetailUI{
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
    [self.tableView registerClass:[DJElementCheckitemCell class] forCellReuseIdentifier:ELEMENTDETAILCELLREUSEID];
    [self.tableView registerClass:[DJHiddenItemCell class] forCellReuseIdentifier:ELEMENTHIDDENCELLREUSEID];
}




@end
