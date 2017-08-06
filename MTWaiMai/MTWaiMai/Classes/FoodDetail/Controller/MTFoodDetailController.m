//
//  MTFoodDetailController.m
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTFoodDetailController.h"
#import "MTNavigationBar.h"
#import "MTFoodModel.h"
#import "MTFoodDetailFlowLayout.h"
#import "MTCategoryFoodModel.h"
#import "MTFoodDetailCell.h"
#import "MTShopCartView.h"
#import "MTCategoryFoodModel.h"

@interface MTFoodDetailController () <UICollectionViewDataSource>

@property (nonatomic,weak) UICollectionView *collectionView;

@property (nonatomic,assign) BOOL isScrolled;



@end

static NSString *foodDetailCellID = @"foodDetailCellID";

@implementation MTFoodDetailController

#pragma mark - 视图生命周期事件
- (void)viewDidLoad
{
    // 不要盖住自定义的navigationBar
    [self setupUI];

    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.16863 green:0.79608 blue:0.97255 alpha:1.00000];

    // self.bar.backgroundColor = [UIColor yellowColor];

    // 将背景图片改成透明
    self.bar.imgView.alpha = 0.0;
    // 将选染色改成白色
    self.bar.tintColor = [UIColor whiteColor];
    // 关闭navi & tab 的 inset
    self.automaticallyAdjustsScrollViewInsets = NO;

    // 设置购物车
    [self settingShopCartView];

}

#pragma mark - 设置购物车
- (void)settingShopCartView
{
    MTShopCartView *cartView = [MTShopCartView shopCartView];
    [self.view addSubview:cartView];

    [cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(44);
    }];

    cartView.userOrderData = _userOrderData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置状态栏为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 设置界面UI
- (void)setupUI
{
    // 0.创建collectionView
    MTFoodDetailFlowLayout *layout = [[MTFoodDetailFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:collectionView];

    collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView = collectionView;

    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    // 设置数据源
    collectionView.dataSource = self;

    // 注册cell
    [collectionView registerClass:[MTFoodDetailCell class] forCellWithReuseIdentifier:foodDetailCellID];

    // collectionView基本设置
    collectionView.pagingEnabled = YES;
    collectionView.bounces = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;

    /**
    // 1.因为可以上下滚动 == scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    [collectionView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    // 打开垂直弹簧效果
    scrollView.alwaysBounceVertical = YES;

    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        make.width.equalTo(scrollView).offset(0);
        // make.height.offset(1000);
    }];

    // 2.滑动的imageView
    UIImageView *imgView = [[UIImageView alloc] init];
    [contentView addSubview:imgView];

    _pictureView = imgView;

    //http://p1.meituan.net/xianfu/d36a62f1130c63ffa5a61c9cfd2be9f0212992.jpg"
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://p1.meituan.net/xianfu/d36a62f1130c63ffa5a61c9cfd2be9f0212992.jpg"]];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;

    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(240);
    }];

    // 3.食物名称
    UILabel *nameLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor darkTextColor] text:@"妈妈蛋炒饭"];
    [contentView addSubview:nameLabel];
    _nameLabel = nameLabel;

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(8);
        make.left.offset(8);
    }];


    // 4.月售
    UILabel *month_saled_contentLabel = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor darkGrayColor] text:@"月售 9999"];
    [contentView addSubview:month_saled_contentLabel];
    _month_saled_contentLabel = month_saled_contentLabel;

    [month_saled_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(nameLabel.mas_bottom).offset(8);
    }];

    // 5.价格
    UILabel *min_priceLabel = [UILabel makeLabelWithFontSize:18 fontColor:[UIColor primatkeyColor] text:@"¥ 5.9"];
    [contentView addSubview:min_priceLabel];

    _min_priceLabel = min_priceLabel;

    [min_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(month_saled_contentLabel.mas_bottom).offset(16);
    }];

    // 6.商品信息
    UILabel *foodInfoLabel = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor darkGrayColor] text:@"商品信息"];
    [contentView addSubview:foodInfoLabel];

    [foodInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(min_priceLabel.mas_bottom).offset(16);
    }];

    // 7.商品描述
    UILabel *descLabel = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor darkGrayColor] text:@"这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品"];
    descLabel.numberOfLines = 0;
    [contentView addSubview:descLabel];
    _descLabel = descLabel;

    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(foodInfoLabel.mas_bottom).offset(8);
        make.right.offset(-8);
    }];

    // 8.商品评价
    UILabel *evaluationLabel = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor darkGrayColor] text:@"商品评价"];
    [contentView addSubview:evaluationLabel];

    [evaluationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(descLabel.mas_bottom).offset(8);
    }];

    // 9.商品评价UIView
    UIView *evaluationView = [[UIView alloc] init];
    UILabel *evalLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor darkGrayColor] text:@"好评率"];
    [evaluationView addSubview:evalLabel];
    UILabel *percentageLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor primatkeyColor] text:@"99%"];
    [evaluationView addSubview:percentageLabel];
    _percentageLabel = percentageLabel;

    // 逆向约束
    [evaluationView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];

    [evaluationView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:4 leadSpacing:1 tailSpacing:1];

    // 在设置好评率view的布局
    [contentView addSubview:evaluationView];

    [evaluationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(evaluationLabel.mas_bottom).offset(8);
    }];

    // 10.好评率进度条
    UIProgressView *progressView = [[UIProgressView alloc] init];
    progressView.layer.cornerRadius = 5;
    progressView.layer.masksToBounds = YES;
    progressView.progress = 0.51;
    progressView.progressTintColor = [UIColor primatkeyColor];
    [contentView addSubview:progressView];
    _progressView = progressView;

    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.right.offset(-8);
        make.top.equalTo(evaluationView.mas_bottom).offset(8);
        make.height.offset(10);
        
        // 设置一个bottom,自动计算contentView的height
        make.bottom.offset(-8);
    }];
     */
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (!_isScrolled) {
        [_collectionView scrollToItemAtIndexPath:_scrollToIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        _isScrolled = YES;
    }
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _categoryFoodData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _categoryFoodData[section].spus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTFoodDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:foodDetailCellID forIndexPath:indexPath];
    
    cell.foodModel = _categoryFoodData[indexPath.section].spus[indexPath.row];

    return cell;
}


/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
