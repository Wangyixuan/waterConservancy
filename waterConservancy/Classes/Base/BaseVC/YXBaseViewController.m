//
//  YXBaseViewController.m
//  河掌治
//
//  Created by 乐凡宝宝 on 2018/3/18.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import "YXBaseViewController.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
//#import "YXExitAlter.h"

@interface YXBaseViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, copy) NSString *riverStatus;//河流状态
@end

@implementation YXBaseViewController

- (void)viewDidLoad {
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [super viewDidLoad];
    [self setup];
 
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [self customLeftBackButton];
  
//    self.navigationItem.backBarButtonItem = [self customLeftBackButton];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];

    //接受巡河状态变更的通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(riverStatuschange:) name:RIVERSTATUSNONATIFICATION object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.childViewControllers.count == 1) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
}

-(UIBarButtonItem*)customLeftBackButton{
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     UIImage *image = [UIImage imageNamed:@"gobackBtn"];
    [leftBtn setImage:image forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//   将leftItem设置为自定义按钮
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    return leftItem;
    
    
}
////巡河状态改变的通知
//-(void)riverStatuschange:(NSNotification *)notification{
//    NSDictionary *dic = notification.userInfo;
////    NSString *riverStatus = [dic objectForKey:RIVERSTATUSKEY];
//    if (riverStatus.length>0 && riverStatus != nil) {
//        self.riverStatus = riverStatus;
//    }
//}

-(void)popself
{
//    if ([self.navigationController.childViewControllers.lastObject isKindOfClass:NSClassFromString(@"YXUpLoadViewController")]) {
//        YXExitAlter *exitAlter = [[YXExitAlter alloc]initWithFrame:self.view.bounds];
//        [exitAlter initExitStrwithexitNameStr:@"确认退出上报" exitcontentStr:@"正在进行问题上报,退出将导致本次上报无效,确认退出？"];
//        exitAlter.exitBlock = ^{
//            if (self.childViewControllers.count == 2){
//                 [self.navigationController setNavigationBarHidden:YES animated:YES];
//            }
//
//            [self.navigationController popViewControllerAnimated:YES];
//        };
//        [self.view addSubview:exitAlter];
//        return;
//
//    }else if ([self.navigationController.childViewControllers.lastObject isKindOfClass:NSClassFromString(@"YXMapController")]&& [self.riverStatus isEqualToString:@"2"]) {
//        YXExitAlter *exitAlter = [[YXExitAlter alloc]initWithFrame:self.view.bounds];
//        [exitAlter initExitStrwithexitNameStr:@"确认退出巡河" exitcontentStr:@"若您当前正在巡河，退出可能导致巡河轨迹丢失,确认退出?"];
//        exitAlter.exitBlock = ^{
//            if (self.childViewControllers.count == 2){
//                [self.navigationController setNavigationBarHidden:YES animated:YES];
//            }
//
//            [self.navigationController popViewControllerAnimated:YES];
//        };
//        [self.view addSubview:exitAlter];
//        return;
//
//    }else
    if (self.childViewControllers.count == 2) {
        //初始页面count == 2
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
         [self.navigationController popViewControllerAnimated:YES];
    }
    
}
////当为根控制器时 禁用右滑手势
//当当前页面是根目录的时候，禁用右滑手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.navigationController.viewControllers.count <= 1)
    {
        return NO;
    }
    return YES;

}


//-(UIBarButtonItem*)customLeftBackButton{
//
//    UIImage *image = [UIImage imageNamed:@"back"];
//
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    backButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    [backButton setBackgroundImage:image
//                          forState:UIControlStateNormal];
//
//
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    backItem.style = UIBarButtonItemStylePlain;
////    NSLog(@"backButton==%@ backItem==%@",backButton,backItem);
//    return backItem;
//}


-(void)setup{
    if (IOS_VERSION >= 7.0f) {
        self.edgesForExtendedLayout           = UIRectEdgeNone;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.width                                = [UIScreen mainScreen].bounds.size.width;
    self.height                               = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor                 = [UIColor whiteColor];
}




-(NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}


-(void)registerCellWithNib:(NSString *)nibName tableView:(UITableView *)tableView{
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

-(void)registerCellWithClass:(NSString *)className tableView:(UITableView *)tableView{
    [tableView registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
}





#pragma setter

-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil
                                                                titleStr:@"暂无数据"
                                                               detailStr:@""];
        _tableView.ly_emptyView.autoShowEmptyView = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
