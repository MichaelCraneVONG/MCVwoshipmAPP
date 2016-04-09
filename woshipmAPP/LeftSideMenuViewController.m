//
//  LeftSideMenuViewController.m
//  woshipmAPP
//
//  Created by myApple on 16/4/9.
//  Copyright © 2016年 myApple. All rights reserved.
//

#import "LeftSideMenuViewController.h"
#define resuseCellID @"LeftSidecell"
@interface LeftSideMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableV;
@property (nonatomic,strong)NSArray *arrMenu;
@end
@implementation LeftSideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrMenu=@[@"首页",@"业界动态",@"交互视觉",@"产品经理",@"产品设计",
                   @"产品运营",@"人人专栏",@"原型设计",@"职场攻略",@"创业学院",
                   @"求职招聘",@"产品大学",@"起点公开课"];
    
    /*设置背景颜色及图片*/
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *imgBgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    imgBgV.image=[UIImage imageNamed:@"bg_left_deck_top"];
    [self.view addSubview:imgBgV];
    
    /*设置Logo和标题*/
    [self setLogoAndTitle];
    
    /*初始化和设置tableView*/
    self.tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 200, self.view.frame.size.height-109) style:UITableViewStylePlain];
    self.tableV.dataSource=self;
    self.tableV.delegate=self;
    self.tableV.backgroundColor=[UIColor clearColor];
    self.tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableV.bounces=NO;
    self.tableV.showsHorizontalScrollIndicator=NO;
    self.tableV.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.tableV];
    
    /*设置工具条*/
    [self setUpToolBar];

    
}



-(void)onTap
{
    
}


//设置Logo和标题
-(void)setLogoAndTitle
{
    UIImageView *imgLogoV=[[UIImageView alloc]initWithFrame:CGRectMake(15,25,40,40)];
    imgLogoV.image=[UIImage imageNamed:@"ic_clear_bg"];
    [self.view addSubview:imgLogoV];
    
    UILabel *labTitle=[[UILabel alloc]initWithFrame:CGRectMake(58,25,200-58,40)];
    [self.view addSubview:labTitle];
    labTitle.text=@"人人都是产品经理";
    labTitle.textColor=[UIColor whiteColor];
}


//设置工具条
-(void)setUpToolBar
{
    UIBarButtonItem *itemspace=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(onTap)];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(onTap)];
    item1.tintColor=[UIColor whiteColor];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(onTap)];
    item2.tintColor=[UIColor whiteColor];
    UIToolbar *leftSideToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, 200, 44)];
    
    leftSideToolBar.items=@[itemspace,item1,itemspace,item2,itemspace];
    leftSideToolBar.barTintColor=[UIColor clearColor];
    [self.view addSubview:leftSideToolBar];
}


#pragma mark --TableViewDataSource tableView的数据源
//单元格的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrMenu.count;
}

//单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:resuseCellID];

    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuseCellID];
    }
    cell.textLabel.text=[self.arrMenu objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
