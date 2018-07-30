//
//  DLTabBarItem.h
//  LittleDemo
//
//  Created by Lynn on 2018/3/14.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLTabBarView.h"

@interface DLTabBarItem : UIButton

@property (nonatomic, assign) id tabBarViewDelegate;
- (instancetype)initWithTitle:(NSString *)title
              imageNameNormal:(NSString *)imageNameNormal
            imageNameSelected:(NSString *)imageNameSelected;
@end
