//
//  MTFoodDetailController.m
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTFoodDetailController.h"
#import "MTNavigationBar.h"

@interface MTFoodDetailController ()

@end

@implementation MTFoodDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.16863 green:0.79608 blue:0.97255 alpha:1.00000];

    self.bar.backgroundColor = [UIColor yellowColor];

    // 设置标题
    self.bar.barItem.title = @"过桥米线";

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
