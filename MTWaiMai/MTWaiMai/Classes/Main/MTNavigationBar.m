//
//  MTNavigationBar.m
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTNavigationBar.h"




@implementation MTNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 去掉下划线 & 透明效果
        // 下面两行导航会让导航条彻底透明没有阴影线
        // 一般设置空白和下划线是为了添加一张自己带有下划线的背景图片.
        [self setShadowImage:[UIImage new]];
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

        // 设置自己的背景图片
        UIImageView *bgImgView = [[UIImageView alloc] init];
        bgImgView.image = [UIImage imageNamed:@"bg_navigationBar_white"];

        [self addSubview:bgImgView];

        [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];

        // 提供给外面,主要是为了修改透明度
        _imgView = bgImgView;
    }
    return self;
}




@end
