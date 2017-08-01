//
//  MTDiscount2Model.h
//  MTWaiMai
//
//  Created by relax on 2017/8/1.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDiscount2Model : NSObject

@property (nonatomic,copy) NSString *icon_url;

@property (nonatomic,copy) NSString *info;

+ (instancetype)discount2WithDict:(NSDictionary *)dict;

@end
