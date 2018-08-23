//
//  WLWorkTableViewCell.m
//  waterConservancy
//
//  Created by mac on 2018/8/15.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLWorkTableViewCell.h"
#import "WLVerticalButton.h"
#import "WLWorkModel.h"

#define WORKCELLIDENTIFITY @"WLWorkCell"
#define itemW (kScreenWidth-56-20)/4
#define itemH itemW


@interface WLWorkTableViewCell()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *subViewBgView;

@property (nonatomic, strong) NSMutableArray *btnArr;
@property (nonatomic, weak) UIScrollView *bgScrollView;
@end

@implementation WLWorkTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.btnArr = [NSMutableArray array];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
   
}

-(void)setModel:(WLWorkModel *)model{
    _model = model;
    self.titleLab.text = model.title;
    self.bgImageView.image = [UIImage imageNamed:model.bgImage];
    if (model.data.count>4) {
        [self setupScrollViewWithArray:model.data];
    }else{
        [self setupBtnsWithArray:model.data];
    }
}

-(void)setupBtnsWithArray:(NSArray*)modelArr{
    [self.subViewBgView removeAllSubviews];
    for (int i = 0; i < modelArr.count; ++i) {
        WLVerticalButton *btn = [[WLVerticalButton alloc]initWithFrame:CGRectMake(i*itemW, 0, itemW, itemH)];
        btn.tag = i;
        [btn setTitleColor:COLOR_WITH_HEX(0x999999) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *modeldic = [modelArr objectAtIndex:i];
        [btn setTitle:modeldic[@"text"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:modeldic[@"img"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *dic = [modelArr objectAtIndex:i];
        NSString *text = (NSString*)[dic objectForKey:@"text"];
        NSString *imgName = (NSString*)[dic objectForKey:@"img"];
        [btn setTitle:text forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [self.subViewBgView addSubview:btn];
    }
}

-(void)setupScrollViewWithArray:(NSArray*)modelArray{
    if (!_bgScrollView) {
        [self.subViewBgView removeAllSubviews];
        UIScrollView *bgScrollView = [[UIScrollView alloc]init];
        bgScrollView.contentSize = CGSizeMake(itemW*modelArray.count, 0);
        bgScrollView.showsHorizontalScrollIndicator = NO;
        bgScrollView.pagingEnabled = YES;
        [self.subViewBgView addSubview:bgScrollView];
        [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        self.bgScrollView = bgScrollView;
    }else{
        [_bgScrollView removeAllSubviews];
    }
    for (int i = 0; i < modelArray.count; ++i) {
        WLVerticalButton *btn = [[WLVerticalButton alloc]initWithFrame:CGRectMake(i*itemW, 0, itemW, itemH)];
        btn.tag = i;
        [btn setTitleColor:COLOR_WITH_HEX(0x999999) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *modelDic = [modelArray objectAtIndex:i];
        [btn setTitle:modelDic[@"text"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:modelDic[@"img"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *dic = [modelArray objectAtIndex:i];
        NSString *text = (NSString*)[dic objectForKey:@"text"];
        NSString *imgName = (NSString*)[dic objectForKey:@"img"];
        [btn setTitle:text forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [_bgScrollView addSubview:btn];
    }
}

-(void)itemBtnClick:(WLVerticalButton *)itemBtn{
    NSDictionary *dic = [self.model.data objectAtIndex:itemBtn.tag];
    NSString *ctrlStr = [dic stringForKey:@"ctrl" defaultValue:@""];
    if (self.btnClickBlock) {
        self.btnClickBlock(ctrlStr);
    }
}
@end
