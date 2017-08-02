//
//  MTHeaderView.m
//  MTWaiMai
//
//  Created by relax on 2017/7/31.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTHeaderView.h"
#import "MTPOI_SHOP_Model.h"
#import "MTLoopInfoContainerView.h"

@interface MTHeaderView ()

/// 轮播视图
@property (nonatomic,weak) MTLoopInfoContainerView *loopInfoView;

/// 头像
@property (nonatomic,weak) UIImageView *avartaView;

/// 店名
@property (nonatomic,weak) UILabel *nameLabel;

/// 店铺公告
@property (nonatomic,weak) UILabel *bulletinLabel;

/// 背景图片
@property (nonatomic,weak) UIImageView *backImgView;



@end

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

    // 0.设置一个背景图片
    UIImageView *backImgView = [[UIImageView alloc] init];
    [self addSubview:backImgView];
    backImgView.contentMode = UIViewContentModeScaleToFill;
    _backImgView = backImgView;

    [backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    // 1.轮播信息
    MTLoopInfoContainerView *loopInfoView = [[MTLoopInfoContainerView alloc] init];
    [self addSubview:loopInfoView];
    _loopInfoView = loopInfoView;
    loopInfoView.backgroundColor = [UIColor clearColor];

    [loopInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(-8);
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
    _avartaView = avartaView;
    // avartaView.backgroundColor = [UIColor purpleColor];
    avartaView.contentMode = UIViewContentModeScaleAspectFill;
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
    _nameLabel = nameLabel;
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
    _bulletinLabel = bulletinLabel;
    bulletinLabel.text = @"良心发现,不够缺德事,良心发现,不够缺德事,良心发现,不够缺德事缺德事缺德事缺德事";
    bulletinLabel.font = [UIFont systemFontOfSize:14];
    bulletinLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1.0];

    [bulletinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left).offset(0);
        make.centerY.equalTo(avartaView.mas_centerY).offset(16);
        make.right.equalTo(self).offset(-20);
    }];

}

- (void)setPoi_Shop_Model:(MTPOI_SHOP_Model *)poi_Shop_Model
{
    _poi_Shop_Model = poi_Shop_Model;

    // 给对应的子视图赋值

    // 头像
    NSURL *picURL = [NSURL URLWithString:[poi_Shop_Model.pic_url stringByDeletingPathExtension]];
   // NSLog(@"%@",picURL);

    [_avartaView sd_setImageWithURL:picURL];
    // 店名
    _nameLabel.text = poi_Shop_Model.name;
    // 公告
    _bulletinLabel.text = poi_Shop_Model.bulletin;

    // 设置背景图片
    [_backImgView sd_setImageWithURL:[NSURL URLWithString:[poi_Shop_Model.poi_back_pic_url stringByDeletingPathExtension]]];

    // 设置轮播视图
    _loopInfoView.models = poi_Shop_Model.discounts;
    // 间接传给模态控制器
    _loopInfoView.shopModel = _poi_Shop_Model;

}

@end
