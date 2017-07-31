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


#define KMaxHeaderViewHeight 180
#define KMinHeaderViewHeight 64

@interface MTShopController () <UIScrollViewDelegate>

/// 头部视图
@property (nonatomic,weak) UIView *headerView;

/// 中部滑动视图
@property (nonatomic,weak) UIView *middleTagView;

/// 底部滑动视图
@property (nonatomic,weak) UIScrollView *bottomScrollView;

/// 黄色小黄条
@property (nonatomic,weak) UIView *yellowLineView;

@end

@implementation MTShopController

#pragma mark - 根视图生命周期
- (void)viewDidLoad
{
    // 写在这里的话,系统的viewDidLoad方法一个都没执行,会影响子控件的添加吗?
    // [self settingShopHeader];


    [super viewDidLoad];

    [self setupUI];
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
    self.view.backgroundColor = [UIColor orangeColor];

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

}

#pragma mark - 设置头部
- (void)settingShopHeader
{
    MTHeaderView *headerView = [[MTHeaderView alloc] init];
    [self.view addSubview:headerView];
    _headerView = headerView;

    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(180);
    }];

    headerView.backgroundColor = [UIColor redColor];
    // 新添加的头部视图,不要覆盖之前添加的navigationBar
    [self.view insertSubview:self.bar aboveSubview:headerView];

}

#pragma mark - 设置中部视图
- (void)settingMiddleTagView {
    /// 中部视图
    UIView *middleTagView = [[UIView alloc] init];
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
- (void)settingBottomScrollView {
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
    MTOrderController *orderVC = [[MTOrderController alloc] init];
    MTCommentController *commentVC = [[MTCommentController alloc] init];
    MTInfoController *infoVC = [[MTInfoController alloc] init];

    NSArray<UIViewController *> *vcArr = @[orderVC,commentVC,infoVC];

    for (int i = 0; i < vcArr.count; i++) {
        [scrollView addSubview:vcArr[i].view]; // 当一个视图控制器视图添加到另外一个控制器的仕途上,这个被添加的视图,默认是铺满前一个视图的.
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
