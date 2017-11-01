//
//  AddCargoViewController.m
//  仓库demo
//
//  Created by user on 2017/8/15.
//  Copyright © 2017年 user. All rights reserved.
//
#import "SLStockTool.h"
#import <SVProgressHUD.h>
#import "AddCargoViewController.h"
#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height

@interface AddCargoViewController ()
@property (nonatomic, strong) UITextField *nameT;
@property (nonatomic, strong) UITextField *unitPrice;
@property (nonatomic, strong) UITextField *cargoNumer;
@property (nonatomic, strong) UIButton *configBtn;
@property (nonatomic, strong) SLStockTool *tool;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation AddCargoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增药物";
    self.view.backgroundColor = [UIColor whiteColor];
    self.nameT = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH/2-100, 114, 200, 30)];
    self.nameT.placeholder = @"请输入药物名称";
    [self.view addSubview:self.nameT];
    self.unitPrice = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH/2-100, 164, 200, 30)];
    self.unitPrice.placeholder = @"请输入药物单价";
    [self.view addSubview:self.unitPrice];
    self.unitPrice.keyboardType = UIKeyboardTypeDecimalPad;

    self.cargoNumer = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH/2-100, 214, 200, 30)];
    self.cargoNumer.placeholder = @"请输入药物数量";
    [self.view addSubview:self.cargoNumer];
    self.cargoNumer.keyboardType = UIKeyboardTypeNumberPad;

    self.configBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH/2-75, 264, 150, 40)];
    [self.view addSubview:self.configBtn];
    [self.configBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.configBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.configBtn.backgroundColor = [UIColor blackColor];
    self.configBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self borderwithView:self.nameT];
    [self borderwithView:self.cargoNumer];
    [self borderwithView:self.unitPrice];
    [self borderwithView:self.configBtn withColor:[UIColor blackColor]];
    self.nameT.font = [UIFont systemFontOfSize:14];
    self.nameT.textAlignment = NSTextAlignmentCenter;
    self.unitPrice.font = [UIFont systemFontOfSize:14];
    self.unitPrice.textAlignment = NSTextAlignmentCenter;
    self.cargoNumer.font = [UIFont systemFontOfSize:14];
    self.cargoNumer.textAlignment = NSTextAlignmentCenter;
    self.tool = [SLStockTool tool];
    FMDatabase *dataBase = [self.tool getDBWithDBName:@"table.sqlite"];
    NSDictionary *sql = @{@"cargoName":@"text primary key",@"cargoUnitPrice":@"text",@"cargoRepertory":@"text",@"time":@"text"};
    [self.tool DataBase:dataBase createTable:@"cargo" keyTypes:sql];

}

- (void)click{

    FMDatabase *dataBase = [self.tool getDBWithDBName:@"table.sqlite"];
    NSDate *senddate=[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: senddate];
    NSDate *localDate = [senddate dateByAddingTimeInterval: interval];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:localDate];
    NSLog(@"locationString:%@",locationString);
    
    


    NSDictionary *sql = @{@"cargoName":self.nameT.text,@"cargoUnitPrice":self.unitPrice.text,@"cargoRepertory":self.cargoNumer.text,@"time":[self getCurrentTimes]};
    BOOL isNoHave = [self getData];
    if (isNoHave) {
        BOOL success = [self.tool DataBase:dataBase insertKeyValues:sql intoTable:@"cargo"];
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
    }else{
        
      BOOL success =  [self.tool DataBase:dataBase updateTable:@"cargo" setKeyValues:@{@"cargoName":self.nameT.text,@"cargoUnitPrice":self.unitPrice.text,@"cargoRepertory":self.cargoNumer.text,@"time":locationString} whereCondition:@{@"cargoName":self.nameT.text}];
        
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"成功"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"失败"];
        }
    }
    
}

- (BOOL)getData{
    NSDictionary *sql = @{@"cargoName":@"text",@"cargoUnitPrice":@"text",@"cargoRepertory":@"text",@"time":@"text"};
    FMDatabase *dataBase = [self.tool getDBWithDBName:@"table.sqlite"];
    NSArray *arr =  [self.tool DataBase:dataBase selectKeyTypes:sql fromTable:@"cargo" whereCondition:@{@"cargoName":self.nameT.text}];
    if (arr.count == 0) {
        return YES;
    }else{
        return NO;
    }
}



- (void)borderwithView:(UIView*)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor grayColor].CGColor;

}

- (void)borderwithView:(UIView*)view withColor:(UIColor*)color{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    view.layer.borderWidth = 1;
    view.layer.borderColor = color.CGColor;
    
}


- (NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}



@end
