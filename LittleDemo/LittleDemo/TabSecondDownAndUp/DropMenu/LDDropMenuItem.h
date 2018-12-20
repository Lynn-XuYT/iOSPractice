//
//  LDDropMenuItem.h
//  LittleDemo
//
//  Created by Lynn on 2018/12/18.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDDropMenuItemModel;
@interface LDDropMenuItem : UIView

@property (nonatomic, strong) UIButton *btn;
- (instancetype)initWithFrame:(CGRect)frame itemModel:(LDDropMenuItemModel *)itemModel;

@end
