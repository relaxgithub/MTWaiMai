//
//  MTShopController.m
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTShopController.h"
#import "MTFoodDetailController.h"
#import "MTNavigationBar.h"
#import "MTOrderController.h"
#import "MTCommentController.h"
#import "MTInfoController.h"
#import "MTHeaderView.h"
#import "MTPOI_SHOP_Model.h"
#import "MTFoodListController.h"
#import "MTCategoryFoodModel.h"




#define KMaxHeaderViewHeight 180 // 头部视图的最大高度
#define KMinHeaderViewHeight 64 // 头部视图的最小高度

@interface MTShopController () <UIScrollViewDelegate,UIGestureRecognizerDelegate>

/// 头部视图
@property (nonatomic,weak) MTHeaderView *headerView;

/// 中部滑动视图
@property (nonatomic,weak) UIView *middleTagView;

/// 底部滑动视图
@property (nonatomic,weak) UIScrollView *bottomScrollView;

/// 黄色小黄条
@property (nonatomic,weak) UIView *yellowLineView;

/// 头部视图需要用到的model
@property (nonatomic,strong) MTPOI_SHOP_Model *poi_Shop_Model;

/// 保存食品分类数据
@property (nonatomic,strong) NSArray<MTCategoryFoodModel *> *categoryFoodData;
@property (nonatomic,assign,getter=isDataDown) BOOL dataDown;
@property (nonatomic,strong) MTFoodListController *foodListController;

@end

@implementation MTShopController

#pragma mark - 根视图生命周期
- (void)viewDidLoad
{
    // 写在这里的话,系统的viewDidLoad方法一个都没执行,会影响子控件的添加吗?
    // [self settingShopHeader];

    // 加载店铺数据
    // [self loadShopData];
    [self loadLoactionData];

    [super viewDidLoad];

    [self setupUI];
}

/// 手势共存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/**
 加载本地数据
 */
- (void)loadLoactionData
{
    // json 文件读取的第一步,先去读data数据 ********
    NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil]];

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
   //  NSDictionary *poi_info_dict = dict[@"data"][@"poi_info"];

    NSDictionary *poi_info_dict = dict[@"data"][@"poi_info"];

    _poi_Shop_Model = [MTPOI_SHOP_Model poi_ShopWithDict:poi_info_dict];

    // 给headerView赋值
    _headerView.poi_Shop_Model = _poi_Shop_Model;

    // 获得视频分类数据
    NSArray *foodCategoryArr = dict[@"data"][@"food_spu_tags"];
    NSMutableArray<MTCategoryFoodModel *> *categoryArrM = [NSMutableArray arrayWithCapacity:foodCategoryArr.count];
    for (NSDictionary *dict in foodCategoryArr)
    {
        MTCategoryFoodModel *foodCategoryModel = [MTCategoryFoodModel categoryFoodWithDict:dict];
        [categoryArrM addObject:foodCategoryModel];
    }
    // 把食物分类数据传递给属性保存
    _categoryFoodData = categoryArrM.copy;
}


/**
 加载网络数据
 */
- (void)loadShopData
{
    [[AFHTTPSessionManager manager] GET:@"https://raw.githubusercontent.com/relaxgithub/webResources/master/food.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {

        NSDictionary *poi_info_dict = responseObject[@"data"][@"poi_info"];

        _poi_Shop_Model = [MTPOI_SHOP_Model poi_ShopWithDict:poi_info_dict];

        // 给headerView赋值
        _headerView.poi_Shop_Model = _poi_Shop_Model;

        // 获得视频分类数据
        NSArray *foodCategoryArr = responseObject[@"data"][@"food_spu_tags"];
        NSMutableArray<MTCategoryFoodModel *> *categoryArrM = [NSMutableArray arrayWithCapacity:foodCategoryArr.count];
        for (NSDictionary *dict in foodCategoryArr)
        {
            MTCategoryFoodModel *foodCategoryModel = [MTCategoryFoodModel categoryFoodWithDict:dict];
            [categoryArrM addObject:foodCategoryModel];
        }
        // 把食物分类数据传递给属性保存
        _categoryFoodData = categoryArrM.copy;
        // NSLog(@"%@",_categoryFoodData);

        _dataDown = YES;//数据下载完成标记

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"%@",error);

        }
    }];
}

#pragma mark - 当前页面view设置
- (void)setupUI
{
    // 基本设置
    [self settingNormal];
    // 头部视图设置
    [self settingShopHeader];
    // 中部视图设置
    [self settingMiddleTagView];
    // 设置下部scrollView
    [self settingBottomScrollView];
}

