//
//  WLResetPasswordController.m
//  waterConservancy
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLResetPasswordController.h"

@interface WLResetPasswordController ()

@end

@implementation WLResetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"gobackBtn"];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    //   将leftItem设置为自定义按钮
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
