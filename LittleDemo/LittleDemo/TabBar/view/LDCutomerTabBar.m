//
//  LDCutomerTabBar.m
//  LittleDemo
//
//  Created by lynn on 2019/1/31.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDCutomerTabBar.h"
#import "LDTabBarView.h"

@implementation LDCutomerTabBar


- (void)addSubview:(UIView *)view
{
    if ([view isKindOfClass:[LDTabBarView class]]) {
        [super addSubview:view];
    }
}

@end
