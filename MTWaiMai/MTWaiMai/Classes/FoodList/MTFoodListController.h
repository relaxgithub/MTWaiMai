//
//  MTFoodListController.h
//  MTWaiMai
//
//  Created by relax on 2017/8/2.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTCategoryFoodModel;

@interface MTFoodListController : UIViewController
/// 保存视频分类数据
@property (nonatomic,strong) NSArray<MTCategoryFoodModel *> *categoryFoodData;
@end
