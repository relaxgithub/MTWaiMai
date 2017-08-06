//
//  MTFoodCell.h
//  MTWaiMai
//
//  Created by relax on 2017/8/3.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <UIKit/UIKit.h>




@class MTFoodModel,MTOrderCountView;

@interface MTFoodCell : UITableViewCell

@property (nonatomic,strong) MTFoodModel *foodModel;

/// 计数view
@property (nonatomic,weak) MTOrderCountView *countView;

@end
