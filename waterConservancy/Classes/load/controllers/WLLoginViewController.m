//
//  WLLoginViewController.m
//  waterConservancy
//
//  Created by mac on 2018/9/14.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLLoginViewController.h"
#import "YXDownListView.h"
#import "AppDelegate.h"

@interface WLLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UIButton *moreUserNameBtn;
@property (weak, nonatomic) IBOutlet UITextField *passWordText;
@property (weak, nonatomic) IBOutlet UIButton *passWordBtn;
@property (nonatomic, strong) YXDownListView *downListView;
@end

@implementation WLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userNameText.text = WLShareUserManager.userName;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moreUserNameBtnClick:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self addDownList];
    }else{
        [self delDownList];
    }
  
}
- (IBAction)passWordBtnClick:(UIButton*)sender {
    self.passWordBtn.selected = !self.passWordBtn.selected;
    self.passWordText.secureTextEntry = sender.selected;
    [self.passWordText becomeFirstResponder];
    
}
//添加dowmlistView
-(void)addDownList{
    self.downListView = [[YXDownListView alloc]init];
    [self.view addSubview:self.downListView];
    @weakify(self);
    [self.downListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.userNameText.mas_left);
        make.right.mas_equalTo(weak_self.moreUserNameBtn.mas_right);
        make.top.mas_equalTo(weak_self.userNameText.mas_bottom);
        make.height.mas_equalTo(SCALE_H(120));
    }];
    self.downListView.block = ^(NSString *userName,NSString *password) {
        if (userName.length>0) {
            weak_self.userNameText.text = userName;
            weak_self.passWordText.text = password;
            [weak_self.downListView removeFromSuperview];
            if (weak_self.moreUserNameBtn.selected==NO) {
                [weak_self moreUserNameBtnClick:weak_self.moreUserNameBtn];
            }
        }
    };
}
-(void)delDownList{
    [self.downListView removeFromSuperview];
    self.downListView = nil;
}

- (IBAction)loginBtnClick:(id)sender {
    
    //    ApplicationID写死 ios为5cb345b6-26d3-11e5-9325-68f728009cac
    if (self.userNameText.text.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    if (self.passWordText.text.length<=0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        [SVProgressHUD dismissWithDelay:1.5];        return;
    }
    
    NSString *password = [[self.passWordText.text md5String]uppercaseString];
    [[YXNetTool shareTool]SOAPData:@"http://192.168.1.11:9080/uams/ws/uumsext/UserExt?wsdl" password:password userName:self.userNameText.text success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *respDic = (NSDictionary*)responseObject;
        [WLShareUserManager updateUserInfoWithDataDic:respDic];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *userNameArray = [defaults objectForKey:@"loadUserName"];
        NSMutableArray *usrMuA;
        if (userNameArray.count) {
            usrMuA = userNameArray.mutableCopy;
        }else{
            usrMuA = [NSMutableArray array];
        }
        //是否含有这个用户
        NSString *userName = [self.userNameText.text lowercaseString];
        NSLog(@"%@",userName);
        NSString *password = self.passWordText.text;
        BOOL isContain = NO;
        [defaults setObject:userName forKey:@"currentUser"];
        [defaults setObject:password forKey:@"currentPassword"];
        for (NSDictionary *dic in usrMuA) {
            if ([dic.allKeys containsObject:userName]) {
                isContain = YES;
            }
        }
        NSDictionary *nameAPassDic = [NSDictionary dictionaryWithObject:password forKey:userName];
        [usrMuA addObject:nameAPassDic];
        [defaults setObject:usrMuA forKey:@"loadUserName"];
        WLShareUserManager.autoLoginEnabled = YES;

        //2.跳转页面
        [(AppDelegate *)[UIApplication sharedApplication].delegate showMainControllers];
        
    } failure:nil];
}
#pragma mark TextDelegate
//键盘收起事件
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.moreUserNameBtn.selected) {
        self.moreUserNameBtn.selected = NO;
        [self delDownList];
    }
    return YES;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![self.view isExclusiveTouch]) {
        [self.userNameText resignFirstResponder];
        [self.passWordText resignFirstResponder];
    }
}
//避免密码切换后再输入后清除
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.userNameText) {
        self.passWordText.text=@"";
    }
    
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.passWordText) {
        textField.text = toString;
        return NO;
    }
    //清除用户名后密码清空
    
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    if (textField == self.userNameText) {
        self.passWordText.text=@"";
    }
    return YES;
}
@end
