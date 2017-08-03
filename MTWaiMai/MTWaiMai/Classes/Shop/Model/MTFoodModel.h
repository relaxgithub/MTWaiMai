//
//  MTFoodModel.h
//  MTWaiMai
//
//  Created by relax on 2017/8/3.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTFoodModel : NSObject

/// 食品名称
@property (nonatomic,copy) NSString *name;

/// 食品描述
@property (nonatomic,copy) NSString *desc;

/// 配图
@property (nonatomic,copy) NSString *picture;

/// 月售
@property (nonatomic,copy) NSString *month_saled_content;

/// 点赞
@property (nonatomic,copy) NSString *praise_content;

/// 价格
@property (nonatomic,copy) NSNumber *min_price;

/// 用户点餐数量
@property (nonatomic,assign) NSInteger count;

/// 点赞数
@property (nonatomic,assign) CGFloat praise_num;

/// 踩数
@property (nonatomic,assign) CGFloat tread_num;

+ (instancetype)foodWithDict:(NSDictionary *)dict;

@end
