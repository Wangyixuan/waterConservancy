//
//  WLPendingWorkCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLPendingWorkCell.h"
@interface WLPendingWorkCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation WLPendingWorkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
