//
//  WLContactDetailController.m
//  waterConservancy
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLContactDetailController.h"

@interface WLContactDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *perName;
@property (weak, nonatomic) IBOutlet UILabel *perCode;
@property (weak, nonatomic) IBOutlet UILabel *telNub;
@property (weak, nonatomic) IBOutlet UILabel *orgName;
@property (weak, nonatomic) IBOutlet UILabel *depName;
@property (weak, nonatomic) IBOutlet UILabel *jobName;

@end

@implementation WLContactDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    // Do any additional setup after loading the view.
    self.perName.text = [NSString stringWithFormat:@"姓名：%@", self.model.name];
    self.perCode.text = [NSString stringWithFormat:@"账号：%@", self.model.userCode];
    self.telNub.text = self.model.telNub;
    self.orgName.text = self.model.orgName;
    self.depName.text = self.model.depName;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)telBtnClick:(id)sender {
}

- (IBAction)mesBtnClick:(id)sender {
}


@end
