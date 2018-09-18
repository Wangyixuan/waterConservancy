//
//  WLMailListCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLMailListCell.h"
@interface WLMailListCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *orgNameLab;

@end

@implementation WLMailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(WLPersonModel *)model{
    _model = model;
    self.nameLab.text = model.name;
    self.orgNameLab.text = model.orgName;
}
@end
