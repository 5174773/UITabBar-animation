//
//  UITabBar+a.m
//  tabBar动画
//
//  Created by Allen on 16/12/9.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "LJGNB.h"
#import <objc/runtime.h>

@implementation UITabBar (a)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(layoutSubviewsNew) originalSelector:@selector(layoutSubviews)];
    });
}

+ (void)swizzleMethod:(SEL)swizzledSelector originalSelector:(SEL)originalSelector
{
    Class swizzledClass = [self class];
    
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);
    const char *swizzledType = method_getTypeEncoding(swizzledMethod);
    
    Method originalMethod = class_getInstanceMethod(swizzledClass, originalSelector);
    IMP originalIMP = method_getImplementation(originalMethod);
    const char *originalType = method_getTypeEncoding(originalMethod);
    
    class_replaceMethod(swizzledClass, swizzledSelector, originalIMP, originalType);
    class_replaceMethod(swizzledClass, originalSelector, swizzledIMP, swizzledType);
}

-(void)layoutSubviewsNew
{
    [self layoutSubviewsNew];
    
    //遍历判断self.subviews
    for (UIControl *tabBarBtn in self.subviews)
    {
        //判断是否是ALTbaBar
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [tabBarBtn addTarget:self action:@selector(tabBarBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

//添加动画
-(void)tabBarBtnDidClick:(UIControl *)tabBarButton
{
    //遍历出tabbar上的图片
    for (UIView *imageView in tabBarButton.subviews)
    {
        //判断图片是否是
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
        {
            imageView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            
            //动画
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:9 options:0 animations:^{
            
                imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
                        } completion:^(BOOL finished) {
            
                        }];
        }
    }
}



@end
