//
//  MTFoodListSectionHeaderView.m
//  MTWaiMai
//
//  Created by relax on 2017/8/3.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTFoodListSectionHeaderView.h"

@implementation MTFoodListSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.textLabel.font = [UIFont systemFontOfSize:12];
}

@end
