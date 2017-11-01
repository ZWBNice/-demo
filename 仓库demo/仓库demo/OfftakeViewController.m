//
//  OfftakeViewController.m
//  仓库demo
//
//  Created by user on 2017/8/16.
//  Copyright © 2017年 user. All rights reserved.
//

#import "OfftakeViewController.h"
#import "SLStockTool.h"
#import <SVProgressHUD.h>
@interface OfftakeViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nameT;
@property (nonatomic, strong) UITextField *cargoNumer;
@property (nonatomic, strong) UILabel *totalPriceL;
@property (nonatomic, strong) UIButton *configBtn;
@property (nonatomic, strong) SLStockTool *tool;

@end
#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height

@implementation OfftakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增药物";
    self.view.backgroundColor = [UIColor whiteColor];
    self.nameT = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH/2-100, 114, 200, 30)];
    self.nameT.placeholder = @"请输入药物名称";
    [self.view addSubview:self.nameT];
    
    self.cargoNumer = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH/2-100, 164, 200, 30)];
    self.cargoNumer.placeholder = @"请输入药物数量";
    [self.view addSubview:self.cargoNumer];
    self.cargoNumer.keyboardType = UIKeyboardTypeNumberPad;
    
    self.totalPriceL = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH/2-100, 214, 200, 30)];
    [self.view addSubview:self.totalPriceL];
    
    
    self.configBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH/2-75, 264, 150, 40)];
    [self.view addSubview:self.configBtn];
    [self.configBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.configBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.configBtn.backgroundColor = [UIColor blackColor];
    self.configBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self borderwithView:self.nameT];
    [self borderwithView:self.totalPriceL];

    [self borderwithView:self.cargoNumer];
    [self borderwithView:self.configBtn withColor:[UIColor blackColor]];
    self.nameT.font = [UIFont systemFontOfSize:14];
    self.nameT.textAlignment = NSTextAlignmentCenter;
    self.cargoNumer.font = [UIFont systemFontOfSize:14];
    self.cargoNumer.textAlignment = NSTextAlignmentCenter;
    self.totalPriceL.font = [UIFont systemFontOfSize:14];
    self.totalPriceL.textAlignment = NSTextAlignmentCenter;
    self.totalPriceL.text = @"0.00";
    self.tool = [SLStockTool tool];
    FMDatabase *dataBase = [self.tool getDBWithDBName:@"offTaketable.sqlite"];
    NSDictionary *sql = @{@"cargoName":@"text",@"cargoUnitPrice":@"text",@"cargoRepertory":@"text",@"totalPrice":@"text",@"time":@"text"};
    [self.tool DataBase:dataBase createTable:@"offtake" keyTypes:sql];

}

- (void)click{
    
    [self getData];
}

- (void)getData{
    NSDictionary *sql = @{@"cargoName":@"text",@"cargoUnitPrice":@"text",@"cargoRepertory":@"text"};
    FMDatabase *dataBase = [self.tool getDBWithDBName:@"table.sqlite"];
  NSArray *arr =  [self.tool DataBase:dataBase selectKeyTypes:sql fromTable:@"cargo" whereCondition:@{@"cargoName":self.nameT.text}];
    
    if (arr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"未找到药物，请确认"];

    }else{
        NSDictionary *dic = arr[0];
        if ([dic[@"cargoRepertory"] integerValue] < [self.cargoNumer.text integerValue]) {
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"仓库库存不足是否继续卖出" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

               BOOL suc = [self.tool DataBase:dataBase updateTable:@"cargo" setKeyValues:@{@"cargoName":self.nameT.text,@"cargoRepertory":[NSString stringWithFormat:@"%d",[dic[@"cargoRepertory"] integerValue] - [self.cargoNumer.text integerValue]]} whereCondition:@{@"cargoName":self.nameT.text}];
                if (suc) {
                    NSString *unitPrice = dic[@"cargoUnitPrice"];
                    self.totalPriceL.text = [NSString stringWithFormat:@"%.2f",[self.cargoNumer.text floatValue] * [unitPrice floatValue]];
                    FMDatabase *dataBase2 = [self.tool getDBWithDBName:@"offTaketable.sqlite"];
                    NSDictionary *sql2 = @{@"cargoName":self.nameT.text,@"cargoUnitPrice":unitPrice,@"cargoRepertory":self.cargoNumer.text,@"totalPrice":self.totalPriceL.text,@"time":[self getCurrentTimes]};
                    BOOL success = [self.tool DataBase:dataBase2 insertKeyValues:sql2 intoTable:@"offtake"];
                    if (success) {
                        [SVProgressHUD showSuccessWithStatus:@"成功"];
                    }else{
                        [SVProgressHUD showErrorWithStatus:@"失败"];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:@"更新库存失败"];
                }
            
            }];
            
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            [ac addAction:okaction];
            [ac addAction:cancleAction];
            [self presentViewController:ac animated:YES completion:nil];

        }else{
            BOOL suc = [self.tool DataBase:dataBase updateTable:@"cargo" setKeyValues:@{@"cargoName":self.nameT.text,@"cargoRepertory":[NSString stringWithFormat:@"%d",[dic[@"cargoRepertory"] integerValue] - [self.cargoNumer.text integerValue]]} whereCondition:@{@"cargoName":self.nameT.text}];
            if (suc) {
                NSString *unitPrice = dic[@"cargoUnitPrice"];
                self.totalPriceL.text = [NSString stringWithFormat:@"%.2f",[self.cargoNumer.text floatValue] * [unitPrice floatValue]];
                FMDatabase *dataBase2 = [self.tool getDBWithDBName:@"offTaketable.sqlite"];
                NSDictionary *sql2 = @{@"cargoName":self.nameT.text,@"cargoUnitPrice":unitPrice,@"cargoRepertory":self.cargoNumer.text,@"totalPrice":self.totalPriceL.text,@"time":[self getCurrentTimes]};
                BOOL success = [self.tool DataBase:dataBase2 insertKeyValues:sql2 intoTable:@"offtake"];
                if (success) {
                    [SVProgressHUD showSuccessWithStatus:@"成功"];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"更新库存失败"];
            }
        }
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
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    
    return currentTimeString;
}


@end
