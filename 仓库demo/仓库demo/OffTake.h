//
//  OffTake.h
//  仓库demo
//
//  Created by user on 2017/8/16.
//  Copyright © 2017年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OffTake : NSObject
@property(nonatomic, copy) NSString *cargoName; // 药品名称

@property(nonatomic, copy) NSString *time; // 存入时间

@property(nonatomic, copy) NSString *cargoNumber; //药品库数量

@property(nonatomic, copy) NSString *totalPrice; // 总价


@end
