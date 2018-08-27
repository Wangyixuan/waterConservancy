//
//  WLUploadHiddenInfoCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/27.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLUploadHiddenInfoCell.h"

@interface WLUploadHiddenInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *engNameLab;

@property (weak, nonatomic) IBOutlet UILabel *tendNameLab;

@end

@implementation WLUploadHiddenInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
