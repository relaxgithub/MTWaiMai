//
//  MTCategoryFoodModel.h
//  MTWaiMai
//
//  Created by relax on 2017/8/2.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTFoodModel;

@interface MTCategoryFoodModel : NSObject

/// 视频分类名称
@property (nonatomic,copy) NSString *name;

@property (nonatomic,strong) NSArray<MTFoodModel *> *spus;

+ (instancetype)categoryFoodWithDict:(NSDictionary *)dict;
@end
