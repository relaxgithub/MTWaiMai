//
//  MTFoodListController.m
//  MTWaiMai
//
//  Created by relax on 2017/8/2.
//  Copyright © 2017年 relax. All rights reserved.
//

// 商品点菜列表

#import "MTFoodListController.h"
#import "MTCategoryFoodModel.h"
#import "MTCategoryFoodCell.h"
#import "MTFoodModel.h"
#import "MTFoodCell.h"
#import "MTFoodListSectionHeaderView.h"
#import "MTFoodDetailController.h"
#import "MTShopCartView.h"
#import "MTOrderCountView.h"

@interface MTFoodListController () <UITableViewDelegate,UITableViewDataSource,OrderCountViewDelegate>

/// 食品分类tableview
@property (nonatomic,weak) UITableView *categoryFoodTableView;

/// 食品tableView
@property (nonatomic,weak) UITableView *foodTableView;

@property (nonatomic,strong) NSArray *strongData;

@property (nonatomic,assign) BOOL isClickScroll;

@property (nonatomic,weak) MTShopCartView *shopCartView;

/// 用户点单数据
@property (nonatomic,strong) NSMutableArray<MTFoodModel *> *userOrderData;

@end

/// 食品分类表格cellID
static NSString *categoryTableViewCellID = @"categoryTableViewCellID";

static NSString *foodTableViewCellID = @"foodTableViewCellID";

@implementation MTFoodListController

- (NSMutableArray<MTFoodModel *> *)userOrderData
{
    if (_userOrderData == nil) {
        _userOrderData = [NSMutableArray array];
    }

    return _userOrderData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置购物车视图
    [self settingShopCartView];
    // 设置界面
    [self setupUI];

    [self.view bringSubviewToFront:_shopCartView];
}

- (void)setupUI
{
    // 设置食品分类表格
    [self settingCategoryFoodTableView];

    // 设置分类里的视频表格
    [self settingFoodTableView];

    // 用一个nstimer 把_categoryData强引用住
    //    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        _categoryFoodData;
    //    }];
}

#pragma mark - 手势共存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - 设置网络数据,并激活tableview的reloadData
- (void)setCategoryFoodData:(NSArray<MTCategoryFoodModel *> *)categoryFoodData
{
    _categoryFoodData = categoryFoodData;
}

#pragma mark - 添加商品分类table
- (void)settingCategoryFoodTableView
{
    UITableView *categoryFoodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:categoryFoodTableView];
    _categoryFoodTableView = categoryFoodTableView;

    // 设置约束
    [categoryFoodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(100);
        make.bottom.equalTo(_shopCartView.mas_top).offset(0);

    }];

    // 设置数据源和代理
    categoryFoodTableView.delegate = self;
    categoryFoodTableView.dataSource = self;

    // 注册cell
    [categoryFoodTableView registerClass:[MTCategoryFoodCell class] forCellReuseIdentifier:categoryTableViewCellID];

    // 设置行高
    categoryFoodTableView.rowHeight = 60;

    // 设置cell分割线样式
    categoryFoodTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 默认第一个选中
    [categoryFoodTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];


    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkData)];
    //    [categoryFoodTableView addGestureRecognizer:tap];
}

//- (void)checkData
//{
//    NSLog(@"%@",_categoryFoodData);
//
//}

#pragma mark - 设置购物车视图
- (void)settingShopCartView
{
    MTShopCartView *shopCartView = [MTShopCartView shopCartView];
    [self.view addSubview:shopCartView];

    [shopCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(44);
    }];

    _shopCartView = shopCartView;


}

