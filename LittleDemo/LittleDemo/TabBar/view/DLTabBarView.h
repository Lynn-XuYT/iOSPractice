//
//  DLTabBarView.h
//  LittleDemo
//
//  Created by Lynn on 2018/3/14.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLTabBarItem;

@protocol DLTabBarViewDelegate

- (void)selectedAtIndex:(NSInteger)index;
@end

@interface DLTabBarView : UIView
@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) NSArray<DLTabBarItem*> *tabBarItems;
@end
