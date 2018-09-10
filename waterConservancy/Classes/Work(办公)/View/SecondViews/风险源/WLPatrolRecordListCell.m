//
//  WLPatrolRecordListCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLPatrolRecordListCell.h"

@interface WLPatrolRecordListCell()
@property (weak, nonatomic) IBOutlet UILabel *patPersLab;

@property (weak, nonatomic) IBOutlet UILabel *patTimeLab;

@end

@implementation WLPatrolRecordListCell

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
    self.patPersLab.text = [NSString stringWithFormat:@"巡查人员：%@",model.patPers];
    self.patTimeLab.text = [NSString stringWithFormat:@"巡查时间：%@",model.patTime];
}
@end
