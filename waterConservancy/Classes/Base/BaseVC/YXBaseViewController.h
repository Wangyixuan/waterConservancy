//
//  YXBaseViewController.h
//  河掌治
//
//  Created by 乐凡宝宝 on 2018/3/18.
//  Copyright © 2018年 liuDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXBaseViewController : UIViewController
/**屏幕宽*/
@property (nonatomic,assign) CGFloat width;
/**屏幕高*/
@property (nonatomic,assign) CGFloat height;

//@property (nonatomic, copy) NSString *title;

/**
 tableView
 */
//自定义导航栏
//@property (nonatomic,strong) UIView *navView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataSource;

-(void)registerCellWithNib:(NSString *)nibName tableView:(UITableView *)tableView;

-(void)registerCellWithClass:(NSString *)className tableView:(UITableView *)tableView;

-(int)getRandomNumber:(int)from to:(int)to;

@end
