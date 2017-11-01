//
//  UITableView+Extension.h
//  Shopping
//
//  Created by 邝子涵 on 2016/12/6.
//  Copyright © 2016年 鸿惠(上海)信息技术服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Extension)
- (void)tableViewNoDataOrNewworkFail:(NSInteger)rowCount;
- (void)tableViewNoDataOrNewworkFailDown:(NSInteger)rowCount;
@end
