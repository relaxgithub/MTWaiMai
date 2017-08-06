//
//  MTShopCartView.h
//  MTWaiMai
//
//  Created by relax on 2017/8/6.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTFoodModel;

@interface MTShopCartView : UIView

/// 用户点单数据
@property (nonatomic,strong) NSMutableArray<MTFoodModel *> *userOrderData;

+ (instancetype)shopCartView;

/// 执行动画方法
- (void)bezierAnimationWithStartPoint:(CGPoint)startPoint;

@end
