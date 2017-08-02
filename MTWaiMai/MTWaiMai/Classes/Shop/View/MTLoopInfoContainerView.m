//
//  MTLoopInfoContainerView.m
//  MTWaiMai
//
//  Created by relax on 2017/8/1.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTLoopInfoContainerView.h"
#import "MTLoopInfoView.h"

#define KLoopInfoCount _models.count

@interface MTLoopInfoContainerView ()

@property (nonatomic,weak) MTLoopInfoView *loopInfoView1;
@property (nonatomic,weak) MTLoopInfoView *loopInfoView2;

@property (nonatomic,assign) int index;

@end

@implementation MTLoopInfoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        // _index = -1;
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
    self.clipsToBounds = YES;
    // 创建2个loopinfo
    MTLoopInfoView *loopInfoView1 = [[MTLoopInfoView alloc] init];
    [self addSubview:loopInfoView1];
    _loopInfoView1 = loopInfoView1;
    [loopInfoView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    MTLoopInfoView *loopInfoView2 = [[MTLoopInfoView alloc] init];
    [self addSubview:loopInfoView2];
    _loopInfoView2 = loopInfoView2;
    [loopInfoView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(20);
        make.height.offset(20);
    }];

    // 右边箭头
    UIImageView *rightArrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_white"]];
    [self addSubview:rightArrowView];

    [rightArrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.offset(0);
    }];
}


- (void)setModels:(NSArray<MTDiscount2Model *> *)models
{
    _models = models;
    _loopInfoView1.discountModel = _models[0];//0
    _loopInfoView2.discountModel = _models[1];//1

    /**
    //    while (true) {
    //
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //            _loopInfoView1.discountModel = models[_index];
    //            _loopInfoView2.discountModel = models[++_index];
    //
    //            [UIView animateWithDuration:1 animations:^{
    //                _loopInfoView1.transform = CGAffineTransformMakeTranslation(0, 20);
    //                _loopInfoView2.transform = CGAffineTransformMakeTranslation(0, 20);
    //            } completion:^(BOOL finished) {
    //                _index++;
    //                if (_index == _models.count) {
    //                    _index = 0;
    //                }
    //                _loopInfoView1.transform = CGAffineTransformIdentity;
    //                _loopInfoView2.transform = CGAffineTransformIdentity;
    //            }];
    //        });
    //    }

     */
    
    [self scroll];
}

- (void)scroll
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        _loopInfoView1.discountModel = _models[_index % KLoopInfoCount];//0
        _loopInfoView2.discountModel = _models[++_index % KLoopInfoCount];//1

        [UIView animateWithDuration:1 animations:^{
            _loopInfoView1.transform = CGAffineTransformMakeTranslation(0, -20);
            _loopInfoView2.transform = CGAffineTransformMakeTranslation(0, -20);
        } completion:^(BOOL finished) {
            _loopInfoView1.discountModel = _models[_index % KLoopInfoCount];//1
            _loopInfoView2.discountModel = _models[++_index % KLoopInfoCount];//2
            _loopInfoView1.transform = CGAffineTransformIdentity;
            _loopInfoView2.transform = CGAffineTransformIdentity;
            // index = 1
            --_index;
            [self scroll];
        }];
    });
    
}


@end
