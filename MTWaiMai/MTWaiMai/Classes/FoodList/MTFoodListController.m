//
//  MTFoodListController.m
//  MTWaiMai
//
//  Created by relax on 2017/8/2.
//  Copyright © 2017年 relax. All rights reserved.
//

// 商品点菜列表

#import "MTFoodListController.h"

@interface MTFoodListController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *categoryFoodTableView;

@end

@implementation MTFoodListController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // self.view.backgroundColor = [UIColor colorWithRed:0.63137 green:0.87059 blue:0.98431 alpha:1.00000];

    // 设置界面
    [self setupUI];
}


- (void)setupUI
{
    // 设置食品分类表格
    [self settingCategoryFoodTableView];

    // 设置分类里的视频表格
    [self settingFoodTableView];
}

#pragma mark - 添加商品分类table
- (void)settingCategoryFoodTableView
{
    UITableView *categoryFoodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:categoryFoodTableView];
    _categoryFoodTableView = categoryFoodTableView;

    // 设置约束
    [categoryFoodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(100);
    }];

    // 设置数据源和代理
    categoryFoodTableView.delegate = self;
    categoryFoodTableView.dataSource = self;
}

#pragma mark - 添加分类中的商品tableView
- (void)settingFoodTableView
{
    UITableView *foodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:foodTableView];

    [foodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.left.equalTo(_categoryFoodTableView.mas_right).offset(0);
    }];

    foodTableView.delegate = self;
    foodTableView.dataSource = self;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}


#pragma mark - 代理方法




@end
