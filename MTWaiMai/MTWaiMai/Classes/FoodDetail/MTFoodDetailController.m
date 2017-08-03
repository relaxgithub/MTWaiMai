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

    // self.bar.backgroundColor = [UIColor yellowColor];

    // 将背景图片改成透明
    self.bar.imgView.alpha = 0.0;
    // 将选染色改成白色
    self.bar.tintColor = [UIColor whiteColor];


    // 设置UI
    [self setupUI];
   
}

/// 设置状态栏为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupUI
{
    // 1.因为可以上下滚动 == scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];

    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    // 2.滑动的imageView
    UIImageView *imgView = [[UIImageView alloc] init];
    [scrollView addSubview:imgView];
    //http://p1.meituan.net/xianfu/d36a62f1130c63ffa5a61c9cfd2be9f0212992.jpg"
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://p1.meituan.net/xianfu/d36a62f1130c63ffa5a61c9cfd2be9f0212992.jpg"]];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;

    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(240);
    }];

    // 3.食物名称
    UILabel *nameLabel = [UILabel makeLabelWithFontSize:17 fontColor:[UIColor darkTextColor] text:@"妈妈蛋炒饭"];
    [scrollView addSubview:nameLabel];

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(8);
        make.left.offset(8);
    }];



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
