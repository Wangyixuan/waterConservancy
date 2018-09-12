//
//  WLUserInfoController.m
//  waterConservancy
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLUserInfoController.h"

@interface WLUserInfoController ()

@property (weak, nonatomic) IBOutlet UILabel *userCodeLab;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *userTel;
@property (weak, nonatomic) IBOutlet UITextField *userOrg;
@property (weak, nonatomic) IBOutlet UITextField *userTeam;
@property (weak, nonatomic) IBOutlet UITextField *userJob;

@end

@implementation WLUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基本信息";
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"gobackBtn"];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    //   将leftItem设置为自定义按钮
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn sizeToFit];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.userNameText.enabled = NO;
    self.userTel.enabled = NO;
    self.userOrg.enabled = NO;
    self.userTeam.enabled = NO;
    self.userJob.enabled = NO;
    
    self.userCodeLab.text = WLShareUserManager.userCode;
}

-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editClick:(UIButton*)btn{
    if (btn.selected==YES) {
        self.userNameText.enabled = NO;
        self.userTel.enabled = NO;
        self.userOrg.enabled = NO;
        self.userTeam.enabled = NO;
        self.userJob.enabled = NO;
    }else{
        self.userNameText.enabled = YES;
        self.userTel.enabled = YES;
        self.userOrg.enabled = YES;
        self.userTeam.enabled = YES;
        self.userJob.enabled = YES;
    }
    btn.selected = !btn.selected;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
