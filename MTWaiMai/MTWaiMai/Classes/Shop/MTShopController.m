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

@interface MTShopController ()

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
    self.bar.backgroundColor = [UIColor whiteColor];
    // 设置标题
    self.barItem.title = @"五香肉饼";

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

    [pan setTranslation:CGPointZero inView:pan.view];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    MTFoodDetailController *foodDetail = [[MTFoodDetailController alloc] init];
//
//    [self.navigationController pushViewController:foodDetail animated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
