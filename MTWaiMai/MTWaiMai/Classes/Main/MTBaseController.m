//
//  MTBaseController.m
//  MTWaiMai
//
//  Created by relax on 2017/7/30.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "MTBaseController.h"
#import "MTNavigationBar.h"

@interface MTBaseController ()

@end

@implementation MTBaseController

// 这个是控制器指定的初始化方法
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        // 在这里可以预创建一些子视图,赋值非位置和大小的属性.
        MTNavigationBar *bar = [[MTNavigationBar alloc] init];
        _bar = bar;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 在主视图加载完毕之后,在处理添加init里添加的子视图frame信息
    [self.view addSubview:_bar];
    [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(180);
    }];

    // 把这些个性化的内容放到子类中去设置.
    // _bar.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // 内存警告处理,基本上就是固定写法.
    if (self.isViewLoaded && self.view.window == nil)
    {
        // 不在栈顶的控制器,回收期视图view
        self.view = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
