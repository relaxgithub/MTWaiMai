//
//  UIImage+DashLine.m
//  MTWaiMai
//
//  Created by relax on 2017/7/31.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "UIImage+DashLine.h"

@implementation UIImage (DashLine)

+ (instancetype)dashLineWithColor:(UIColor *)color
{
    // 1.打开一个绘图的上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(4, 1), NO, 0);

    // 2.获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();

    // 3.在上下文里画东西
    CGContextMoveToPoint(ref, 0, 0);
    CGContextAddLineToPoint(ref, 4, 0);

    // 4.设置线条虚线样式
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(ref, 0, lengths, 2);

    // 5.渲染上下文
    CGContextStrokePath(ref);

    // 6.从下文获取图片
    UIImage *dashImageView = UIGraphicsGetImageFromCurrentImageContext();

    // 7.关闭当前上下文
    UIGraphicsEndImageContext();

    return dashImageView;
}


@end
