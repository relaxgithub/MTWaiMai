//
//  MTOrderCountView.h
//  MTWaiMai
//
//  Created by relax on 2017/8/3.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OrderCountViewPlus,
    OrderCountViewSub,
} OrderCountViewType;

@class MTFoodCell,MTOrderCountView;

@protocol OrderCountViewDelegate <NSObject>

- (void)orderCountView:(MTOrderCountView *)countView type:(OrderCountViewType)type;

@end

@class MTFoodModel;

@interface MTOrderCountView : UIView

/// 加法按钮
@property (nonatomic,weak) UIButton *subBtn;

@property (nonatomic,strong) MTFoodModel *foodModel;

@property (nonatomic,weak) id<OrderCountViewDelegate> delegate;

@end
