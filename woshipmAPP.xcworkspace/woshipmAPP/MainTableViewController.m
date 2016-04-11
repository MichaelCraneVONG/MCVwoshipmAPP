//
//  MainTableViewController.m
//  woshipmAPP
//
//  Created by myApple on 16/4/9.
//  Copyright © 2016年 myApple. All rights reserved.
//

#import "MainTableViewController.h"
#import "onePicTableViewCell.h"
#import "threePicTableViewCell.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MMDrawerController/MMDrawerBarButtonItem.h>
static NSString * const reuseIdOnePic = @"onePicCell";
static NSString * const reuseIdThreePic=@"threePicCell";
@interface MainTableViewController ()
@property (nonatomic,strong)NSString *jsonStr;
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:44/255.0 green:124/255.0 blue:228/255.0 alpha:1.0];
    [self setupLeftMenuButton];
    [self resignNib];
    
    NSString *urlString = @"http://api.woshipm.com/news/list.html?";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //参数1：传入网址
    //参数2：传入网址的参数
    //下载进度
    //成功之后执行block
    //失败之后执行block
    //注意：默认情况下请求获取数据必须是JSON数据，而且content-type:json/appliacation,text/json,如果不是，报—1016错误
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:@{@"_cP":@"1080*1920",@"_cV":@"2.2",@"_cT":@"Android",@"PS":@"20"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"str = %@",str);
        NSError *JsonError;
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&JsonError];
        if (!JsonError) {
            NSLog(@"json%@",dict);
        }
        
        self.jsonStr=str;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
    
}

-(void)resignNib
{
     UINib *nibOnePicCell=[UINib nibWithNibName:@"onePicCell" bundle:[NSBundle mainBundle]];
     UINib *nibThreePicCell=[UINib nibWithNibName:@"threePicCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nibOnePicCell forCellReuseIdentifier:reuseIdOnePic];
    [self.tableView registerNib:nibThreePicCell forCellReuseIdentifier:reuseIdThreePic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 80;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=nil;
    NSString *CellID=reuseIdOnePic;
    if (indexPath.row==0) {
        CellID=reuseIdOnePic;
    }
    else
    {
        CellID=reuseIdThreePic;
    }
    
    cell= [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    
    if (CellID==reuseIdOnePic) {
        onePicTableViewCell *onePicCell=(onePicTableViewCell *)cell;
        onePicCell.lab_Titile.text=@"123";
        return onePicCell;
    }
    
    threePicTableViewCell *threePicCell=(threePicTableViewCell *)cell;
    threePicCell.lab_Titile.text=@"345";
    
    
    return threePicCell;
}





@end
