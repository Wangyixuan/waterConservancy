//
//  WLDangerPatrolCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLDangerPatrolCell.h"

@interface WLDangerPatrolCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *wiunNameLab;
@property (weak, nonatomic) IBOutlet UIButton *gradBtn;


@end

@implementation WLDangerPatrolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(WLDangerModel *)model{
    _model = model;
    self.nameLab.text = model.name;
    self.wiunNameLab.text = [NSString stringWithFormat:@"所属工程：%@",model.engName];
    if ([model.grad intValue]==2) {
        [self.gradBtn setTitle:@"重大危险源" forState:UIControlStateNormal];
        [self.gradBtn setBackgroundImage:[UIImage imageNamed:@"weixian_zhongda"] forState:UIControlStateNormal];
    }else{
        [self.gradBtn setTitle:@"一般危险源" forState:UIControlStateNormal];
        [self.gradBtn setBackgroundImage:[UIImage imageNamed:@"weixian_yiban"] forState:UIControlStateNormal];
    }
    
}


- (IBAction)patrolBtnClick:(id)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

@end
