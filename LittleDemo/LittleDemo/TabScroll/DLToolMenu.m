//
//  DLToolMenu.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/13.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "DLToolMenu.h"

@implementation DLToolMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.indexDisplayMode = UIScrollViewIndexDisplayModeAlwaysHidden;
    }
    return self;
}

- (void)setDataSource:(NSArray <UIViewController *>*)dataSource
{
    _dataSource = dataSource;
    
    CGFloat count = dataSource.count;
    
    CGFloat width = CGRectGetWidth(self.frame) / 5.5;
    CGFloat height = CGRectGetHeight(self.frame);
    
    for (int i = 0; i < count; i++) {
        UIViewController *vc = dataSource[i];
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        [btn1 setTitle:vc.title forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor greenColor];
        btn1.tag = i;
        [btn1 addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn1];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, height - 3, width, 3)];
    view.backgroundColor = [UIColor blueColor];
    view.tag = 0x11;
    [self addSubview:view];
    self.contentSize = CGSizeMake(width * count, CGRectGetHeight(self.frame));
}

- (void)btnSelected:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([self.toolMenuDelegate respondsToSelector:@selector(selectAtIndex:)])
    {
        [self.toolMenuDelegate selectAtIndex:btn.tag];
    }
    
//    UIView *view = [self viewWithTag:0x11];
//    [UIView animateWithDuration:0.5 animations:^{
//        CGFloat x = CGRectGetWidth(view.frame) *  btn.tag;
//        if (x > CGRectGetWidth(self.frame))
//        {
//            self.contentOffset = CGPointMake(x - CGRectGetWidth(self.frame), 0);
//        }
//        view.frame = CGRectMake(CGRectGetWidth(view.frame) * btn.tag,CGRectGetMinY(view.frame), CGRectGetWidth(view.frame), 3);
////        view.center = btn.center;
//    }];
}

- (void)moveAction:(CGFloat)muti
{
    UIView *view = [self viewWithTag:0x11];
    
    CGFloat x = self.contentSize.width * muti;
//    if (CGRectGetWidth(self.frame) - self.contentSize.width / self.dataSource.count < x)
//    {
//        self.contentOffset = CGPointMake(x - CGRectGetWidth(self.frame) + self.contentSize.width / self.dataSource.count, 0);
//    }
    
    int count = 0;
    if (CGRectGetMinX(view.frame) > x)
    {
        count = floor( x / CGRectGetWidth(view.frame));// 向下取整
    }
    else
    {
        count = ceil( x / CGRectGetWidth(view.frame));// 向上取整
    }
    
    if (self.contentSize.width > CGRectGetWidth(self.frame))
    {
        if (count > 2 && count < self.dataSource.count - 3)
        {
            UIButton *btn = [self viewWithTag:count];
            self.contentOffset = CGPointMake(btn.center.x - self.center.x, 0);
        }
        else if (count >= self.dataSource.count - 3)
        {
            self.contentOffset = CGPointMake(self.contentSize.width - CGRectGetWidth(self.frame), 0);
        }
        else
        {
            self.contentOffset = CGPointMake(0, 0);
        }
    }
    view.frame = CGRectMake(x,CGRectGetMinY(view.frame), CGRectGetWidth(view.frame), 3);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
