//
//  WLCheckInfoCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/24.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLCheckInfoCell.h"


@interface WLCheckInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *startTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end



@implementation WLCheckInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(WLOnSpotCheckModel *)model{
    _model = model;
    self.startTimeLab.text = model.startTimeStr;
    self.endTimeLab.text = model.endTimeStr;
    self.contentLab.text = model.checkNoteStr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