#pragma mark - 基本设置
- (void)settingNormal
{
    self.view.backgroundColor = [UIColor whiteColor];

    // 设置navigationBar
    // self.bar.backgroundColor = [UIColor redColor];
    // 设置标题
    self.barItem.title = @"五香肉饼";

    // 设置字体的灰度
    self.bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:0.0]};

    // 设置右边的那个分享按钮
    self.barItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_share"] style:UIBarButtonItemStylePlain target:nil action:nil];

    // 设置背景图片完全透明
    self.bar.imgView.alpha = 0.0;

    // 修改渲染色,主要是把右边那个按钮完全透明
    self.bar.tintColor = [UIColor colorWithWhite:0.0 alpha:0];

    // 状态栏,一开始是白色
    self.statusBarStyle = UIStatusBarStyleLightContent;

    // 当发现一个视图可以上下变小变大时,不一定是scrollView的bounces效果,也有可能是pan手势修改了size属性.
    // 特别是那些根据滚动会产生一些明显的layer线性属性值变化的情况
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];

    // 手势共存
    pan.delegate = self;

}

#pragma mark - 设置头部
- (void)settingShopHeader
{
    MTHeaderView *headerView = [[MTHeaderView alloc] init];//setupUI
    [self.view addSubview:headerView];
    _headerView = headerView;
    // 给headerView赋值
    _headerView.poi_Shop_Model = _poi_Shop_Model;

    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(180);
    }];

    headerView.backgroundColor = [UIColor blackColor];
    // 新添加的头部视图,不要覆盖之前添加的navigationBar
    [self.view insertSubview:self.bar aboveSubview:headerView];
}

#pragma mark - 设置中部视图
- (void)settingMiddleTagView {
    /// 中部视图
    UIView *middleTagView = [[UIView alloc] init];
    //middleTagView.alpha = 0.1;
    [self.view addSubview:middleTagView];
    _middleTagView = middleTagView;

    // 添加中部视图约束
    [middleTagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_headerView.mas_bottom).offset(0);
        make.height.offset(44);
    }];

    middleTagView.backgroundColor = [UIColor whiteColor];

    // 创建中部视图三个按钮
    // 点菜 评价 商家
    UIButton *orderBtn = [self createButtonWithTitle:@"点菜"];
    orderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self createButtonWithTitle:@"评价"];
    [self createButtonWithTitle:@"商家"];

    // 设置按钮的y & height
    [middleTagView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];

    // 给按钮添加约束 设置按钮的 x & width
    [middleTagView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];

    // 添加小黄条
    UIView *yellowLineView = [[UIView alloc] init];
    [self.view addSubview:yellowLineView];

    yellowLineView.backgroundColor = [UIColor colorWithRed:0.98823 green:0.79216 blue:0.00000 alpha:1.00000];

    // 设置小黄条约束
    [yellowLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(4);
        make.width.offset(44);
        make.bottom.equalTo(middleTagView).offset(0);
        make.centerX.equalTo(orderBtn).offset(0);
    }];

    _yellowLineView = yellowLineView;
}

#pragma mark - 设置下部的scrollView
- (void)settingBottomScrollView
{
    // 创建scrollview
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    _bottomScrollView = scrollView;

    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;

    scrollView.delegate = self;

    scrollView.backgroundColor = [UIColor colorWithRed:0.16471 green:0.49020 blue:0.80392 alpha:1.00000];

    // 设置约束
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(_middleTagView.mas_bottom).offset(0);
    }];

    // 3个复杂的视图 = 三个控制器
    //MTOrderController *orderVC = [[MTOrderController alloc] init];
    MTFoodListController *foodList = [[MTFoodListController alloc] init];
    // _foodListController = foodList; // 用一个属性强引用,也行.不一定非要建立父子控制器的关系.
    // 给食物列表控制器传递数据
    foodList.categoryFoodData = _categoryFoodData;
    MTCommentController *commentVC = [[MTCommentController alloc] init];
    MTInfoController *infoVC = [[MTInfoController alloc] init];
    infoVC.shopModel = _poi_Shop_Model;

    NSArray<UIViewController *> *vcArr = @[foodList,commentVC,infoVC];

    for (int i = 0; i < vcArr.count; i++)
    {
        // 当一个视图控制器视图添加到另外一个控制器的视图上,这个被添加的视图,默认是铺满前一个视图的.
        [self addChildViewController:vcArr[i]]; ////******* 忘记了建立父子控制器的关系 *********/
        [scrollView addSubview:vcArr[i].view];
        [vcArr[i] didMoveToParentViewController:self];
    }

    // 设置子控制器视图的约束(y & h)
    [scrollView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.height.width.equalTo(scrollView);//view不是btn label ,没有自适应宽高.需要手动指定一下.
    }];

    // 设置内部的子视图零间距水平排开(x & w)
    [scrollView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
}

