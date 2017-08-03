//
//  MTFoodDetailController.h
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTBaseController.h"
@class MTFoodModel,MTCategoryFoodModel;

@interface MTFoodDetailController : MTBaseController

@property (nonatomic,strong) NSIndexPath *scrollToIndexPath;

@property (nonatomic,strong) NSArray<MTCategoryFoodModel *> *categoryFoodData;

@end
