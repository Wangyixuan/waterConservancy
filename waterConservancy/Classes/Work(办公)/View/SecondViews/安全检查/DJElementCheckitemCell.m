//
//  DJElementCheckitemCell.m
//  waterConservancy
//
//  Created by liu on 2018/8/22.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJElementCheckitemCell.h"
#import "DJElementCheckItemModel.h"

@interface DJElementCheckitemCell ()<UITextFieldDelegate>
//@property (nonatomic, weak) UIView *MyContainView;
@property (nonatomic, weak) UIImageView *MyContainView;
/**  标题项  */
@property (nonatomic, weak) UILabel *ItemLabel;
/**  确定按钮 点击确定按钮跳转到问题上报页面  */
@property (nonatomic, weak) UIButton *YesBtn;
@property (nonatomic, weak) UIButton *NoBtn;
//数字输入
@property (nonatomic, weak) UILabel *numLabel;
@property (nonatomic, weak) UITextField *numInputTextF;
@property (nonatomic, weak) UIView   *lineView;

@end
@implementation DJElementCheckitemCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
       
     
       
    }
    return self;
}
-(void)initDataWithModel:(NSArray *)modelArray indexPath:(NSIndexPath *)indexpath{
    DJElementCheckItemModel *model = modelArray[indexpath.row];
    NSString *labelStr = [NSString stringWithFormat:@"%ld、%@",(long)indexpath.row+1,model.seChitName];
    [self.ItemLabel setText:labelStr];
    
}
#pragma mark PrivateMethod
-(void)YesBtnClick{
    self.YesBtn.selected = YES;
    self.NoBtn.selected = NO;
    //跳转页面
}
-(void)NoBtnClick{
    self.YesBtn.selected = NO;
    self.NoBtn.selected = YES;
}
-(void)tapClcik{
    if (self.numInputTextF.isFirstResponder) {
        [self.numInputTextF resignFirstResponder];
    }
}


#pragma mark UI
-(void)initUI{
    @weakify(self);
    [self.MyContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.contentView);
        make.left.mas_equalTo(weak_self.contentView.mas_left).offset(SCALE_W(20));
        make.right.mas_equalTo(weak_self.contentView.mas_right).offset(SCALE_W(-20));
        make.bottom.mas_equalTo(weak_self.contentView.mas_bottom);
    }];
    [self.ItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.MyContainView.mas_left).offset(SCALE_W(20));
        make.top.mas_equalTo(weak_self.MyContainView.mas_top).offset(SCALE_W(20));
        make.right.mas_equalTo(weak_self.MyContainView.mas_right)
        .offset(SCALE_W(-20));
    }];
    [self.YesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.MyContainView.mas_left)
        .offset(SCALE_W(40));
        make.top.mas_equalTo(weak_self.ItemLabel.mas_bottom)
        .offset(SCALE_W(20));
        make.width.mas_equalTo(SCALE_W(120));
        make.height.mas_equalTo(SCALE_W(60));
    }];
    [self.NoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.YesBtn.mas_right).offset(SCALE_W(60));
        make.top.mas_equalTo(weak_self.YesBtn.mas_top);
        make.width.height.mas_equalTo(weak_self.YesBtn);
//        make.bottom.mas_equalTo(weak_self.contentView.mas_bottom)
//        .offset(SCALE_W(-20));
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.NoBtn.mas_right).offset(SCALE_W(60));
        make.top.mas_equalTo(weak_self.YesBtn.mas_top);
        make.centerY.mas_equalTo(weak_self.YesBtn.mas_centerY);
    }];
    [self.numInputTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.numLabel.mas_right).offset(SCALE_W(20));
        make.centerY.mas_equalTo(weak_self.numLabel.mas_centerY);
        make.width.mas_equalTo(SCALE_W(100));
        make.height.mas_equalTo(SCALE_W(40));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.MyContainView.mas_left)
        .offset(SCALE_W(40));
        make.right.mas_equalTo(weak_self.MyContainView.mas_right)
        .offset(SCALE_W(-40));
        make.top.mas_equalTo(weak_self.YesBtn.mas_bottom).offset(SCALE_W(20));
        make.bottom.mas_equalTo(weak_self.contentView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
}

-(UIImageView *)MyContainView{
    if (!_MyContainView) {
        UIImageView *myContenview = [[UIImageView alloc]init];
        [myContenview setImage:[UIImage imageNamed:@"flow2"]];
        myContenview.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClcik)];
        [myContenview addGestureRecognizer:ges];
        [self.contentView addSubview:myContenview];
        _MyContainView = myContenview;
    }
    return _MyContainView;
}

-(UILabel *)ItemLabel{
    if (!_ItemLabel) {
        UILabel *ItemLabel = [[UILabel alloc]init];
        [ItemLabel setText:@"1、水库、农村水电站、淤坝地、在建工程、勘察设计和水文监测"];
        [ItemLabel setTextColor:COLOR_WITH_HEX(0x333333)];
        [ItemLabel setFont:YX30Font];
        [ItemLabel setTextAlignment:NSTextAlignmentLeft];
        ItemLabel.preferredMaxLayoutWidth = ScreenWidth - SCALE_W(80);
        ItemLabel.numberOfLines = 0;
        [self.MyContainView addSubview:ItemLabel];
        _ItemLabel = ItemLabel;
    }
    return _ItemLabel;
}
-(UIButton *)YesBtn{
    if (!_YesBtn) {
        UIButton *YesBtn = [[UIButton alloc]init];
        [YesBtn setTitle:@"是" forState:UIControlStateNormal];
        [YesBtn.titleLabel setFont:YX26Font];
        [YesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [YesBtn setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
        [YesBtn setImage:[UIImage imageNamed:@"yuan_selected"] forState:UIControlStateSelected];
        [YesBtn addTarget:self action:@selector(YesBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.MyContainView addSubview:YesBtn];
        _YesBtn = YesBtn;
    }
    return _YesBtn;
}
-(UIButton *)NoBtn{
    if (!_NoBtn) {
        UIButton *NoBtn = [[UIButton alloc]init];
        [NoBtn setTitle:@"否" forState:UIControlStateNormal];
        [NoBtn.titleLabel setFont:YX26Font];
        [NoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [NoBtn setImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
        [NoBtn setImage:[UIImage imageNamed:@"yuan_selected"] forState:UIControlStateSelected];
        [NoBtn addTarget:self action:@selector(NoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.MyContainView addSubview:NoBtn];
        _NoBtn = NoBtn;
    }
    return _NoBtn;
}
-(UILabel *)numLabel{
    if (!_numLabel) {
        UILabel *numLabel = [[UILabel alloc]init];
        [numLabel setText:@"数量"];
        [numLabel setTextColor:COLOR_WITH_HEX(0x333333)];
        [numLabel setFont:YX30Font];
        [numLabel setTextAlignment:NSTextAlignmentLeft];
        numLabel.numberOfLines = 0;
        [self.MyContainView addSubview:numLabel];
        _numLabel = numLabel;
    }
    return _numLabel;
}
-(UITextField *)numInputTextF{
    if (!_numInputTextF) {
        UITextField *textFile = [[UITextField alloc]init];
        textFile.keyboardType = UIKeyboardTypeNumberPad;
        textFile.backgroundColor = FColor(165.0, 165.0, 165.0, 1.0);
        [self.MyContainView addSubview:textFile];
        _numInputTextF = textFile;
    }
    return _numInputTextF;
}
-(UIView *)lineView{
    if (!_lineView) {
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = GrayLineColor;
        [self.MyContainView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}








@end
