//
//  MTCategoryFoodCell.m
//  MTWaiMai
//
//  Created by relax on 2017/8/3.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTCategoryFoodCell.h"
#import "MTCategoryFoodModel.h"


@implementation MTCategoryFoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    // 设置字体大小
    self.textLabel.font = [UIFont systemFontOfSize:13];
    // 设置行数
    self.textLabel.numberOfLines = 2;
    // 设置背景颜色
    self.backgroundColor = [UIColor colorWithRed:0.96471 green:0.96471 blue:0.96471 alpha:1.00000];

    // 下边的虚线
    UIView *dashLineView = [[UIView alloc] init];
    dashLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage dashLineWithColor:[UIColor blackColor]]];
    [self.contentView addSubview:dashLineView];

    [dashLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(1);
    }];


    // 设置选中的cell视图
    UIView *selectedView = [[UIView alloc] init];
    selectedView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = selectedView;

    // 设置选中样式的小黄条
    UIView *selectedYellowLineView = [[UIView alloc] init];
    [selectedView addSubview:selectedYellowLineView];
    selectedYellowLineView.backgroundColor = [UIColor primatkeyColor];

    [selectedYellowLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.centerY.offset(0);
        make.width.offset(4);
        make.height.offset(44);
    }];
}

- (void)setCategoryModel:(MTCategoryFoodModel *)categoryModel
{
    _categoryModel = categoryModel;
    self.textLabel.text = categoryModel.name;
}

@end
