//
//  HomeTableViewCell.m
//  仓库demo
//
//  Created by user on 2017/8/15.
//  Copyright © 2017年 user. All rights reserved.
//

#import "HomeTableViewCell.h"
#define WIDTH     [UIScreen mainScreen].bounds.size.width

#define HEIGHT     [UIScreen mainScreen].bounds.size.height

@interface HomeTableViewCell ()
@property (nonatomic, strong) UILabel *nameL;
@property (nonatomic, strong) UILabel *unitPriceL;
@property (nonatomic, strong) UILabel *maichuNumber;
@property (nonatomic, strong) UILabel *totalPrice;

@end

@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameL = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameL];
        
        self.unitPriceL = [[UILabel alloc] init];
        [self.contentView addSubview:self.unitPriceL];
        
        self.maichuNumber = [[UILabel alloc] init];
        [self.contentView addSubview:self.maichuNumber];
        
        self.totalPrice = [[UILabel alloc] init];
        [self.contentView addSubview:self.totalPrice];

        self.nameL.font = self.unitPriceL.font = self.maichuNumber.font = self.totalPrice.font = [UIFont systemFontOfSize:14];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.nameL.frame = CGRectMake(10, 10, WIDTH-20, 20);
    self.unitPriceL.frame = CGRectMake(10, self.nameL.frame.size.height+10+self.nameL.frame.origin.y, WIDTH-20, 20);
    self.maichuNumber.frame = CGRectMake(10, self.unitPriceL.frame.size.height+10+self.unitPriceL.frame.origin.y, WIDTH-20, 20);
    self.totalPrice.frame = CGRectMake(10, self.maichuNumber.frame.size.height+10+self.maichuNumber.frame.origin.y, WIDTH-20, 20);

}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.nameL.text = [NSString stringWithFormat:@"药物名称：%@",dic[@"cargoName"]];
    self.unitPriceL.text = [NSString stringWithFormat:@"药物单价：%@",dic[@"cargoUnitPrice"]];
    self.maichuNumber.text = [NSString stringWithFormat:@"销售数量：%@",dic[@"cargoRepertory"]];
    self.totalPrice.text = [NSString stringWithFormat:@"销售总金额：%@",dic[@"totalPrice"]];
    
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
