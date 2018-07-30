//
//  DLTabBarView.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/14.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "DLTabBarView.h"
#import "DLTabBarItem.h"

@interface DLTabBarView()
@property (nonatomic, strong) DLTabBarItem *selectedItem;
@end
@implementation DLTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void)setTabBarItems:(NSArray<DLTabBarItem *> *)tabBarItems
{
    if (tabBarItems.count < 1)
    {
        return;
    }
    _tabBarItems = tabBarItems;
    CGFloat width = CGRectGetWidth(self.frame) / tabBarItems.count;
    CGFloat height = CGRectGetHeight(self.frame);
    for (int i = 0; i< tabBarItems.count; i++) {
        DLTabBarItem *item = tabBarItems[i];
        item.frame = CGRectMake(width * i, 0, width, height);
        item.tag = i;
        if (i % 5 == 2) {
            item.frame = CGRectMake(width * i, -20, width, height + 20);
        }
        [item addTarget:self action:@selector(touchUpInset:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
    self.selectedItem = tabBarItems[0];
    self.selectedItem.selected = YES;
}

- (void)touchUpInset:(id)sender
{
    DLTabBarItem *item = (DLTabBarItem *)sender;
    if (self.selectedItem.tag == item.tag)
    {
        return;
    }
    if (item.tag != 2)
    {
        self.selectedItem.selected = NO;
        item.selected = YES;
        self.selectedItem = item;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectedAtIndex:)])
    {
        [self.delegate selectedAtIndex:item.tag];
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
