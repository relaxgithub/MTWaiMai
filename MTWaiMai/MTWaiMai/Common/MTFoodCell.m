//
//  MTFoodCell.m
//  MTWaiMai
//
//  Created by relax on 2017/8/3.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTFoodCell.h"
#import "MTFoodModel.h"
#import "MTOrderCountView.h"

@interface MTFoodCell ()

/// 点赞label
@property (weak, nonatomic) UILabel *praise_contentLabel;
/// 月售
@property (weak, nonatomic) UILabel *month_saled_contentLabel;
/// 食物介绍
@property (weak, nonatomic) UILabel *descriptionLabel;
/// 食物的名字
@property (weak, nonatomic) UILabel *nameLabel;
/// 配图
@property (weak, nonatomic) UIImageView *pictureView;

/// 价格
@property (nonatomic,weak) UILabel *min_priceLabel;


@end

@implementation MTFoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    // self.backgroundColor = [UIColor primatkeyColor];
    //1.配图
    UIImageView *pictureView = [[UIImageView alloc] init];
    pictureView.image = [UIImage imageNamed:@"img_food_loading"];
    pictureView.contentMode = UIViewContentModeScaleAspectFill;
    pictureView.layer.masksToBounds = YES;
    [self.contentView addSubview:pictureView];
    _pictureView = pictureView;

    [pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(8);
        make.width.height.offset(64);
    }];

    //2.名称
    UILabel *nameLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor darkTextColor] text:@"地狱炒饭"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pictureView).offset(0);
        make.left.equalTo(pictureView.mas_right).offset(8);
    }];

    //3.描述
    UILabel *descriptionLabel = [UILabel makeLabelWithFontSize:13 fontColor:[UIColor lightGrayColor] text:@"这是地狱炒饭描述..这是地狱炒饭描述..这是地狱炒饭描述"];
    [self.contentView addSubview:descriptionLabel];
    _descriptionLabel = descriptionLabel;
    descriptionLabel.numberOfLines = 2;


    [descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(8);
        make.left.equalTo(nameLabel).offset(0);
        make.right.offset(-8);
        make.height.lessThanOrEqualTo(@100);
    }];

    //4.月售
    UILabel *month_saled_contentLabel = [UILabel makeLabelWithFontSize:11 fontColor:[UIColor lightGrayColor] text:@"月售 2222"];
    [self.contentView addSubview:month_saled_contentLabel];
    _month_saled_contentLabel = month_saled_contentLabel;

    [month_saled_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel).offset(0);
        make.top.equalTo(descriptionLabel.mas_bottom).offset(8);
    }];

    //5.点赞
    UILabel *praise_contentLabel = [UILabel makeLabelWithFontSize:11 fontColor:[UIColor lightGrayColor] text:@"点赞 99"];
    [self.contentView addSubview:praise_contentLabel];
    _praise_contentLabel = praise_contentLabel;

    [praise_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(month_saled_contentLabel.mas_right).offset(8);
        make.centerY.equalTo(month_saled_contentLabel).offset(0);

        // make.bottom.offset(-8);
    }];

    // 6.价格
    UILabel *min_priceLabel = [UILabel makeLabelWithFontSize:17 fontColor:[UIColor primatkeyColor] text:@"¥ 9.9"];
    [self.contentView addSubview:min_priceLabel];
    _min_priceLabel = min_priceLabel;

    [min_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(praise_contentLabel.mas_bottom).offset(16);
        make.left.equalTo(nameLabel).offset(0);
        make.bottom.offset(-8);
    }];

    // 添加计数view
    MTOrderCountView *countView = [[MTOrderCountView alloc] init];
    // countView.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:countView];
    _countView = countView;
    [countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-8);
        make.centerY.equalTo(min_priceLabel).offset(0);
        make.width.offset(90);
        make.height.offset(27);
        // make.bottom.offset(-8);
    }];
}

- (void)setFoodModel:(MTFoodModel *)foodModel
{
    _foodModel = foodModel;

    // 配图
    @try {
        [_pictureView sd_setImageWithURL:[NSURL URLWithString:[_foodModel.picture stringByDeletingPathExtension]] placeholderImage:[UIImage imageNamed:@"img_food_loading"]];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);

    } @finally {

    }

    // 名称
    _nameLabel.text = _foodModel.name;

    // 描述
    _foodModel.desc = [_foodModel.desc stringByReplacingOccurrencesOfString:@" " withString:@""];
    _descriptionLabel.text = _foodModel.desc;
    if ([_foodModel.desc isEqualToString:@""]) {
        [_descriptionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).offset(0);
        }];
    } else {
        [_descriptionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).offset(8);
        }];
    }

    // 价格

     _min_priceLabel.text = [@"¥ " stringByAppendingFormat:@"%.1f",[_foodModel.min_price floatValue]];
//    NSLog(@"%@", [@"¥ " stringByAppendingString:_foodModel.min_price]);

    // 月售
    _month_saled_contentLabel.text = _foodModel.month_saled_content;

    // 点赞
    _praise_contentLabel.text = _foodModel.praise_content;

    // 给计数器视图传递数据
    _countView.foodModel = foodModel;
}

@end
