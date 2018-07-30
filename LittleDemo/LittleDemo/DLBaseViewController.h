//
//  DLBaseViewController.h
//  LittleDemo
//
//  Created by Lynn on 2018/3/12.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface DLBaseViewController : UITabBarController
- (instancetype)initWithTittle:(NSString *)title imageName:(NSString *)imageName;
@end
