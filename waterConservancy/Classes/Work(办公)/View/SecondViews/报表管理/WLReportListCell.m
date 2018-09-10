//
//  WLReportListCell.m
//  waterConservancy
//
//  Created by mac on 2018/9/10.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLReportListCell.h"

@interface WLReportListCell()
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation WLReportListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"已退回"];
    NSRange titleRange = {0,[string length]};
    [string addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [string addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:titleRange];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:titleRange];
    [self.backBtn setAttributedTitle:string forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)reportBtnClick:(id)sender {
    
}
- (IBAction)backBtnClick:(id)sender {
    
}

@end
