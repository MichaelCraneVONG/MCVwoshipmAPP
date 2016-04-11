//
//  MainTableViewController.m
//  woshipmAPP
//
//  Created by myApple on 16/4/9.
//  Copyright © 2016年 myApple. All rights reserved.
//
#import <SVWebViewController/SVWebViewControllerActivity.h>
#import <SVWebViewController/SVWebViewController.h>
#import "MainTableViewController.h"
#import "onePicTableViewCell.h"
#import "threePicTableViewCell.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MMDrawerController/MMDrawerBarButtonItem.h>
#import "ListBaseObject.h"
static NSString * const reuseIdOnePic = @"onePicCell";
static NSString * const reuseIdThreePic=@"threePicCell";
@interface MainTableViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)NSString *jsonStr;
@property (nonatomic,assign)NSUInteger page;
@property (nonatomic,assign)NSMutableArray *marrData;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _marrData=[NSMutableArray array];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:44/255.0 green:124/255.0 blue:228/255.0 alpha:1.0];
    [self setupLeftMenuButton];
    [self resignNib];
    
    //下拉刷新
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self LoadData:YES];
    }];
    
    //上拉刷新
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self LoadData:NO
         ];
    }];
    
    //默认隐藏footer
    self.tableView.mj_footer.hidden=NO;
    [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@"已全部加载完毕" forState:MJRefreshStateNoMoreData];
    [self.tableView.mj_header beginRefreshing];
    

    
    
    
}


- (void)LoadData:(BOOL)refresh
{
    CGFloat KWPixWidth=[UIScreen mainScreen].scale*[UIScreen mainScreen].bounds.size.width;
    CGFloat KWPixHeight=[UIScreen mainScreen].scale*[UIScreen mainScreen].bounds.size.height;
    NSString *strKWPix=[NSString stringWithFormat:@"%g*%g",KWPixWidth,KWPixHeight];
    NSString *strCurrSysName=[[UIDevice currentDevice]systemName];
    NSDictionary *paramsDict;
    if (refresh) {
        paramsDict=@{@"_cP":strKWPix,@"_cV":@"2.2",@"_cT":strCurrSysName,@"PS":@"20"};

    } else {
        NSString *strLtime=[[self.marrData lastObject]strPublishTime];
        NSLog(@"%@",strLtime);
        paramsDict=@{@"_cP":strKWPix,@"_cV":@"2.2",@"_cT":strCurrSysName,@"PS":@"20",@"LTime":strLtime};
    }
    
    NSString *urlString = @"http://api.woshipm.com/news/list.html?";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:paramsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (refresh) {
            [self.marrData removeAllObjects];
        }
            
        if (responseObject!=0) {
           [self jsonData:responseObject];
           dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
                 [self.tableView.mj_header endRefreshing];
               [self.tableView.mj_footer endRefreshing];
             });
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tableView reloadData];
                 [self.tableView.mj_header endRefreshing];
                 [self.tableView.mj_footer endRefreshing];
             });
    }];
    
}


-(void) jsonData:(NSData *)data
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.jsonStr=str;
    NSError *JsonError;
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&JsonError];
        if (!JsonError) {
            NSArray *array=[dict objectForKey:@"RESULT"];
            
            ListBaseObject *listObj;
            for (NSDictionary *dic in array) {
                listObj=[[ListBaseObject alloc]init];
                listObj.strTitle=[dic objectForKey:@"title"];
                listObj.strLink=[dic objectForKey:@"link"];
                listObj.strPublishTime=[dic objectForKey:@"publishTime"];
                listObj.strImage=[dic objectForKey:@"image"];
                [_marrData addObject:listObj];
            }
            

            
        }
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

    return self.marrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListBaseObject *listObj=(ListBaseObject *)[self.marrData objectAtIndex:indexPath.row];
    
    if ([listObj.strImage rangeOfString:@","].location!=NSNotFound) {
        return 120;
    }
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=nil;
    NSString *CellID=reuseIdOnePic;
    ListBaseObject *listObj=(ListBaseObject *)[self.marrData objectAtIndex:indexPath.row];

    if ([listObj.strImage rangeOfString:@","].location!=NSNotFound) {
        CellID=reuseIdThreePic;
    }
    else
    {
        CellID=reuseIdOnePic;
    }
    
    cell= [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    

    
    if (CellID==reuseIdOnePic) {
        onePicTableViewCell *onePicCell=(onePicTableViewCell *)cell;
                onePicCell.lab_Titile.text=listObj.strTitle;
        
        onePicCell.imgV_Image.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[listObj.strImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];

        return onePicCell;
    }
    
    threePicTableViewCell *threePicCell=(threePicTableViewCell *)cell;
    threePicCell.lab_Titile.text=listObj.strTitle;
    NSArray *imgV_ImageArr=@[threePicCell.imgV_Image1,threePicCell.imgV_Image2,threePicCell.imgV_Image3];
    NSArray *marrStrImage=[listObj.strImage componentsSeparatedByString:@","];
    int i=0;
    for (NSString *str in marrStrImage) {
        
        NSString *strTemp=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        strTemp=[strTemp stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        UIImageView *imgV=imgV_ImageArr[i];
        [imgV sd_setImageWithURL:[NSURL URLWithString:strTemp] placeholderImage:[UIImage imageNamed:@"img_loading"]];
        i++;
    }
    
    
    return threePicCell;
}

#pragma mark --TableViewDelegate tableView的代理事件
//去掉分区头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

//去掉分区尾
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListBaseObject *listObj=(ListBaseObject *)[_marrData objectAtIndex:indexPath.row];
    NSLog(@"%@",listObj.strLink);
    NSURL *URL = [NSURL URLWithString:[listObj.strLink stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    webViewController.delegate=self;

    
    [self.navigationController pushViewController:webViewController animated:YES];
   
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('p_back float_l')[0].remove()"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('float_r mar-t10')[0].style.float='Left'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('tips_app')[0].remove()"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('br')[0].remove()"];
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"var colorName=document.getElementsByClassName('list_box')[0].children[0].style.background"]);
    
}

@end
