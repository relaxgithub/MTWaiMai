//
//  MTPOI_SHOP_Model.m
//  MTWaiMai
//
//  Created by relax on 2017/7/31.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTPOI_SHOP_Model.h"
#import "MTDiscount2Model.h"


@implementation MTPOI_SHOP_Model

+ (instancetype)poi_ShopWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];

    return obj;
}


/// 当KVC字典给对象赋值时,如果以字典的key,没有对应model的属性映射,会调用这个方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"discounts2"]) {
        NSArray *array = value;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            MTDiscount2Model *model = [MTDiscount2Model discount2WithDict:dict];
            [arrM addObject:model];
        }

        _discounts = arrM;
    }
}

@end
