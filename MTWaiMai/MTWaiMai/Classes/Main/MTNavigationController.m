//
//  MTNavigationController.m
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTNavigationController.h"
#import "MTBaseController.h"

@interface MTNavigationController ()

@end

@implementation MTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 隐藏navigationController 自带的 navigationBar,为每一个子视图添加个性化的navBar
    [self.navigationBar setHidden:YES]; // 这一种,可以正常隐藏.

    // [self setNavigationBarHidden:YES]; // 这一种,也可以正常隐藏navigationBar 但是会丢失右滑pop这个手势效果了.

     // self.navigationItem 是个NSObject 类型,它是为 self.navigationBar 服务的.
    // 默认使用UINavigationController的navigationBar时,它会默认的建立navigationBar 和 navigationItem两者之间的关系.
    // 如果我们自己重写了navigationBar,那么就需要手动的建立navigationItem和navigationBar 两者之间的关系.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 给非栈底控制器,添加返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];

    if (self.childViewControllers.count > 1)
    {
        // 如果使用的是initWithImage,就需要自己处理pop方法
        ((MTBaseController *)viewController).barItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_backItem"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    }

}

- (void)pop
{
    // 当前被打开的视图可以pop,导航控制器也可以全局pop
    [self popViewControllerAnimated:YES];
}

@end
