//
//  WLAcciDeailCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/4.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAcciDeailCell.h"
@interface WLAcciDeailCell()
@property (weak, nonatomic) IBOutlet UILabel *accWiunName;
@property (weak, nonatomic) IBOutlet UILabel *accNameLab;
@property (weak, nonatomic) IBOutlet UILabel *serInjNubLab;
@property (weak, nonatomic) IBOutlet UILabel *deadNubLab;
@property (weak, nonatomic) IBOutlet UILabel *accLossLab;
@property (weak, nonatomic) IBOutlet UILabel *occuTimeLab;
@property (weak, nonatomic) IBOutlet UITextView *accSituText;
@property (weak, nonatomic) IBOutlet UILabel *mediaTitleLab;
@property (weak, nonatomic) IBOutlet UIScrollView *photoImgV;

@end

@implementation WLAcciDeailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(WLAcciModel *)model{
    _model = model;
    self.accWiunName.text = model.wiunName;
    self.accNameLab.text = model.accName;
    self.serInjNubLab.text = model.serInjNub;
    self.deadNubLab.text = model.deadNub;
    self.accLossLab.text = [NSString stringWithFormat:@"%@元",model.accLoss];
    self.occuTimeLab.text = model.occuTime;
    self.accSituText.text = model.accSitu;
}
@end
