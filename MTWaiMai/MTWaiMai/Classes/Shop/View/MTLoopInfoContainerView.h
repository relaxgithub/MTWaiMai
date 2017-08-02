//
//  MTLoopInfoContainerView.h
//  MTWaiMai
//
//  Created by relax on 2017/8/1.
//  Copyright © 2017年 relax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDiscount2Model,MTPOI_SHOP_Model;

@interface MTLoopInfoContainerView : UIView

@property (nonatomic,strong) NSArray<MTDiscount2Model *> *models;
@property (nonatomic,strong) MTPOI_SHOP_Model *shopModel;

@end
