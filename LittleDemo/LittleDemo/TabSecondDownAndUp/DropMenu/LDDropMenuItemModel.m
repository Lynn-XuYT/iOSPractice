//
//  LDDropMenuItemModel.m
//  LittleDemo
//
//  Created by Lynn on 2018/12/18.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDDropMenuItemModel.h"

@implementation LDDropMenuItemModel

- (instancetype)initWithTitle:(NSString *)title type:(DropMenuItemType)type action:(SEL)action target:(UIView *)target{
    
    if (self = [super init]) {
        self.title = title;
        self.type = type;
        self.action = action;
        self.target = target;
    }
    return self;
}

@end
