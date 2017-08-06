//
//  MTShopCartView.m
//  MTWaiMai
//
//  Created by relax on 2017/8/6.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTShopCartView.h"

@interface MTShopCartView () <CAAnimationDelegate>
/// 购物车显示图标按钮
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

/// 当前的订单总价
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

/// 结账按钮
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

/// numebrLabel
@property (nonatomic,weak) UILabel *numberLabel;

@property (nonatomic,weak) UIImageView *animationImg;

@end

@implementation MTShopCartView

/// 用户点单数据
- (void)setUserOrderData:(NSMutableArray<MTFoodModel *> *)userOrderData
{
    _userOrderData = userOrderData;

    // 根据用户点单数据,更新视图显示.

    // 有点单,有把按钮显示高亮
    _iconBtn.highlighted = self.userOrderData.count > 0;
    // 设置按钮的动画效果
    [self settingIconBtnAnimation];
    // 计算和显示当前订单总价
    NSNumber *totalPrice = [userOrderData valueForKeyPath:@"@sum.min_price"];
    _totalPriceLabel.text = [@"¥ " stringByAppendingString:totalPrice.description];

    // 根据订单更新按钮
    [self updateBtnState];

    //
    if (self.userOrderData.count > 0) {
        _numberLabel.hidden = NO;
        _numberLabel.text = @(self.userOrderData.count).description;

    } else {
        _numberLabel.hidden = YES;
    }
}

/// 起始点
- (void)bezierAnimationWithStartPoint:(CGPoint)startPoint
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];

    [path addQuadCurveToPoint:_iconBtn.center controlPoint:CGPointMake(startPoint.x - 150, startPoint.y - 100)];

    UIImageView *animationImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_common_point"]];

    [self addSubview:animationImg];

    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    //  指定动画路径
    keyAnimation.path = path.CGPath;

    keyAnimation.duration = 0.5;

    // 默认执行一次
    // keyAnimation.repeatCount = 1;

    // 在动画前先复制代理
    keyAnimation.delegate = self;

    [animationImg.layer addAnimation:keyAnimation forKey:nil];

    _animationImg = animationImg;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_animationImg removeFromSuperview];
}

- (void)settingIconBtnAnimation
{
    if (self.userOrderData.count >0) {
        [UIView animateWithDuration:0.25 animations:^{
            _iconBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            _iconBtn.transform = CGAffineTransformIdentity;
        }];
    }
}

/// 根据用户点单设置按钮样式
- (void)updateBtnState
{
    _buyBtn.backgroundColor = self.userOrderData.count > 0 ? [UIColor primatkeyColor] : [UIColor lightGrayColor];
    NSString *title = nil;
    title = self.userOrderData.count > 0 ? @"结账" : @"请添加";
    [_buyBtn setTitle:title forState:UIControlStateNormal];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置购物车的背景图片
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_shop_car"]];

    self.backgroundColor = [UIColor whiteColor];

    // 创建显示订单数字的label
    UILabel *numberLabel = [UILabel makeLabelWithFontSize:10 fontColor:[UIColor whiteColor] text:@""];
    numberLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_food_count_bg"]];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.layer.cornerRadius = 8;
    numberLabel.layer.masksToBounds = YES;
    [numberLabel adjustsFontSizeToFitWidth];
    numberLabel.hidden = YES;

    numberLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;

    [_iconBtn addSubview:numberLabel];

    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(16);
        make.right.top.offset(0);
    }];

    _numberLabel = numberLabel;
}

//- (void)click
//{
//     NSLog(@"%s",__func__);
//}

+ (instancetype)shopCartView
{
    return [[UINib nibWithNibName:@"MTShopCartView" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
}

@end
