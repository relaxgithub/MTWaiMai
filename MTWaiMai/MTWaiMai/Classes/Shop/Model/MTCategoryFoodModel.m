//
//  MTCategoryFoodModel.m
//  MTWaiMai
//
//  Created by relax on 2017/8/2.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTCategoryFoodModel.h"
#import "MTFoodModel.h"

@implementation MTCategoryFoodModel

+ (instancetype)categoryFoodWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}


- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"spus"])
    {
        NSArray *spusArr = value;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:spusArr.count];
        for (NSDictionary *spuDict in spusArr)
        {
            MTFoodModel *food = [MTFoodModel foodWithDict:spuDict];
            [arrM addObject:food];
        }
        _spus = arrM.copy;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", self.name];
}

@end
