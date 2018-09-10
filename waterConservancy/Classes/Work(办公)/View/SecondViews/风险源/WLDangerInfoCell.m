//
//  WLDangerInfoCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLDangerInfoCell.h"

@interface WLDangerInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *wuinNameLab;
@property (weak, nonatomic) IBOutlet UILabel *engNameLab;
@property (weak, nonatomic) IBOutlet UILabel *gradLab;
@property (weak, nonatomic) IBOutlet UILabel *ifNoticeLab;
@property (weak, nonatomic) IBOutlet UILabel *supPersLab;
@property (weak, nonatomic) IBOutlet UILabel *telLab;
@property (weak, nonatomic) IBOutlet UILabel *collTimeLab;

@end


@implementation WLDangerInfoCell

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
    self.wuinNameLab.text = model.orgName;
    self.engNameLab.text = model.engName;
    if ([model.grad integerValue]==1) {
        self.gradLab.text = @"一般危险源";
    }else if ([model.grad integerValue]==2){
                self.gradLab.text = @"重大危险源";
    }
    if ([model.ifLiceNoti integerValue]==1) {
        self.ifNoticeLab.text = @"是";
    }else if ([model.ifLiceNoti integerValue]==2){
        self.ifNoticeLab.text = @"否";
    }else{
        self.ifNoticeLab.text = @"未知";
    }
    self.supPersLab.text = model.supPers;
    self.telLab.text = model.offiTel;
    self.collTimeLab.text = model.collTime;
}
@end
