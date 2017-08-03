//
//  MTFoodModel.m
//  MTWaiMai
//
//  Created by relax on 2017/8/3.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTFoodModel.h"

@implementation MTFoodModel

+ (instancetype)foodWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"])
    {
        _desc = value;
    }
}


@end
