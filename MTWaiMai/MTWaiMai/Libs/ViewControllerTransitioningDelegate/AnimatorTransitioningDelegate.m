//
//  AnimatorTransitioningDelegate.m
//  MTWaiMai
//
//  Created by relax on 2017/8/2.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "AnimatorTransitioningDelegate.h"

typedef NS_OPTIONS(NSUInteger,AnimatorTransitionType ) {
    AnimatorTransitionTypeModal, // 打开
    AnimatorTransitionTypeDismiss, // 关闭
};

@interface AnimatorTransitioningDelegate () <UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) AnimatorTransitionType transitionType;

@end

@implementation AnimatorTransitioningDelegate

#pragma mark - UIViewControllerTransitioningDelegate 代理方法
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    // modal显示的时候执行此方法
    // NSLog(@"%@",@"modal打开了");
    _transitionType = AnimatorTransitionTypeModal;

    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    // NSLog(@"%@",@"modal关闭了");
    _transitionType = AnimatorTransitionTypeDismiss;

    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning 代理方法

// 转场动画时长
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

// 如何转场 包括转场方向
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 所有的转场都是一个大范围的视图内的内容发生转场.
    // 获取容器视图
    UIView *containerView = [transitionContext containerView];
    // toView 就是哪个视图需要显示出来.(需要显示在转场的视图上)
    // fromView 就是哪个视图需要消失.(需要从转场视图上移走)
    // 获取要去的视图,modal的时候,去的view就是商家详情view
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    // 获取来源的视图,modal的时候,商品列表view就是来源视图
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

    // 因为,modal 和 dismiss 都会执行此方法,所以要做判断,这次到底是modal 还是 dismiss
    if (_transitionType == AnimatorTransitionTypeModal)
    {
        // 先把transform设置成0,0
        toView.transform = CGAffineTransformMakeScale(0, 0);
        [containerView addSubview:toView];//把目标view添加到转场视图里
        [UIView animateWithDuration:[self transitionDuration:nil] animations:^{
            toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            // 告知容器view,转场完成,可以开启交互了
            [transitionContext completeTransition:YES];
        }];
    }
    else
    {
        // 当前需要把后面的view展示到转场视图上
        [UIView animateWithDuration:[self transitionDuration:nil] animations:^{
            // dismiss的时候,from就是商家详情页面
            fromView.transform = CGAffineTransformMakeScale(0.01, 0.01);

        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}


@end
