//
//  MTNavigationController.m
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTNavigationController.h"

@interface MTNavigationController ()

@end

@implementation MTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 隐藏navigationController 自带的 navigationBar,为每一个子视图添加个性化的navBar
    [self.navigationBar setHidden:YES]; // 这一种,可以正常隐藏.

    // [self setNavigationBarHidden:YES]; // 这一种,也可以正常隐藏navigationBar 但是会丢失右滑pop这个手势效果了.
}

- (void)didReceiveMemoryWarning {
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