#pragma mark - 添加分类中的商品tableView
- (void)settingFoodTableView
{
    UITableView *foodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:foodTableView];

    [foodTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.offset(0);
        make.left.equalTo(_categoryFoodTableView.mas_right).offset(0);
        make.bottom.equalTo(_shopCartView.mas_top).offset(0);
    }];

    foodTableView.delegate = self;
    foodTableView.dataSource = self;

    _foodTableView = foodTableView;

    // 注册cell
    [foodTableView registerClass:[MTFoodCell class] forCellReuseIdentifier:foodTableViewCellID];

    // 预估高度计算行高
    foodTableView.estimatedRowHeight = 120;

    // 设置分组头视图高度
    foodTableView.sectionHeaderHeight = 30;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _categoryFoodTableView)
    {
        return 1;
    }

    return _categoryFoodData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryFoodTableView)
        return _categoryFoodData.count;

    return _categoryFoodData[section].spus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _categoryFoodTableView)
    {
        MTCategoryFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryTableViewCellID forIndexPath:indexPath];
        MTCategoryFoodModel *categoryModel = _categoryFoodData[indexPath.row];
        cell.categoryModel = categoryModel;

        return cell;

    }

    MTFoodCell *cell = [tableView dequeueReusableCellWithIdentifier:foodTableViewCellID forIndexPath:indexPath];
    MTFoodModel *food = _categoryFoodData[indexPath.section].spus[indexPath.row];
    cell.foodModel = food;

    // 给conterView设置代理对象
    cell.countView.delegate = self;

    return cell;
}

#pragma mark - 计数视图代理方法
- (void)orderCountView:(MTOrderCountView *)countView type:(OrderCountViewType)type
{
    if (type == OrderCountViewPlus) {
        // 如果用户点击了 + 好,就把当前cell的食物加到用户点单列表
        [self.userOrderData addObject:countView.foodModel];
        // 点击加号执行动画
        CGPoint startPoint = [countView convertPoint:countView.subBtn.center toView:_shopCartView];
        [_shopCartView bezierAnimationWithStartPoint:startPoint];

    } else {
        // 如果用户点击了 - 号,就把当前cell的视图从用户点餐列表去掉
        [self.userOrderData removeObjectAtIndex:[self.userOrderData indexOfObject:countView.foodModel]];
    }

    // 把用户点单数据,传递给购物车,并更新购物车的显示详情.
    _shopCartView.userOrderData = self.userOrderData;
}


#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _foodTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        // 并跳转到食物详情页面
        MTFoodDetailController *detailVC = [[MTFoodDetailController alloc] init];
        
        // detailVC.view;
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //
        //            detailVC.foodModel = _categoryFoodData[indexPath.section].spus[indexPath.row];
        //        });
        //        detailVC.foodModel = _categoryFoodData[indexPath.section].spus[indexPath.row];

        // 传递数据
        detailVC.categoryFoodData = _categoryFoodData;
        // 滚到目标indexPath
        detailVC.scrollToIndexPath = indexPath;
        // 用户点菜数据
        detailVC.userOrderData = _userOrderData;


        [self.navigationController pushViewController:detailVC animated:YES];
    }

    if (tableView == _categoryFoodTableView) {
        _isClickScroll = YES; // 点击滑动这里
        // 滑动到指定的组
        NSIndexPath *scrollToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [_foodTableView scrollToRowAtIndexPath:scrollToIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _isClickScroll = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 右边滚动时,联动左边滚动
    if (_foodTableView == scrollView && !_isClickScroll) {
        // 获得当前可视范围内的cell.
        NSArray<NSIndexPath *> *visiableIndexPath = [_foodTableView indexPathsForVisibleRows];
        // 获取当前滚动的第一个indexPath
        NSIndexPath *firstIndexPath = visiableIndexPath.firstObject;
        // 第一个indexPath 在第几组,就是左边显示的第几个cell
        NSIndexPath *leftCellSelectedIndexPath = [NSIndexPath indexPathForRow:firstIndexPath.section inSection:0];

        [_categoryFoodTableView selectRowAtIndexPath:leftCellSelectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
}

/// 返回分组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _foodTableView) {
        MTFoodListSectionHeaderView *sectionHeaderView = [[MTFoodListSectionHeaderView alloc] init];
        sectionHeaderView.textLabel.text = _categoryFoodData[section].name;
        // 设置字体 // 在这里设置的字体时机比较靠前,会被后续的系统操作给覆盖成原始的17
        // 所以,需要自定义一个headerFooterView 并在layoutSubviews里设置字体属性
        // sectionHeaderView.textLabel.font = [UIFont systemFontOfSize:12];

        // 这样设置的话,需要设定sectionHeaderView的高.
        return sectionHeaderView;
    }

    return nil;
}



@end
