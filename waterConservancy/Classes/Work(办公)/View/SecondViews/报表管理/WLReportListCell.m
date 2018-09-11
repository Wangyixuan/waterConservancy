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
    self.backBtn.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(WLReportModel *)model{
    _model = model;
    self.nameLab.text = model.repName;
    self.reportBtn.enabled = YES;
    self.backBtn.hidden = YES;
    if ([model.repAct integerValue]==1) {
        self.reportBtn.enabled = NO;
    }else if([model.repAct integerValue]==2){
         self.backBtn.hidden = NO;
        [self.reportBtn setTitle:@"上报" forState:UIControlStateNormal];
        [self.reportBtn setBackgroundImage:[UIImage imageNamed:@"smallbtnBg"] forState:UIControlStateNormal];
    }else if ([model.repAct integerValue]==3){
        
    }
}


- (IBAction)reportBtnClick:(id)sender {
    
}
- (IBAction)backBtnClick:(id)sender {
    
}

@end
