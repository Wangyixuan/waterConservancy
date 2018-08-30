//
//  WLHiddenRepairPopView.m
//  waterConservancy
//
//  Created by mac on 2018/8/30.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLHiddenRepairPopView.h"
@interface WLHiddenRepairPopView()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *placeHoldLab;
@property (weak, nonatomic) IBOutlet UITextView *contentText;

@end

@implementation WLHiddenRepairPopView

+(instancetype)showRepairPopView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"WLHiddenRepairPopView" owner:nil options:nil].firstObject;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.contentText.layer.borderWidth = 1.f;
    self.contentText.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.contentText.layer.cornerRadius = 5.f;
    self.contentText.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
         [self tapAction];
    }];
    [self addGestureRecognizer:tap];
}

-(void)tapAction{
    if (self.contentText.text.length>0) {
         [self.contentText resignFirstResponder];
    }else{
        [self removeFromSuperview];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeHoldLab.hidden = YES;
    
    self.frame = CGRectMake(0, -100, kScreenWidth, kScreenHeight);
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length==0) {
        self.placeHoldLab.hidden = NO;
    }
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

- (void)textViewDidChange:(UITextView *)textView{

}

- (IBAction)cancelBtnClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)commitBtnClick:(id)sender {
    if (self.contentText.text.length>0) {
        if (self.commitBlock) {
            self.commitBlock(self.contentText.text);
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请填写内容"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
}

@end
