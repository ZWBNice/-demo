//
//  CargoViewController.m
//  仓库demo
//
//  Created by user on 2017/8/15.
//  Copyright © 2017年 user. All rights reserved.
//

#import "CargoViewController.h"
#import "CargoTableViewCell.h"
#import "AddCargoViewController.h"
#import "SLStockTool.h"
#import "UITableView+Extension.h"

#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height

@interface CargoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLStockTool *tool;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation CargoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tool = [SLStockTool tool];
    self.title = @"仓库";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] init];

    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[CargoTableViewCell class] forCellReuseIdentifier:@"CargoTableViewCell"];
    [self.view addSubview:self.tableView];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"新增药物" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)add{
    AddCargoViewController *vc = [[AddCargoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   CargoTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"CargoTableViewCell"];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.dic = dic;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}


- (void)getData{
    NSDictionary *sql = @{@"cargoName":@"text",@"cargoUnitPrice":@"text",@"cargoRepertory":@"text",@"time":@"text"};
    FMDatabase *dataBase = [self.tool getDBWithDBName:@"table.sqlite"];
    self.dataSource = [self.tool DataBase:dataBase selectKeyTypes:sql fromTable:@"cargo"];
    
    [self.tableView tableViewNoDataOrNewworkFail:self.dataSource.count];
    [self.tableView reloadData];

}



@end
