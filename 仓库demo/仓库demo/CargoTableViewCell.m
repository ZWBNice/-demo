//
//  CargoTableViewCell.m
//  仓库demo
//
//  Created by user on 2017/8/15.
//  Copyright © 2017年 user. All rights reserved.
//

#import "CargoTableViewCell.h"
#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height

@interface CargoTableViewCell ()
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *unitPriceL;
@property (nonatomic, strong) UILabel *kucunL;
@property (nonatomic, strong) UILabel *timeL;

@end

@implementation CargoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.nameL = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameL];
        
        self.unitPriceL = [[UILabel alloc] init];
        [self.contentView addSubview:self.unitPriceL];
        
        self.kucunL = [[UILabel alloc] init];
        [self.contentView addSubview:self.kucunL];
        self.timeL = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeL];
        self.nameL.font = self.unitPriceL.font = self.kucunL.font = self.timeL.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.nameL.frame = CGRectMake(10, 10, WIDTH-20, 20);
    self.unitPriceL.frame = CGRectMake(10, self.nameL.frame.size.height+10+self.nameL.frame.origin.y, WIDTH-20, 20);
    self.kucunL.frame = CGRectMake(10, self.unitPriceL.frame.size.height+10+self.unitPriceL.frame.origin.y, WIDTH-20, 20);
    
    self.timeL.frame = CGRectMake(10, self.kucunL.frame.size.height+10+self.kucunL.frame.origin.y, WIDTH-20, 20);

}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.nameL.text = [NSString stringWithFormat:@"药物名称：%@",dic[@"cargoName"]];
    self.unitPriceL.text = [NSString stringWithFormat:@"药物单价：%@",dic[@"cargoUnitPrice"]];
    self.kucunL.text = [NSString stringWithFormat:@"药物库存：%@",dic[@"cargoRepertory"]];
    self.timeL.text = [NSString stringWithFormat:@"入库时间：%@",dic[@"time"]];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
