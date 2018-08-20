//
//  DJLoadViewController.m
//  waterConservancy
//
//  Created by liu on 2018/8/14.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJLoadViewController.h"
 #import<CommonCrypto/CommonDigest.h>

#import "YXDownListView.h"
#import "YXForgetView.h"

#import "AppDelegate.h"

@interface DJLoadViewController ()<UITextFieldDelegate>
@property (nonatomic, weak) UIImageView *backImgView;

@property (nonatomic, weak) UIView      *userNameView;
@property (nonatomic, weak) UIImageView *userNameImgView;
@property (nonatomic, weak) UITextField *userNameFiled;
@property (nonatomic, weak) UIButton    *userNameBtn;

@property (nonatomic, weak) UIView      *passWordView;
@property (nonatomic, weak) UIImageView *passWordImgView;
@property (nonatomic, weak) UITextField *passWordFiled;
@property (nonatomic, weak) UIButton    *passWordBtn;

@property (nonatomic, weak) UITextView  *tipTextView;

@property (nonatomic, weak) UIButton    *loadBtn;

@property (nonatomic, weak) UIButton    *rememberBtn;

@property (nonatomic, weak) UIButton    *forgetBtn;


//下拉框
//储存所有账号信息的可变数组
@property (nonatomic, strong) NSMutableArray *usrMuA;

@property (nonatomic, strong) YXDownListView *downListView;

@end

@implementation DJLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUI];
}
#pragma mark Private Method

-(void)forgetClick{
    YXForgetView *forgetView = [[YXForgetView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:forgetView];
}
//记住密码
-(void)rememberClick:(UIButton *)btn{
    //记住本次的是否记住密码
    btn.selected = !btn.selected;
    NSString *remStr;
    if (btn.selected) {
        remStr = @"isRemember";
    }else{
        remStr = @"notRemember";
    }
    [[NSUserDefaults standardUserDefaults]setObject:remStr forKey:@"isrememberPassword"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

//点击展示所有登陆过的用户
-(void)userbtnClick{
    //展示所有登录过得账号
    
    self.userNameBtn.selected = !self.userNameBtn.selected;
    if (self.userNameBtn.isSelected) {
        [self addDownList];
    }else{
        [self delDownList];
    }
}
-(void)passwordBtnClick:(UIButton *)sender{
    self.passWordFiled.enabled = NO;
    self.passWordFiled.secureTextEntry = sender.selected;
    self.passWordBtn.selected = !self.passWordBtn.selected;
    NSLog(@"%d",self.passWordBtn.selected);
    self.passWordFiled.enabled = YES;
    [self.passWordFiled becomeFirstResponder];
}


-(void)loadClick{
    //    ApplicationID写死 ios为5cb345b6-26d3-11e5-9325-68f728009cac
    if (self.userNameFiled.text.length<=0) {
        [self.tipTextView setText:@"用户名不能为空"];
        return;
    }
    if (self.passWordFiled.text.length<=0) {
        [self.tipTextView setText:@"密码不能为空"];
        return;
    }
    
    NSString *password = [[self.passWordFiled.text md5String]uppercaseString];
    [[YXNetTool shareTool]SOAPData:@"http://192.168.1.11:9080/uams/ws/uumsext/UserExt?wsdl" password:password userName:self.userNameFiled.text success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *userNameArray = [defaults objectForKey:@"loadUserName"];
        NSMutableArray *usrMuA;
        if (userNameArray.count) {
            usrMuA = userNameArray.mutableCopy;
        }else{
            usrMuA = [NSMutableArray array];
        }
        //是否含有这个用户
        NSString *userName = [self.userNameFiled.text lowercaseString];
        NSLog(@"%@",userName);
        NSString *password = self.passWordFiled.text;
        BOOL isContain = NO;
        [defaults setObject:userName forKey:@"currentUser"];
        [defaults setObject:password forKey:@"currentPassword"];
        for (NSDictionary *dic in usrMuA) {
            if ([dic.allKeys containsObject:userName]) {
                isContain = YES;
            }
        }
        if (!isContain && [isRememberPassword isEqualToString:@"isRemember"]) {
            NSDictionary *nameAPassDic = [NSDictionary dictionaryWithObject:password forKey:userName];
            [usrMuA addObject:nameAPassDic];
            [defaults setObject:usrMuA forKey:@"loadUserName"];

        }
      

        //2.跳转页面
        [(AppDelegate *)[UIApplication sharedApplication].delegate showMainControllers];
    } failure:nil];
}


//添加dowmlistView
-(void)addDownList{
    self.downListView = [[YXDownListView alloc]init];
    [self.view addSubview:self.downListView];
    @weakify(self);
    [self.downListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.userNameView.mas_left);
        make.right.mas_equalTo(weak_self.userNameView.mas_right);
        make.top.mas_equalTo(weak_self.userNameView.mas_bottom);
        make.height.mas_equalTo(SCALE_H(120));
    }];
    self.downListView.block = ^(NSString *userName,NSString *password) {
        if (userName.length>0) {
            weak_self.userNameFiled.text = userName;
            weak_self.passWordFiled.text = password;
            [weak_self.downListView removeFromSuperview];
        }
        
    };
}
-(void)delDownList{
    [self.downListView removeFromSuperview];
    self.downListView = nil;
}

