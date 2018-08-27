//
//  WLTendPopView.m
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLTendPopView.h"

#define cellIdentifity @"TendPopCell"

@interface WLTendPopView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation WLTendPopView


-(void)awakeFromNib{
    [super awakeFromNib];

}

+(instancetype)creatTendPopViewWithData:(NSArray*)dataArr{
    WLTendPopView *popView = [[NSBundle mainBundle] loadNibNamed:@"WLTendPopView" owner:nil options:nil].firstObject;
    popView.dataArr = dataArr;
    popView.tableView.delegate = popView;
    popView.tableView.dataSource = popView;
    return popView;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"2113");
    [self removeFromSuperview];
    if (self.uploadHiddenBlock) {
        self.uploadHiddenBlock();
    }
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
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"1111";
    return cell;
}
- (IBAction)backBtnClick:(id)sender {
     [self removeFromSuperview];
}


@end
