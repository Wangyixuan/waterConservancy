//
//  WLAcciInfoCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/4.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLAcciInfoCell.h"
@interface WLAcciInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *reapAccLab;
@property (weak, nonatomic) IBOutlet UILabel *phoAccLab;


@end

@implementation WLAcciInfoCell

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
    if ([model.phoRep intValue]==1) {
        self.phoAccLab.text = @"是";
    }else{
        self.phoAccLab.text = @"否";
    }
    if ([model.respAcc intValue]==1) {
        self.reapAccLab.text = @"是";
    }else{
        self.reapAccLab.text = @"否";
    }
}
@end
