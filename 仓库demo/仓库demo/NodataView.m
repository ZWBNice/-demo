//
//  NodataView.m
//  仓库demo
//
//  Created by user on 2017/8/16.
//  Copyright © 2017年 user. All rights reserved.
//

#import "NodataView.h"
#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height

@implementation NodataView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.image.center = CGPointMake(self.center.x, self.center.y);
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        self.name.center = CGPointMake(self.center.x, self.center.y+70);
        [self addSubview:self.name];
        [self addSubview:self.image];
        self.image.image = [UIImage imageNamed:@"noData"];
        self.name.text = @"暂无数据";
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = [UIColor grayColor];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.image.image = [UIImage imageNamed:@"noData"];
    }
    return self;
}

@end