#pragma mark TextDelegate
//键盘收起事件
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tipTextView.text = nil;
    if (self.userNameBtn.selected) {
        self.userNameBtn.selected = NO;
        [self delDownList];
    }
    return YES;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![self.backImgView isExclusiveTouch]) {
        [self.userNameFiled resignFirstResponder];
        [self.passWordFiled resignFirstResponder];
    }
}

//-(void)textFieldEditChanged:(NSNotification *)obj{
//    UITextField *textField = (UITextField *)obj.object;
//    NSString *toBeString = textField.text;
//    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
//    // 键盘输入模式
//    if ([lang isEqualToString:@"zh-Hans"]) {
//        // 简体中文输入，包括简体拼音，健体五笔，简体手写
//        UITextRange *selectedRange = [textField markedTextRange]; //获取高亮部分
//        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
//        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//        if (!position) {
//            if (toBeString.length > 15) {
//                textField.text = [toBeString substringToIndex:15];
//                [EasyTextView showText:@"最多输入15字"];
//            }
//
//        }// 有高亮选择的字符串，则暂不对文字进行统计和限制
//        else{ }
//
//    } // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
//    else{
//        if (toBeString.length > 15) {
//            textField.text = [toBeString substringToIndex:15];
//            [EasyTextView showText:@"最多输入15字"];
//        }
//
//    }
//
//}


//避免密码切换后再输入后清除
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.userNameFiled) {
        self.passWordFiled.text=@"";
    }
    
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.passWordFiled) {
        textField.text = toString;
        return NO;
    }
    //清除用户名后密码清空
    
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    if (textField == self.userNameFiled) {
        self.passWordFiled.text=@"";
    }
    return YES;
}



