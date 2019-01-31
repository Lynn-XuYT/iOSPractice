//
//  LDTabBarView.h
//  LittleDemo
//
//  Created by Lynn on 2018/3/14.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDTabBarItem;

@protocol LDTabBarViewDelegate

- (void)selectedAtIndex:(NSInteger)index;
@end

@interface LDTabBarView : UIView
@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) NSArray<LDTabBarItem*> *tabBarItems;
@end
