//
//  LDDropMenu.h
//  LittleDemo
//
//  Created by Lynn on 2018/12/18.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDDropMenuItemModel;

@interface LDDropMenu : UIScrollView

@property (nonatomic, strong) NSArray *dataSource;
- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray<LDDropMenuItemModel *> *)dataSource;
@end