-(void)setUI{
    self.navigationController.navigationBarHidden = YES;
    @weakify(self);
    [self.backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weak_self.view);
        make.height.mas_equalTo(SCALE_H(484));
    }];
    
    //登录
    [self.userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top    .mas_equalTo(weak_self.backImgView.mas_bottom)
        .offset(SCALE_H(80));
        make.width.mas_equalTo(SCALE_W(600));
        make.centerX.mas_equalTo(weak_self.view.mas_centerX);
        make.height  .mas_equalTo(SCALE_H(100));
    }];
    self.userNameView.layer.cornerRadius = SCALE_H(40);
    self.userNameView.layer.masksToBounds = YES;
    
    [self.userNameImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left   .mas_equalTo(weak_self.userNameView.mas_left)
        .offset(SCALE_W(30));
        make.centerY.mas_equalTo(weak_self.userNameView.mas_centerY);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    
    [self.userNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weak_self.userNameView.mas_right)
        .offset(SCALE_W(-30));
        make.centerY.mas_equalTo(weak_self.userNameView.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    [self.userNameFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left   .mas_equalTo(weak_self.userNameImgView.mas_right)
        .offset(SCALE_W(10));
        make.right  .mas_equalTo(weak_self.userNameBtn.mas_left)
        .offset(SCALE_W(-10));
        make.bottom .mas_equalTo(weak_self.userNameView.mas_bottom);
        make.top    .mas_equalTo(weak_self.userNameView.mas_top);
    }];
    
    
    //密码
    [self.passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left   .mas_equalTo(weak_self.userNameView.mas_left);
        make.top    .mas_equalTo(weak_self.userNameView.mas_bottom)
        .offset(SCALE_H(40));
        make.width   .mas_equalTo(weak_self.userNameView.mas_width);
        make.height  .mas_equalTo(weak_self.userNameView.mas_height);
    }];
    self.passWordView.layer.cornerRadius = SCALE_H(40);
    self.passWordView.layer.masksToBounds = YES;
    
    [self.passWordImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left   .mas_equalTo(weak_self.passWordView.mas_left)
        .offset(SCALE_W(30));
        make.centerY.mas_equalTo(weak_self.passWordView.mas_centerY);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    [self.passWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right   .mas_equalTo(weak_self.passWordView.mas_right)
        .offset(SCALE_W(-30));
        make.centerY.mas_equalTo(weak_self.passWordView.mas_centerY);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(16);
    }];
    [self.passWordFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left   .mas_equalTo(weak_self.passWordImgView.mas_right)
        .offset(SCALE_W(10));
        make.right  .mas_equalTo(weak_self.passWordBtn.mas_left)
        .offset(SCALE_W(-30));
        make.bottom.top.mas_equalTo(weak_self.passWordView);
    }];
    
    
    //提示框
    [self.tipTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weak_self.backImgView);
        make.top    .mas_equalTo(weak_self.passWordView.mas_bottom)
        .offset(SCALE_H(50));
        make.width.mas_equalTo(weak_self.backImgView);
        make.height.mas_equalTo(SCALE_W(100));
    }];
    
    
    //登录按钮
    [self.loadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left   .mas_equalTo(weak_self.userNameView.mas_left);
        make.top    .mas_equalTo(weak_self.tipTextView.mas_bottom)
        .offset(SCALE_H(50));
        make.width.height  .mas_equalTo(weak_self.userNameView);
    }];
    self.loadBtn.layer.cornerRadius     = SCALE_H(40);
    self.loadBtn.layer.masksToBounds    = YES;
    
    
    //网络设置
    [self.rememberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left   .mas_equalTo(weak_self.loadBtn.mas_left);
        make.bottom .mas_equalTo(weak_self.view.mas_bottom)
        .offset(SCALE_H(-50));
        make.width  .mas_equalTo(SCALE_W(200));
        make.height .mas_equalTo(SCALE_H(80));
    }];
    //忘记密码
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right  .mas_equalTo(weak_self.loadBtn.mas_right);
        make.bottom .mas_equalTo(weak_self.view.mas_bottom)
        .offset(SCALE_H(-50));
        make.width  .mas_equalTo(SCALE_W(200));
        make.height .mas_equalTo(SCALE_H(80));
    }];
    
    
    
    
}





#pragma mark Setter
-(UIImageView *)backImgView{
    if (!_backImgView) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.userInteractionEnabled = YES;
        [imgView setImage:[UIImage imageNamed:@"topImage"]];
        [self.view addSubview:imgView];
        _backImgView = imgView;
    }
    return _backImgView;
}

//账号
-(UIView *)userNameView{
    if (!_userNameView) {
        UIView *view = [[UIView alloc]init];
        view.layer.borderWidth = 1;
        view.layer.borderColor = COLOR_WITH_HEX(0x999999).CGColor;
        [self.view addSubview:view];
        _userNameView = view;
    }
    return _userNameView;
}
-(UIImageView *)userNameImgView{
    if (!_userNameImgView) {
        UIImageView *imgView = [[UIImageView alloc]init];
        UIImage *img = [UIImage imageNamed:@"user.png"];
        [imgView setImage:img];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        //        imgView.size  = img.size;
        [self.userNameView addSubview:imgView];
        _userNameImgView = imgView;
    }
    return _userNameImgView;
}
-(UITextField *)userNameFiled{
    if (!_userNameFiled) {
        UITextField *tfiled = [[UITextField alloc]init];
        tfiled.textColor = [UIColor grayColor];
        //        tfiled.font = [UIFont systemFontOfSize:12.0f];
        tfiled.textAlignment = NSTextAlignmentLeft;
        tfiled.borderStyle = UITextBorderStyleNone;
        tfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        tfiled.returnKeyType = UIReturnKeyDone;
        tfiled.delegate = self;
        
        tfiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"账号" attributes:
                                        @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],
                                          NSForegroundColorAttributeName:COLOR_WITH_HEX(0x999999)
                                          }];
        [self.userNameView addSubview:tfiled];
        _userNameFiled = tfiled;
    }
    return _userNameFiled;
}
-(UIButton *)userNameBtn{
    if (!_userNameBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"downRow.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(userbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.userNameView addSubview:btn];
        _userNameBtn = btn;
    }
    return _userNameBtn;
}

