//
//  UITableView+Extension.m
//  Shopping
//
//  Created by 邝子涵 on 2016/12/6.
//  Copyright © 2016年 鸿惠(上海)信息技术服务有限公司. All rights reserved.
//

#import "UITableView+Extension.h"
#import "NodataView.h"
#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height

@implementation UITableView (Extension)

- (void)tableViewNoDataOrNewworkFail:(NSInteger)rowCount{
    if (rowCount == 0) {
        
        NodataView *view = [[NodataView alloc] initWithFrame:self.frame];
        self.backgroundView = view;
    }else{
        self.backgroundView = nil;
    }
}

- (void)tableViewNoDataOrNewworkFailDown:(NSInteger)rowCount{
    if (rowCount == 0) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"notfound"];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.frame = CGRectMake(0, 250, WIDTH, HEIGHT);
        UIView *view = [[UIView alloc] initWithFrame:self.frame];
        [view addSubview:imgView];
        self.backgroundView = view;
    }else{
        self.backgroundView = nil;
    }
}


@end
