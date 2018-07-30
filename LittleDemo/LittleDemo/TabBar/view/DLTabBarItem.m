//
//  DLTabBarItem.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/14.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "DLTabBarItem.h"

@interface DLTabBarItem()

@property (nonatomic, strong) NSString *titleDesp;
@property (nonatomic, strong) NSString *imageNameNormal;
@property (nonatomic, strong) NSString *imageNameSelected;
@end

@implementation DLTabBarItem

- (instancetype)initWithTitle:(NSString *)title
              imageNameNormal:(NSString *)imageNameNormal
            imageNameSelected:(NSString *)imageNameSelected
{
    self = [super init];
    if (self) {
        self.titleDesp = title;
        self.imageNameNormal = imageNameNormal;
        self.imageNameSelected = imageNameSelected;
        [self setAdjustsImageWhenHighlighted:NO];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.titleDesp.length > 0)
    {
        //top, left, bottom, right
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(self.frame.size.height - 10, 0, 0, 0)];
        
        [self setTitle:self.titleDesp forState:UIControlStateNormal];
    }
    else
    {
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    [self setImage:[UIImage imageNamed:self.imageNameNormal] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:self.imageNameSelected] forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:self.imageNameSelected] forState:UIControlStateHighlighted];
    
}

- (void)setHighlighted:(BOOL)highlighted {
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
