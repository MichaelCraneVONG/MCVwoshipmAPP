//
//  LeftSideMenuViewController.m
//  woshipmAPP
//
//  Created by myApple on 16/4/9.
//  Copyright © 2016年 myApple. All rights reserved.
//

#import "LeftSideMenuViewController.h"

@interface LeftSideMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableV;
@property (nonatomic,strong)NSArray *arrMenu;
@end
@implementation LeftSideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    UIImageView *imgBgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    imgBgV.image=[UIImage imageNamed:@"bg_left_deck_top"];
    [self.view addSubview:imgBgV];
    
    UIImageView *imgLogoV=[[UIImageView alloc]initWithFrame:CGRectMake(15,25,40,40)];
    imgLogoV.image=[UIImage imageNamed:@"ic_clear_bg"];
    [self.view addSubview:imgLogoV];
    
    UILabel *labTitle=[[UILabel alloc]initWithFrame:CGRectMake(58,25,200-58,40)];
    [self.view addSubview:labTitle];
    labTitle.text=@"人人都是产品经理";
    labTitle.textColor=[UIColor whiteColor];
    
    self.tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, 200, self.view.frame.size.height-109) style:UITableViewStylePlain];
    self.tableV.dataSource=self;
    self.tableV.delegate=self;
    self.tableV.backgroundColor=[UIColor clearColor];
    self.tableV.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableV.bounces=NO;
    self.tableV.showsHorizontalScrollIndicator=NO;
    self.tableV.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.tableV];
    
    UIBarButtonItem *itemspace=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(onTap)];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(onTap)];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(onTap)];
    UIToolbar *lefSideToolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, 200, 44)];
    
    lefSideToolBar.items=@[itemspace,item1,itemspace,item2,itemspace];
    lefSideToolBar.barTintColor=[UIColor clearColor];
    [self.view addSubview:lefSideToolBar];
    
}

-(void)onTap
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LeftSidecell"];

    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeftSidecell"];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"我是%ldCell",indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
