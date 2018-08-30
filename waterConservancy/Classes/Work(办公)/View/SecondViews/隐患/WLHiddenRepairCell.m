//
//  WLHiddenRepairCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddenRepairCell.h"

@interface WLHiddenRepairCell()

@property (weak, nonatomic) IBOutlet UIButton *gradBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *engNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation WLHiddenRepairCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(DJHiddenDangerModel *)model{
    _model = model;
    self.nameLab.text = model.hiddName;
    self.timeLab.text = [NSString stringWithFormat:@"上报时间：%@",model.collTime];
    self.engNameLab.text = [NSString stringWithFormat:@"所属工程：%@",model.hiddProjectName];
    NSString *hidGrad = model.hiddGrad;
    //1一般隐患 2重大隐患
    if ([hidGrad integerValue]==2) {
        [self.gradBtn setTitle:@"重大隐患" forState:UIControlStateNormal];
        [self.gradBtn setBackgroundImage:[UIImage imageNamed:@"yuansu_zhongda"] forState:UIControlStateNormal];
    }else{
        [self.gradBtn setTitle:@"一般隐患" forState:UIControlStateNormal];
        [self.gradBtn setBackgroundImage:[UIImage imageNamed:@"yuansu_yiban"] forState:UIControlStateNormal];
    }
}

- (IBAction)repairBtnClick:(id)sender {
    if (self.actionBlock) {
        self.actionBlock(self.model.guid);
    }
}
@end
