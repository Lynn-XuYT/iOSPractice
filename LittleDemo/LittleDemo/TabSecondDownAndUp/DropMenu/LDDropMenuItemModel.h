//
//  LDDropMenuItemModel.h
//  LittleDemo
//
//  Created by Lynn on 2018/12/18.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DropMenuItem_1 = 1,
    DropMenuItem_2,
    DropMenuItem_3,
    DropMenuItem_4,
} DropMenuItemType;

@interface LDDropMenuItemModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) DropMenuItemType type;
@property (nonatomic, assign) SEL action;
@property (nonatomic, strong) UIView *target;
- (instancetype)initWithTitle:(NSString *)title type:(DropMenuItemType)type action:(SEL)action target:(UIView *)target;
@end
