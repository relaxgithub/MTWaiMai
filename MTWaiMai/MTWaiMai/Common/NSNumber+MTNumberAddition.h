//
//  NSNumber+MTNumberAddition.h
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>


struct MTValue {
    CGFloat x;
    CGFloat y;
};
typedef struct MTValue MTValue;

CG_INLINE MTValue
MTValueMake(CGFloat x, CGFloat y)
{
    MTValue p; p.x = x; p.y = y; return p;
}


@interface NSNumber (MTNumberAddition)

- (CGFloat)calculatorResultWithValue1:(MTValue)value1 value2:(MTValue)value2;

@end
