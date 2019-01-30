//
//  LDDropMenu.m
//  LittleDemo
//
//  Created by Lynn on 2018/12/18.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDDropMenu.h"
#import "LDDropMenuItem.h"

@implementation LDDropMenu

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray<LDDropMenuItemModel *> *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = dataSource;
        self.backgroundColor = [UIColor lightGrayColor];
        self.contentSize = CGSizeMake(dataSource.count * 180 > CGRectGetWidth(frame) ? dataSource.count * 180 : CGRectGetWidth(frame), CGRectGetHeight(frame));
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = CGRectGetWidth(rect)/3;
    CGFloat height = CGRectGetHeight(rect);
    for (int i = 0; i < self.dataSource.count; i++) {
        CGRect subrect = CGRectMake(x, y, width, height);
        LDDropMenuItem *item = [[LDDropMenuItem alloc] initWithFrame:subrect itemModel:self.dataSource[i]];
        [self addSubview:item];
        x += width;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
