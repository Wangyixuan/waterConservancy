//
//  WLRecordInfoCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLRecordInfoCell.h"
@interface WLRecordInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *patTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *patPerLab;
@property (weak, nonatomic) IBOutlet UIView *photoImgV;

@end


@implementation WLRecordInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(WLPatrolRecordModel *)model{
    _model = model;
    self.patPerLab.text = model.patPers;
    self.patTimeLab.text = model.patTime;
}
@end