//密码
-(UIView *)passWordView{
    if (!_passWordView) {
        UIView *view = [[UIView alloc]init];
        view.layer.borderWidth = 1;
        view.layer.borderColor = COLOR_WITH_HEX(0x999999).CGColor;
        [self.view addSubview:view];
        _passWordView = view;
    }
    return _passWordView;
}
-(UIImageView *)passWordImgView{
    if (!_passWordImgView) {
        UIImageView *imgView = [[UIImageView alloc]init];
        UIImage *img = [UIImage imageNamed:@"password.png"];
        [imgView setImage:img];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.passWordView addSubview:imgView];
        _passWordImgView = imgView;
    }
    return _passWordImgView;
}
-(UITextField *)passWordFiled{
    if (!_passWordFiled) {
        UITextField *tfiled = [[UITextField alloc]init];
        tfiled.textColor = [UIColor grayColor];
        //        tfiled.font = [UIFont systemFontOfSize:12.0f];
        tfiled.textAlignment = NSTextAlignmentLeft;
        tfiled.borderStyle = UITextBorderStyleNone;
        tfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        tfiled.returnKeyType = UIReturnKeyDone;
        tfiled.secureTextEntry = YES;
        tfiled.delegate = self;
        tfiled.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"密码" attributes:
                                        @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],
                                          NSForegroundColorAttributeName:COLOR_WITH_HEX(0x999999)
                                          }];
        [self.passWordView addSubview:tfiled];
        _passWordFiled = tfiled;
    }
    return _passWordFiled;
}
-(UIButton *)passWordBtn{
    if (!_passWordBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setImage:[UIImage imageNamed:@"passChange"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"passNO"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(passwordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.passWordView addSubview:btn];
        _passWordBtn = btn;
    }
    return _passWordBtn;
}


//提示框
-(UITextView *)tipTextView{
    if (!_tipTextView) {
        UITextView *tipText = [[UITextView alloc]init];
        tipText.textColor = [UIColor redColor];
        tipText.font = YX30Font;
        tipText.textAlignment = NSTextAlignmentCenter;
        [self.backImgView addSubview:tipText];
        _tipTextView = tipText;
    }
    return _tipTextView;
}


//登录
-(UIButton *)loadBtn{
    if (!_loadBtn) {
        UIButton *loadBtn = [[UIButton alloc]init];
        [loadBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loadBtn setBackgroundImage:[UIImage imageNamed:@"loadBtn"] forState:UIControlStateNormal];
        [loadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loadBtn addTarget:self action:@selector(loadClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loadBtn];
        _loadBtn = loadBtn;
    }
    return _loadBtn;
}

////网络设置
//-(UIButton *)netSetBtn{
//    if (!_netSetBtn) {
//        UIButton *btn = [[UIButton alloc]init];
//        [btn setTitle:@"网络设置" forState:UIControlStateNormal];
//        [btn setTitleColor:COLOR_WITH_HEX(0x999999) forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(netClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
//        _netSetBtn = btn;
//    }
//    return _netSetBtn;
//}
//网络设置
-(UIButton *)rememberBtn{
    if (!_rememberBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"记住密码" forState:UIControlStateNormal];
        if ([isRememberPassword isEqualToString:@"isRemember"]) {
            btn.selected = YES;
        }
        [btn setImage:[UIImage imageNamed:@"remember"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"remember_selected"] forState:UIControlStateSelected];
        [btn setTitleColor:COLOR_WITH_HEX(0x999999) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rememberClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _rememberBtn = btn;
    }
    return _rememberBtn;
}

//忘记密码
-(UIButton *)forgetBtn{
    if (!_forgetBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_WITH_HEX(0x999999) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _forgetBtn = btn;
    }
    return _forgetBtn;
}



@end
