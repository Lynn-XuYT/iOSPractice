//
//  LDBaseViewController.h
//  LittleDemo
//
//  Created by Lynn on 2018/8/2.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDBaseViewController : UIViewController
// for subclass implement
@property (nonatomic, strong) NSMutableArray *dataSource;

// for subclass implement
- (void)initDataSouce;
@end
