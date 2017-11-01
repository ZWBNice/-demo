//
//  Cargo.h
//  仓库demo
//
//  Created by user on 2017/8/15.
//  Copyright © 2017年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cargo : NSObject

@property(nonatomic, copy) NSString *cargoName; // 药品名称

@property(nonatomic, copy) NSString *cargoUnitPrice; // 药品单价

@property(nonatomic, copy) NSString *cargoRepertory; //药品库存
@property(nonatomic, copy) NSString *time; //入库时间

@end
