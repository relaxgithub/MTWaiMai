//
//  MTPOI_SHOP_Model.h
//  MTWaiMai
//
//  Created by relax on 2017/7/31.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTDiscount2Model;

@interface MTPOI_SHOP_Model : NSObject

/// avartaImg 头像图片
@property (nonatomic,copy) NSString *pic_url;

/// headerView的背景图片
@property (nonatomic,copy) NSString *poi_back_pic_url;

/// 店名
@property (nonatomic,copy) NSString *name;

/// 店铺公告
@property (nonatomic,copy) NSString *bulletin;

/// 轮播广告
@property (nonatomic,strong) NSArray<MTDiscount2Model *> *discounts;

/// 配送时间
@property (nonatomic,copy) NSString *delivery_time_tip;

/// 起送价
@property (nonatomic,copy) NSString *min_price_tip;

/// 配送费
@property (nonatomic,copy) NSString *shipping_fee_tip;

+ (instancetype)poi_ShopWithDict:(NSDictionary *)dict;

@end
