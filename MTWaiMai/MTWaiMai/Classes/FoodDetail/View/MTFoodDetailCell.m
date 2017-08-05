//
//  MTFoodDetailCell.m
//  MTWaiMai
//
//  Created by relax on 2017/8/4.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTFoodDetailCell.h"
#import "MTFoodModel.h"

@interface MTFoodDetailCell () <UIScrollViewDelegate>
/// 配图
@property (nonatomic,weak) UIImageView *pictureView;
/// 名称
@property (nonatomic,weak) UILabel *nameLabel;
/// 月销售量
@property (nonatomic,weak) UILabel *month_saled_contentLabel;
/// 价格
@property (nonatomic,weak) UILabel *min_priceLabel;
/// 商品信息
@property (nonatomic,weak) UILabel *descLabel;
/// 好评率
@property (nonatomic,weak) UILabel *percentageLabel;
/// 好评率进度条
@property (nonatomic,weak) UIProgressView *progressView;
/// 商品信息描述
@property (nonatomic,weak) UILabel *foodInfoLabel;
/// 商品评价
@property (nonatomic,weak) UILabel *evaluationLabel;
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation MTFoodDetailCell

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
    // 1.因为可以上下滚动 == scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    [self.contentView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    // 打开垂直弹簧效果
    scrollView.alwaysBounceVertical = YES;

    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        make.width.equalTo(scrollView).offset(0);
        // make.height.offset(1000);
    }];

    // 2.滑动的imageView
    UIImageView *imgView = [[UIImageView alloc] init];
    [contentView addSubview:imgView];

    _pictureView = imgView;

    //http://p1.meituan.net/xianfu/d36a62f1130c63ffa5a61c9cfd2be9f0212992.jpg"
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://p1.meituan.net/xianfu/d36a62f1130c63ffa5a61c9cfd2be9f0212992.jpg"]];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;

    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(240);
    }];

    // 3.食物名称
    UILabel *nameLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor darkTextColor] text:@"妈妈蛋炒饭"];
    [contentView addSubview:nameLabel];
    _nameLabel = nameLabel;

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(8);
        make.left.offset(8);
    }];


    // 4.月售
    UILabel *month_saled_contentLabel = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor darkGrayColor] text:@"月售 9999"];
    [contentView addSubview:month_saled_contentLabel];
    _month_saled_contentLabel = month_saled_contentLabel;

    [month_saled_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(nameLabel.mas_bottom).offset(8);
    }];

    // 5.价格
    UILabel *min_priceLabel = [UILabel makeLabelWithFontSize:18 fontColor:[UIColor primatkeyColor] text:@"¥ 5.9"];
    [contentView addSubview:min_priceLabel];

    _min_priceLabel = min_priceLabel;

    [min_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(month_saled_contentLabel.mas_bottom).offset(16);
    }];

    // 6.商品信息
    UILabel *foodInfoLabel = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor darkGrayColor] text:@"商品信息"];
    [contentView addSubview:foodInfoLabel];
    _foodInfoLabel = foodInfoLabel;


    [foodInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(min_priceLabel.mas_bottom).offset(16);
    }];

    // 7.商品描述
    UILabel *descLabel = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor darkGrayColor] text:@"这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品描述这是商品"];
    descLabel.numberOfLines = 0;
    [contentView addSubview:descLabel];
    _descLabel = descLabel;

    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(foodInfoLabel.mas_bottom).offset(8);
        make.right.offset(-8);
    }];

    // 8.商品评价
    UILabel *evaluationLabel = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor darkGrayColor] text:@"商品评价"];
    [contentView addSubview:evaluationLabel];
    _evaluationLabel = evaluationLabel;

    [evaluationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(descLabel.mas_bottom).offset(8);
    }];

    // 9.商品评价UIView
    UIView *evaluationView = [[UIView alloc] init];
    UILabel *evalLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor darkGrayColor] text:@"好评率"];
    [evaluationView addSubview:evalLabel];
    UILabel *percentageLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor primatkeyColor] text:@"99%"];
    [evaluationView addSubview:percentageLabel];
    _percentageLabel = percentageLabel;

    // 逆向约束
    [evaluationView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];

    [evaluationView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:4 leadSpacing:1 tailSpacing:1];

    // 在设置好评率view的布局
    [contentView addSubview:evaluationView];

    [evaluationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(evaluationLabel.mas_bottom).offset(8);
    }];

    // 10.好评率进度条
    UIProgressView *progressView = [[UIProgressView alloc] init];
    progressView.layer.cornerRadius = 5;
    progressView.layer.masksToBounds = YES;
    progressView.progress = 0.51;
    progressView.progressTintColor = [UIColor primatkeyColor];
    [contentView addSubview:progressView];
    _progressView = progressView;

    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.right.offset(-8);
        make.top.equalTo(evaluationView.mas_bottom).offset(8);
        make.height.offset(10);

        // 设置一个bottom,自动计算contentView的height
        make.bottom.offset(-8);
    }];

}

#pragma mark - 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0)
    {
        // 获得缩放系数
        CGFloat scale = [@(scrollView.contentOffset.y) calculatorResultWithValue1:MTValueMake(0, 1) value2:MTValueMake(-240, 2)];

        // 先在y上移
        //        _pictureView.transform = CGAffineTransformTranslate(_pictureView.transform, 0, scrollView.contentOffset.y * 0.5);
        //
        //        // 再在平移的transform基础上缩放
        //        _pictureView.transform = CGAffineTransformScale(_pictureView.transform, scale, scale);

        CGAffineTransform transform = CGAffineTransformIdentity;

        // 先平移
        transform = CGAffineTransformTranslate(transform, 0, scrollView.contentOffset.y * 0.5);

        // 在缩放
        transform = CGAffineTransformScale(transform, scale, scale);

        _pictureView.transform = transform;


    }
}

#pragma mark - 设置model数据
- (void)setFoodModel:(MTFoodModel *)foodModel
{
    _foodModel = foodModel;

    // 名称
    _nameLabel.text = foodModel.name;
    // 月售
    _month_saled_contentLabel.text = foodModel.month_saled_content;
    // 单价
    _min_priceLabel.text = [@"¥ " stringByAppendingString:foodModel.min_price.description];
    // 商品描述
    // _descLabel.text = foodModel.desc;
    _descLabel.text = [foodModel.desc stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([_descLabel.text isEqualToString:@""] || _descLabel.text == nil)
    {
        _foodInfoLabel.hidden = YES;
        [_evaluationLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            // 换了约束对象,就不是更新约束了?
            // make.top.equalTo(_min_priceLabel.mas_bottom).offset(16);
            make.top.equalTo(_descLabel.mas_bottom).offset(-24);
        }];


    }
    else
    {
        _foodInfoLabel.hidden = NO;
        [_evaluationLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_descLabel.mas_bottom).offset(8);
        }];
    }
    // 配图
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:[foodModel.picture stringByDeletingPathExtension]]];
    // 计算比例
    if (!(foodModel.praise_num + foodModel.tread_num))
    {
        _percentageLabel.text = @"0%";
        _progressView.progress = 0.0;
    }
    else
    {
        CGFloat percentage = foodModel.praise_num / (foodModel.praise_num + foodModel.tread_num);

        _percentageLabel.text = [NSString stringWithFormat:@"%.2f%%",percentage * 100];
        _progressView.progress = percentage;
    }

}

@end
