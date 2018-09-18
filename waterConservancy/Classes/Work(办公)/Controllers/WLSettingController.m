//
//  WLSettingController.m
//  waterConservancy
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "WLSettingController.h"
#import "WLUserInfoController.h"
#import "WLLoginViewController.h"
#import "WLResetPasswordController.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface WLSettingController ()<UNUserNotificationCenterDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *userOrgLab;
@property (weak, nonatomic) IBOutlet UISwitch *reciveNotice;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UIButton *verIcon;
@property (weak, nonatomic) IBOutlet UILabel *verNubLab;

@property (nonatomic, copy) NSString *versionStr;
@end

@implementation WLSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人中心";

    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"gobackBtn"];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    //   将leftItem设置为自定义按钮
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.activity.hidden = YES;
    self.verIcon.hidden = YES;
    self.verNubLab.text = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    
    [self checkCurrentNotificationStatus];
    [self loadVersionData];
}

-(void)loadVersionData{
    NSDictionary *param = @{@"dataKey":@"00-00-00-00",@"AppVersion":@"1",@"ApplicationID":@"5cb345b6-26d3-11e5-9325-68f728009cac"};
    [[YXNetTool shareTool] getRequestWithURL:@"http://172.16.160.179:8001/WebApi/DataExchange/GetData/WebApp_CheckAppVersion" Parmars:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } faild:^(NSError *error) {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        //基本信息
        WLUserInfoController *user = WCViewControllerOfMainSB(@"WLUserInfoController");
        [self.navigationController pushViewController:user animated:YES];
    }else if (indexPath.row==2){
        //修改密码
        WLResetPasswordController *reset = WCViewControllerOfMainSB(@"WLResetPasswordController");
        [self.navigationController pushViewController:reset animated:YES];
    }else if (indexPath.row==3){
        //清理缓存
        self.activity.hidden = NO;
        [self.activity startAnimating];
        [self clearFile];
        
    }else if (indexPath.row==4){
        //版本更新
        UIAlertView *alart = [[UIAlertView alloc]initWithTitle:nil message:@"确认升级版本吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alart.tag = 998;
        [alart show];
    }
}

-(void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activity stopAnimating];
        self.activity.hidden = YES;
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutBtnClick:(id)sender {
    UIAlertView *alart = [[UIAlertView alloc]initWithTitle:nil message:@"确认退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alart.tag = 999;
    [alart show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==999) {
        if (buttonIndex==1) {
            WLShareUserManager.autoLoginEnabled = NO;
            WLLoginViewController *loadCtrl = WCViewControllerOfMainSB(@"WLLoginViewController");
            [self.navigationController pushViewController:loadCtrl animated:YES];
        }
    }else if (alertView.tag==998){
        
    }
}

- (IBAction)switchClick:(UISwitch*)sender {
    sender.on = !sender.on;
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

-(void)checkCurrentNotificationStatus
{
    if (@available(iOS 10 , *))
    {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusDenied)
            {
                // 没权限
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.reciveNotice.on = NO;
                });
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.reciveNotice.on = YES;
                });
            }
        }];
    }
    else
    {
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (setting.types == UIUserNotificationTypeNone) {
            // 没权限
            dispatch_async(dispatch_get_main_queue(), ^{
                self.reciveNotice.on = NO;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.reciveNotice.on = YES;
            });
        }
    }
}


@end
