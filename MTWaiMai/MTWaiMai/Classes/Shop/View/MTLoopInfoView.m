//
//  MTLoopInfoView.m
//  MTWaiMai
//
//  Created by relax on 2017/8/1.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTLoopInfoView.h"
#import "MTDiscount2Model.h"

@interface MTLoopInfoView ()

@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UILabel *adverLabel;

@end

@implementation MTLoopInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setupUI];
}

- (void)setupUI
{
    // 创建广告图片
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;

    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(20);
        make.left.offset(20);
        make.top.offset(0);
    }];


    // 广告label
    UILabel *adverLabel = [[UILabel alloc] init];
    [self addSubview:adverLabel];
    adverLabel.font = [UIFont systemFontOfSize:12];
    adverLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    _adverLabel = adverLabel;

    [adverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(iconView.mas_right).offset(20);
        make.right.offset(-20);
    }];
}

- (void)setDiscountModel:(MTDiscount2Model *)discountModel
{
    _discountModel = discountModel;

    // 轮播图片
    [_iconView sd_setImageWithURL:[NSURL URLWithString:discountModel.icon_url]];

    // 轮播广告
    _adverLabel.text = discountModel.info;

}

@end
