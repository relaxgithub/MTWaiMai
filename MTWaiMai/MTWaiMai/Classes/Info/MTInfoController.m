//
//  MTInfoController.m
//  MTWaiMai
//
//  Created by relax on 2017/7/31.
//  Copyright © 2017年 relax. All rights reserved.
//

// 商家详情控制器

#import "MTInfoController.h"
#import "MTLoopInfoView.h"


#define KMargin 16  // 商家详情边距

@interface MTScrollView : UIScrollView

@end

@implementation MTScrollView

/// 重写scrollView的touchesEnded方法,让scrollView自己处理touchesEnded事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

@end

@interface MTInfoController ()



@end

@implementation MTInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupUI];
}


#pragma mark - 设置UI
- (void)setupUI
{
    // NSLog(@"%@",_shopModel);

    // 1.设置背景图片
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [self.view addSubview:bgImgView];
    [bgImgView sd_setImageWithURL:[NSURL URLWithString:[_shopModel.poi_back_pic_url stringByDeletingPathExtension]]];

    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    // 2.关闭按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close_selected"] forState:UIControlStateSelected];
    [self.view addSubview:closeBtn];

    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-64);
    }];

    [closeBtn addTarget:self action:@selector(clickToDismiss) forControlEvents:UIControlEventTouchUpInside];

    // 3.商家内部数据布局
    MTScrollView *scrollView = [[MTScrollView alloc] init];
    [self.view addSubview:scrollView];
    // scrollView.backgroundColor = [UIColor lightGrayColor];

    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.equalTo(closeBtn.mas_top).offset(-KMargin * 2);
    }];

    // 4.contentView
    UIView *contentView = [[UIView alloc] init];
    [scrollView addSubview:contentView];
    // contentView.backgroundColor = [UIColor redColor];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
        make.width.equalTo(scrollView).offset(0);
        make.height.offset(1000);

        //        make.left.top.offset(0);
        //        make.width.offset(0);
        //        make.height.offset(1000);
        // 这种方式不行
    }];

    // 5.创建店铺名称Label
    UILabel *shopNameLabel = [UILabel makeLabelWithFontSize:15 fontColor:[UIColor colorWithWhite:1 alpha:1] text:_shopModel.name];
    [contentView addSubview:shopNameLabel];

    [shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(KMargin * 2.5);
    }];

    // 6.配送 ,价格 ,时间
    NSString *bulliten = [NSString stringWithFormat:@"%@ | %@ | %@",_shopModel.delivery_time_tip,_shopModel.min_price_tip,_shopModel.shipping_fee_tip];
    UILabel *shopBullitenLabel = [UILabel makeLabelWithFontSize:13 fontColor:[UIColor colorWithWhite:0.9 alpha:1] text:bulliten];
    [contentView addSubview:shopBullitenLabel];

    [shopBullitenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(shopNameLabel.mas_bottom).offset(KMargin * 0.5);
    }];

    // 分割线 折扣信息
    UILabel *shopDiscountLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor colorWithWhite:1 alpha:1] text:@"折扣信息"];
    [contentView addSubview:shopDiscountLabel];

    [shopDiscountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(shopBullitenLabel.mas_bottom).offset(KMargin * 3);
    }];

    // 左边分割线
    UIView *leftDiscountLineView = [[UIView alloc] init];
    leftDiscountLineView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:leftDiscountLineView];

    [leftDiscountLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopDiscountLabel).offset(0);
        make.left.offset(KMargin);
        make.right.equalTo(shopDiscountLabel.mas_left).offset(-KMargin);
        make.height.offset(1);
    }];

    // 右边
    UIView *rightDiscountLineView = [[UIView alloc] init];
    rightDiscountLineView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:rightDiscountLineView];

    [rightDiscountLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopDiscountLabel).offset(0);
        make.left.equalTo(shopDiscountLabel.mas_right).offset(KMargin);
        make.right.offset(-KMargin);
        make.height.offset(1);
    }];

    // 店铺广告
    UIStackView *stackView = [[UIStackView alloc] init];
    // 垂直布局
    stackView.axis = UILayoutConstraintAxisVertical;
    // 平均分布
    stackView.distribution = UIStackViewDistributionFillEqually;
    // 内部元素间距
    stackView.spacing = 10;

    for (int i = 0; i < _shopModel.discounts.count; i++)
    {
        MTLoopInfoView *loopView = [[MTLoopInfoView alloc] init];
        loopView.discountModel = _shopModel.discounts[i];
        [stackView addArrangedSubview:loopView];
    }

    [contentView addSubview:stackView];

    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(shopDiscountLabel.mas_bottom).offset(KMargin);
        make.height.offset(_shopModel.discounts.count * 30);
    }];


    // 店铺公告
    UILabel *shopDescriptionLabel = [UILabel makeLabelWithFontSize:16 fontColor:[UIColor whiteColor] text:@"店铺公告"];
    [contentView addSubview:shopDescriptionLabel];

    [shopDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stackView.mas_bottom).offset(KMargin * 2.5);
        make.centerX.offset(0);
    }];


    // 左边分割线
    UIView *leftDescriptionLineView = [[UIView alloc] init];
    leftDescriptionLineView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:leftDescriptionLineView];

    [leftDescriptionLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopDescriptionLabel).offset(0);
        make.left.offset(KMargin);
        make.right.equalTo(shopDescriptionLabel.mas_left).offset(-KMargin);
        make.height.offset(1);
    }];

    // 右边
    UIView *rightDescriptionLineView = [[UIView alloc] init];
    rightDescriptionLineView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:rightDescriptionLineView];

    [rightDescriptionLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shopDescriptionLabel).offset(0);
        make.left.equalTo(shopDescriptionLabel.mas_right).offset(KMargin);
        make.right.offset(-KMargin);
        make.height.offset(1);
    }];


    // 公告Label
    UILabel *shopBullitenLabel2 = [UILabel makeLabelWithFontSize:14 fontColor:[UIColor colorWithWhite:0.9 alpha:1] text:_shopModel.bulletin];
    shopBullitenLabel2.numberOfLines = 0;
    [contentView addSubview:shopBullitenLabel2];

    [shopBullitenLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shopDescriptionLabel.mas_bottom).offset(KMargin);
        make.left.offset(KMargin);
        make.right.offset(-KMargin);

        // 用约束计算contentView最大高度
        make.bottom.equalTo(contentView.mas_bottom).offset(-KMargin);
    }];
}

- (void)clickToDismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 点击view的空白处,关闭此视图
// 点击scrollView无法执行这个,是因为scrollView默认就实现了平移和拖拽等手势,在scrollView上面操作时,会拦截这个touch.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self clickToDismiss];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
