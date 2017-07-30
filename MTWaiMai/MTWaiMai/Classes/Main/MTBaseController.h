//
//  MTBaseController.h
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTNavigationBar;

@interface MTBaseController : UIViewController

// 内部创建的控件,外部允许重复赋值
@property (nonatomic,strong,readonly) MTNavigationBar *bar;

// 内部创建的控件,外部不允许重复赋值
@property (nonatomic,weak,readonly) UINavigationItem *barItem;

@end
