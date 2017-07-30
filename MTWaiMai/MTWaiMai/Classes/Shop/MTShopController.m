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


#define KMaxHeaderViewHeight 180
#define KMinHeaderViewHeight 64

@interface MTShopController () <UITableViewDataSource>

@property (nonatomic,weak) UIView *headerView;

@end

@implementation MTShopController

- (void)viewDidLoad
{
    // 写在这里的话,系统的viewDidLoad方法一个都没执行,会影响子控件的添加吗?
    // [self settingShopHeader];


    [super viewDidLoad];

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

    // 设置商店头部 (把之前添加的navigationBar给覆盖了)
    [self settingShopHeader];
}

- (void)settingShopHeader
{
    UIView *headerView = [[UIView alloc] init];
    [self.view addSubview:headerView];
    _headerView = headerView;

    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(180);
    }];

    headerView.backgroundColor = [UIColor colorWithRed:0.91765 green:0.87059 blue:0.67843 alpha:1.00000];

    // 新添加的头部视图,不要覆盖之前添加的navigationBar
    [self.view insertSubview:self.bar aboveSubview:headerView];

    // 当发现一个视图可以上下变小变大时,不一定是scrollView的bounces效果,也有可能是pan手势修改了size属性.
    // 特别是那些根据滚动会产生一些明显的layer线性属性值变化的情况
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
}

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