#pragma mark - scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 小黄条,走的总距离 2/3 个 view的长度
    CGFloat yellowLineViewLength = _middleTagView.bounds.size.width * 2 / 3.0;

    // 每次走的比例 contentsize.x / contentsize.maxX
    CGFloat maxContentX = (_bottomScrollView.subviews.count - 1) * _bottomScrollView.bounds.size.width;

    _yellowLineView.transform = CGAffineTransformMakeTranslation(yellowLineViewLength * _bottomScrollView.contentOffset.x / maxContentX, 0);
}

// 滑动减速之后
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    // 计算按钮索引
    int buttonIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;

    [self settingBtnBold:_middleTagView.subviews[buttonIndex]];

}

#pragma mark - 创建中部视图按钮
- (UIButton *)createButtonWithTitle:(NSString *)title {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];

    // 给按钮设置tag
    btn.tag = _middleTagView.subviews.count;

    [_middleTagView addSubview:btn];

    // 给按钮添加事件,切换scrollView的显示视图(contentOffSize.x)
    [btn addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];

    return btn;
}

#pragma mark - 点击按钮,切换视图控制器显示视图
- (void)switchView:(UIButton *)btn
{
    // 点击按钮切换视图控制器显示视图
    [_bottomScrollView setContentOffset:CGPointMake(btn.tag * _bottomScrollView.bounds.size.width, 0) animated:YES];

    // 设置按钮样式
    [self settingBtnBold:btn];
}

#pragma mark - 设置加粗按钮
- (void)settingBtnBold:(UIButton *)btn
{
    // 当前按钮字体加粗
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];

    for (int i = 0; i < _middleTagView.subviews.count; i++) {
        if ([_middleTagView.subviews[i] isMemberOfClass:[UIView class]] || i == btn.tag) {
            continue;
        }

        ((UIButton *)_middleTagView.subviews[i]).titleLabel.font = [UIFont systemFontOfSize:14];
    }

}

#pragma mark - 平移手势
- (void)panGesture:(UIPanGestureRecognizer *)pan
{

    // 如果scrollView在拖拽,就不要触发pan手势
    if (_bottomScrollView.isDragging) {
        return;
    }

    CGPoint p = [pan translationInView:pan.view];
    // headerView的高度在 64 ~ 180 之间,可以变动,否则不行.
    CGFloat currentHeaderViewHeight = _headerView.bounds.size.height;
    if (p.y + currentHeaderViewHeight <= KMinHeaderViewHeight)
    {
        [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(KMinHeaderViewHeight);
        }];
    }
    else if (p.y + currentHeaderViewHeight >= KMaxHeaderViewHeight)
    {
        [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(KMaxHeaderViewHeight);
        }];
    }
    else
    {
        [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(p.y + currentHeaderViewHeight);
        }];
    }

    // 根据headerView的height,来计算当前narBar的bgImg的透明度
    /*
     y = ax + b
     y = 1 x = 64
     1 = a * 64 + b
     0 = a * 180 + b

     1 = a * -116
     a = -1/116

     b = 1/116 * 180

     y = -1/116 * x + 180/116

     */

    // CGFloat alpha = -1/116.0 * (currentHeaderViewHeight + p.y) + 180/116.0;
    CGFloat alpha = [@(currentHeaderViewHeight + p.y) calculatorResultWithValue1:MTValueMake(64, 1) value2:MTValueMake(180,0)];

    // 背景图片颜色透明度变化
    self.bar.imgView.alpha = alpha;

    // 中间文字的透明度变化
    self.bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:alpha]};

    // 右边按钮的透明度变化
    self.bar.tintColor = [UIColor colorWithWhite: (1 - alpha) alpha:alpha];


    // 往上拉,黑色,
    if (p.y < 0) {
        self.statusBarStyle = UIStatusBarStyleDefault;
    } else {
        // 往下拉,白色
        self.statusBarStyle = UIStatusBarStyleLightContent;
    }

    if (currentHeaderViewHeight + p.y <= KMinHeaderViewHeight) {
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    
    
    
    [pan setTranslation:CGPointZero inView:pan.view];
}

@end
