//
//  WLReportAccidentCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/3.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLReportAccidentCell.h"
@interface WLReportAccidentCell()
@property (weak, nonatomic) IBOutlet UIButton *accGradBtn;
@property (weak, nonatomic) IBOutlet UILabel *accName;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UILabel *accWiunLab;
@property (weak, nonatomic) IBOutlet UILabel *accCollTimeLab;


@end

@implementation WLReportAccidentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnClick:(id)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(self.model);
    }
}

-(void)setModel:(WLAcciModel *)model{
    _model = model;
    self.accName.text = model.accName;
    self.accWiunLab.text = [NSString stringWithFormat:@"事故单位：%@",model.wiunName];
    self.accCollTimeLab.text = [NSString stringWithFormat:@"上报时间：%@",model.collTime];
    if ([model.repStat intValue]==1) {
        [self.commitBtn setTitle:@"补报" forState:UIControlStateNormal];
        [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"smallbtnBg_green"] forState:UIControlStateNormal];
    }else{
         [self.commitBtn setTitle:@"快报" forState:UIControlStateNormal];
        [self.commitBtn setBackgroundImage:[UIImage imageNamed:@"smallbtnBg"] forState:UIControlStateNormal];
    }
    if ([model.accGrad intValue]==1) {
        [self.accGradBtn setTitle:@"一般事故" forState:UIControlStateNormal];
        [self.accGradBtn setBackgroundImage:[UIImage imageNamed:@"shigu_yiban"] forState:UIControlStateNormal];
    }
    else if ([model.accGrad intValue]==2){
        [self.accGradBtn setTitle:@"较大事故" forState:UIControlStateNormal];
        [self.accGradBtn setBackgroundImage:[UIImage imageNamed:@"shigu_jiaoda"] forState:UIControlStateNormal];
    }
    else if ([model.accGrad intValue]==3){
        [self.accGradBtn setTitle:@"重大事故" forState:UIControlStateNormal];
        [self.accGradBtn setBackgroundImage:[UIImage imageNamed:@"shigu_zhongda"] forState:UIControlStateNormal];
    }
    else if ([model.accGrad intValue]==4){
        [self.accGradBtn setTitle:@"特大事故" forState:UIControlStateNormal];
        [self.accGradBtn setBackgroundImage:[UIImage imageNamed:@"shigu_teda"] forState:UIControlStateNormal];
    }
    
}
@end
