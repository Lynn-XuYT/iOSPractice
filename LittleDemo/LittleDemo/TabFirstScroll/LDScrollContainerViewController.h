//
//  LDScrollContainerViewController.h
//  LittleDemo
//
//  Created by Lynn on 2018/7/30.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDBaseViewController.h"

@interface LDScrollContainerViewController : LDBaseViewController

@property (nonatomic, assign) int index;
@property (nonatomic, strong) UIViewController *superController;
@end
