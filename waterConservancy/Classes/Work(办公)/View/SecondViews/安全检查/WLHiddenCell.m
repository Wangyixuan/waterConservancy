//
//  WLHiddenCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddenCell.h"
@interface WLHiddenCell()
@property (weak, nonatomic) IBOutlet UIButton *hiddenGradBtn;
@property (weak, nonatomic) IBOutlet UILabel *hiddenNameLab;
@property (weak, nonatomic) IBOutlet UILabel *hiddenTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *hiddenProjectLab;


@end

@implementation WLHiddenCell

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
    self.hiddenNameLab.text = model.hiddName;
    self.hiddenTimeLab.text = model.collTime;
    self.hiddenProjectLab.text = [NSString stringWithFormat:@"所属工程：%@",model.hiddProjectName];
    NSString *hidGrad = model.hiddGrad;
    //1一般隐患 2重大隐患
    if ([hidGrad integerValue]==2) {
        [self.hiddenGradBtn setTitle:@"重大隐患" forState:UIControlStateNormal];
        [self.hiddenGradBtn setBackgroundImage:[UIImage imageNamed:@"yuansu_zhongda"] forState:UIControlStateNormal];
    }else{
        [self.hiddenGradBtn setTitle:@"一般隐患" forState:UIControlStateNormal];        
         [self.hiddenGradBtn setBackgroundImage:[UIImage imageNamed:@"yuansu_yiban"] forState:UIControlStateNormal];
    }
}
@end
