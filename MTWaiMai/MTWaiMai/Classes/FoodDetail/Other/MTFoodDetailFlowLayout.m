//
//  MTFoodDetailFlowLayout.m
//  MTWaiMai
//
//  Created by relax on 2017/8/4.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTFoodDetailFlowLayout.h"

@implementation MTFoodDetailFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];

    // 设置cell大小
    self.itemSize = self.collectionView.bounds.size;
    // 设置行列间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    // 设置滚动方法
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end
