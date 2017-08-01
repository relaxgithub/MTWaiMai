//
//  MTDiscount2Model.m
//  MTWaiMai
//
//  Created by relax on 2017/8/1.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTDiscount2Model.h"

@implementation MTDiscount2Model

+ (instancetype)discount2WithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@-%@",_icon_url,_info];
}

@end
