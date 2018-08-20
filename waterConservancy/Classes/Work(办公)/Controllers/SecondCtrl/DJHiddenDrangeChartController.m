//
//  DJHiddenDrangeChartController.m
//  waterConservancy
//
//  Created by liu on 2018/8/16.
//  Copyright © 2018年 com.yx.waterConservancy. All rights reserved.
//

#import "DJHiddenDrangeChartController.h"
#import "DJHiddenDrangeChartCell.h"

//#import "DJHiddenDangerModel.h"
#import "DJMonthListModel.h"

@interface DJHiddenDrangeChartController ()
@property (nonatomic, strong) NSArray *monthListArray;
@end
static NSString *const HIDDENDRANGECELLREUSEID = @"HIDDENDRANGECELL";

@implementation DJHiddenDrangeChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐患报表";
    
    [self initHiddenDangerChartUI];
    
    //隐患
//    NSString *orgid = (NSString *)ORGID;
//    if (orgid.length == 0) {
//        return;
//    }
//    NSDictionary *parmars = TNParams(@"hiddStat":@"1",@"orgGuid":orgid);
//
////    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/objHidds/")  Parmars:parmars success:^(id responseObject) {
//    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/obj/hazy-objHidds/")  Parmars:nil success:^(id responseObject) {
//        @strongify(self);
//        NSArray *dataArray = [responseObject objectForKey:@"data"];
//        self.hiddenDangerArray = [NSArray modelArrayWithClass:[DJHiddenDangerModel class] json:dataArray];
//        [self.tableView reloadData];
//    } faild:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
     @weakify(self);
//    NSDictionary *parmars = TNParams(@"username":CURRENTUSER);
    [[YXNetTool shareTool]getRequestWithURL:YXNetAddress(@"sjjk/v1/bis/org/mon/rep/hazy-bisOrgMonRepPeris/")  Parmars:nil success:^(id responseObject) {
        @strongify(self);
        NSArray *dataArray = [responseObject objectForKey:@"data"];
        self.monthListArray = [NSArray modelArrayWithClass:[DJMonthListModel class] json:dataArray];
        [self.tableView reloadData];
        NSLog(@"%@",responseObject);
    } faild:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.monthListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DJHiddenDrangeChartCell *cell = [tableView dequeueReusableCellWithIdentifier:HIDDENDRANGECELLREUSEID];
    if (!cell) {
        cell = [[DJHiddenDrangeChartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HIDDENDRANGECELLREUSEID];
    }
    DJMonthListModel *model = self.monthListArray[indexPath.row];
    [cell initDataWithModel:model];
    @weakify(self);
    cell.hiddenChartBtnClickBlock = ^(DJMonthListModel *model) {
        @strongify(self);
        [self uploadHiddenDangerWithModel:model];
    };
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCALE_W(200);
}

#pragma mark 请求
-(void)uploadHiddenDangerWithModel:(DJMonthListModel *)model{
    //422错误？？
//    NSDictionary *parmars = TNParams(@"hiddGuid":model.guid,@"collTime":model.collTime);
//    [[YXNetTool shareTool]postRequestWithURL:YXNetAddress(@"sjjk/v1/bis/hidd/rec/bisHiddRecRep/") Parmars:parmars success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//    } faild:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    NSDictionary *headers = @{ @"content-type": @"multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                               @"Content-Type": @"application/json",
                               @"Cache-Control": @"no-cache",
                               @"Postman-Token": @"5430d6ab-11da-4a37-bf26-cdc9ea47743b" };
    NSArray *parameters = @[ @{ @"name": @"hiddGuid", @"value": @"B8C488E3EFAF4E309D5DCFA3F65E03D9" },
                             @{ @"name": @"collTime", @"value": @"2018-03-28 12:22:33" } ];
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
    
    NSError *error;
    NSMutableString *body = [NSMutableString string];
    for (NSDictionary *param in parameters) {
        [body appendFormat:@"--%@\r\n", boundary];
        if (param[@"fileName"]) {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@\"\r\n", param[@"name"], param[@"fileName"]];
            [body appendFormat:@"Content-Type: %@\r\n\r\n", param[@"contentType"]];
            [body appendFormat:@"%@", [NSString stringWithContentsOfFile:param[@"fileName"] encoding:NSUTF8StringEncoding error:&error]];
            if (error) {
                NSLog(@"%@", error);
            }
        } else {
            [body appendFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n\r\n", param[@"name"]];
            [body appendFormat:@"%@", param[@"value"]];
        }
    }
    [body appendFormat:@"\r\n--%@--\r\n", boundary];
    NSData *postData = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.8:8080/sjjk/v1/bis/hidd/rec/bisHiddRecRep/"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
    
//    NSDictionary *parmars = TNParams(@"repName":model.repName,@"collTime":model.collTime);
//    [[YXNetTool shareTool]postRequestWithURL:YXNetAddress(@"sjjk/v1/bis/org/mon/rep/bisOrgMonRepPeri/") Parmars:parmars success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//    } faild:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}




#pragma mark UI
-(void)initHiddenDangerChartUI{
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weak_self.view);
    }];
}
-(NSArray *)monthListArray{
    if (!_monthListArray) {
        NSArray *monthListArray = [NSArray array];
        _monthListArray = monthListArray;
    }
    return _monthListArray;
}

@end
