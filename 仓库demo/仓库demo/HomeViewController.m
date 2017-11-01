//
//  HomeViewController.m
//  仓库demo
//
//  Created by user on 2017/8/15.
//  Copyright © 2017年 user. All rights reserved.
//

#import "HomeViewController.h"
#import "OfftakeViewController.h"
#import "SLStockTool.h"
#import "UITableView+Extension.h"
#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height
#import "HomeTableViewCell.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLStockTool *tool;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"销售记录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tool = [SLStockTool tool];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49) style:UITableViewStylePlain];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    [self.view addSubview:self.tableView];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 25)];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"售卖药物" forState:UIControlStateNormal];
    [btn  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)getData{
    self.dataSource = [NSMutableArray array];
    NSDictionary *sql = @{@"cargoName":@"text",@"cargoUnitPrice":@"text",@"cargoRepertory":@"text",@"totalPrice":@"text",@"time":@"text"};
    FMDatabase *dataBase = [self.tool getDBWithDBName:@"offTaketable.sqlite"];
   NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.tool DataBase:dataBase selectKeyTypes:sql fromTable:@"offtake"]];
    NSArray *reverseObject = [[arr reverseObjectEnumerator] allObjects];
    NSMutableArray *timeArray = [NSMutableArray array];
    for (NSDictionary *dic in reverseObject) {
        [timeArray addObject:dic[@"time"]];
    }
    // 数组去重
    timeArray = [timeArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
    
    for (NSString *time in timeArray) {
        NSMutableArray *timeGroup = [NSMutableArray array];
        for (NSDictionary *dic in reverseObject) {
            if ([time isEqualToString:dic[@"time"]]) {
                [timeGroup addObject:dic];
            }
        }
        
        [self.dataSource addObject:timeGroup];
    }
    [self.tableView tableViewNoDataOrNewworkFail:self.dataSource.count];
    [self.tableView reloadData];
}


- (void)add{
    OfftakeViewController *vc = [[OfftakeViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.dataSource[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    cell.dic = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 25)];
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    timeLabel.font = [UIFont systemFontOfSize:16];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat tot = 0.0;
    for (NSDictionary *dic in self.dataSource[section]) {
        NSString *total =  dic[@"totalPrice"];  
        tot += [total floatValue];
    }
    timeLabel.text = [NSString stringWithFormat:@"%@  当日日销售总额： %.2f", self.dataSource[section][0][@"time"],tot];

    return timeLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25.0f;
}



@end
