//
//  UIView+FindController.m
//  MTWaiMai
//
//  Created by relax on 2017/8/2.
//  Copyright © 2017年 relax. All rights reserved.
//

#import "UIView+FindController.h"

@implementation UIView (FindController)

- (UIViewController *)viewController
{
    // UIViewController : UIResponder
    UIViewController *controller = (UIViewController *)[self nextResponder];

    //    if ([controller isKindOfClass:[UIViewController class]]) {
    //        return controller;
    //    }

    while (controller)
    {
        if ([controller isKindOfClass:[UIViewController class]]) return controller;

        controller = (UIViewController *)controller.nextResponder;
    }
    
    return nil;
}

@end
