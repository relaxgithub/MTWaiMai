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
        // 去掉下划线 &
        [self setShadowImage:[UIImage new]];
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

        // navigationItem 是为 navigationBar服务的,如果重写了navigationBar,那么就需要手动的建立两者之间的关系.
        UINavigationItem *item = [[UINavigationItem alloc] init];

        [self setItems:@[item]];//手动建立 item 和 bar 之间的关系
        _barItem = item;
    }
    return self;
}




@end
