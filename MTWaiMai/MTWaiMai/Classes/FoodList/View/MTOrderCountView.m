//
//  MTOrderCountView.m
//  MTWaiMai
//
//  Created by relax on 2017/8/3.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTOrderCountView.h"
#import "MTFoodModel.h"

@interface MTOrderCountView ()

/// 加法按钮
@property (nonatomic,weak) UIButton *subBtn;
/// 减法按钮
@property (nonatomic,weak) UIButton *plusBtn;
/// 显示数字label
@property (nonatomic,weak) UILabel *numberLabel;

@end

@implementation MTOrderCountView

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
    // 减法按钮
    UIButton *subBtn = [[UIButton alloc] init];
    [subBtn setImage:[UIImage imageNamed:@"icon_food_decrease"] forState:UIControlStateNormal];
    [self addSubview:subBtn];
    _subBtn = subBtn;

    [_subBtn addTarget:self action:@selector(subClick) forControlEvents:UIControlEventTouchUpInside];

    //    [_subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.top.bottom.offset(0);
    //        make.width.offset(20);
    //    }];

    // 计数label
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.font = [UIFont systemFontOfSize:13];
    numberLabel.text = @"999";
    [self addSubview:numberLabel];
    _numberLabel = numberLabel;

    //    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.bottom.offset(0);
    //        make.left.equalTo(subBtn.mas_right).offset(0);
    //        make.width.offset(36);
    //    }];


    // 加法按钮
    UIButton *plusBtn = [[UIButton alloc] init];
    [plusBtn setImage:[UIImage imageNamed:@"icon_food_increase"] forState:UIControlStateNormal];
    _plusBtn = plusBtn;
    [self addSubview:plusBtn];

    [_plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];


    [self.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
    }];

    [self.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];

}

/// 点击加号按钮
- (void)plusClick
{
    _foodModel.count++;
    // NSLog(@"%zd",_foodModel.count);
    [self updateState];
}

/// 点击减号按钮
- (void)subClick
{
    _foodModel.count--;
    // NSLog(@"%zd",_foodModel.count);
    [self updateState];
}

- (void)setFoodModel:(MTFoodModel *)foodModel
{
    _foodModel = foodModel;
    // 更新状态
    [self updateState];

}

/// 根据用户点餐数量更新视图状态
- (void)updateState
{
    _subBtn.hidden = !_foodModel.count;
    _numberLabel.hidden = !_foodModel.count;
    _numberLabel.text = @(_foodModel.count).description;
}

@end
