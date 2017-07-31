//
//  MTHeaderView.m
//  MTWaiMai
//
//  Created by relax on 2017/7/31.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTHeaderView.h"

@implementation MTHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setupUI];
}

- (void)setupUI
{
    // 1.轮播信息
    UIView *loopInfoView = [[UIView alloc] init];
    [self addSubview:loopInfoView];
    loopInfoView.backgroundColor = [UIColor yellowColor];

    [loopInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(20);

    }];

    // 2.分割线
    UIView *dashLineView = [[UIView alloc] init];
    [self addSubview:dashLineView];
    // dashLineView.backgroundColor = [UIColor blueColor];
    dashLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage dashLineWithColor:[UIColor whiteColor]]];

    [dashLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.bottom.equalTo(loopInfoView.mas_top).offset(-8);
        make.height.offset(1);
        make.right.offset(0);
    }];

    // 3.头像
    UIImageView *avartaView = [[UIImageView alloc] init];
    [self addSubview:avartaView];
    avartaView.backgroundColor = [UIColor purpleColor];
    // 切圆角
    avartaView.layer.cornerRadius = 32;
    avartaView.clipsToBounds = YES;

    [avartaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dashLineView.mas_left).offset(0);
        make.bottom.equalTo(dashLineView.mas_top).offset(-8);
        make.height.width.offset(64);
    }];

    // 4.店名
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    nameLabel.text = @"粮新发现(上地店)";
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = [UIColor whiteColor];

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avartaView.mas_right).offset(16);
        make.centerY.equalTo(avartaView.mas_centerY).offset(-16);
    }];

    // 5.公告
    UILabel *bulletinLabel = [[UILabel alloc] init];
    [self addSubview:bulletinLabel];
    bulletinLabel.text = @"良心发现,不够缺德事,良心发现,不够缺德事,良心发现,不够缺德事缺德事缺德事缺德事";
    bulletinLabel.font = [UIFont systemFontOfSize:14];
    bulletinLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];

    [bulletinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left).offset(0);
        make.centerY.equalTo(avartaView.mas_centerY).offset(16);
        make.right.equalTo(self).offset(-20);
    }];

}

@end
