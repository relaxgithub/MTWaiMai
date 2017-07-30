//
//  NSNumber+MTNumberAddition.m
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "NSNumber+MTNumberAddition.h"

@implementation NSNumber (MTNumberAddition)

- (CGFloat)calculatorResultWithValue1:(MTValue)value1 value2:(MTValue)value2
{
    /*
     value1.y = a * value1.x + b;
     value2.y = a * value2.x + b

     value1.y - vaule2.y = a * (value1.x - vaule2.x)
     a = (value1.y-value2.y) / (value1.x - value2.x)
     */

    CGFloat a = (value1.y-value2.y) / (value1.x - value2.x);
    CGFloat b = value1.y - a * value1.x;


    return a * [self floatValue] + b;
}

@end
