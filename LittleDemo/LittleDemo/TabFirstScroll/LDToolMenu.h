//
//  LDToolMenu.h
//  LittleDemo
//
//  Created by Lynn on 2018/3/13.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LDToolMenuDelegate

- (void)selectAtIndex:(NSInteger)index;

@end

@interface LDToolMenu : UIScrollView

@property (nonatomic, assign) id toolMenuDelegate;
@property (nonatomic, strong) NSArray<UIViewController *> *dataSource;
- (void)moveAction:(CGFloat)muti;
@end
