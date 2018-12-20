//
//  LDDropMenuItem.m
//  LittleDemo
//
//  Created by Lynn on 2018/12/18.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDDropMenuItem.h"
#import "LDDropMenuItemModel.h"

@implementation LDDropMenuItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame itemModel:(LDDropMenuItemModel *)itemModel
{
    self = [self initWithFrame:frame];
    if (self) {
        [self createButtonWithFrame:frame itemModel:itemModel];
    }
    return self;
}

- (void)createButtonWithFrame:(CGRect)frame itemModel:(LDDropMenuItemModel *)itemModel
{
    UIButton *btn = [[UIButton alloc] initWithFrame:self.bounds];
    btn.tag = itemModel.type;
    NSString *title = itemModel.title;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    [btn addTarget:itemModel.target action:itemModel.action forControlEvents:UIControlEventTouchUpInside];
    //    [self.btn setBackgroundImage:[UIColor purpleColor] forState:UIControlStateSelected];
    [self addSubview:btn];
}


@end
