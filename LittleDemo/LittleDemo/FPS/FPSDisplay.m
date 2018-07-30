//
//  FPSDisplay.m
//  test
//
//  Created by Lynn on 2017/11/2.
//  Copyright © 2017年 Lynn. All rights reserved.
//

#import "FPSDisplay.h"
#import <UIKit/UIKit.h>
@interface FPSDisplay()

@property (strong, nonatomic) UILabel *displayLabel;//显示

@property (strong, nonatomic) CADisplayLink *link;//CADisplayLink是一个将定时器绑定到显示屏上负责垂直同步的类

@property (assign, nonatomic) NSInteger count;//FPS值大小

@property (assign, nonatomic) NSTimeInterval lastTime;//时间间隔

@property (strong, nonatomic) UIFont *font;

@property (strong, nonatomic) UIFont *subFont;
@end

@implementation FPSDisplay
+ (instancetype)shareFPSDisplay {
    
    static FPSDisplay *shareDisplay;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        shareDisplay = [[FPSDisplay alloc] init];
        
    });
    
    return shareDisplay;
    
}
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self initDisplayLabel];
        
    }
    
    return self;
    
}

- (void)initDisplayLabel {
    
    //设置label的大小  我们将label放在屏幕右下角位置
    
    CGRect frame = CGRectMake(CGRectGetWidth([[UIApplication sharedApplication].windows lastObject].frame)-100, CGRectGetHeight([[UIApplication sharedApplication].windows lastObject].frame)-50, 80, 30);
    
    self.displayLabel = [[UILabel alloc] initWithFrame: frame];
    
    self.displayLabel.layer.cornerRadius = 5;
    
    self.displayLabel.clipsToBounds = YES;
    
    self.displayLabel.textAlignment = NSTextAlignmentCenter;
    
    self.displayLabel.userInteractionEnabled = NO;
    
    self.displayLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    
    _font = [UIFont fontWithName:@"Menlo" size:14];
    
    if (_font) {
        
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
        
    } else {
        
        _font = [UIFont fontWithName:@"Courier" size:14];
        
        _subFont = [UIFont fontWithName:@"Courier" size:4];
        
    }
    
    //
    
    [self initCADisplayLink];
    
    //在每个页面都可以显示FPS
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self.displayLabel];
    [[UIApplication sharedApplication].keyWindow addSubview:self.displayLabel];
    
}

- (void)initCADisplayLink {
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)tick:(CADisplayLink *)link {
    
    if (self.lastTime == 0) {   //对LastTime进行初始化
        
        self.lastTime = link.timestamp;
        
        return;
        
    }
    
    self.count += 1;    //记录tick在1秒内执行的次数
    
    NSTimeInterval delta = link.timestamp - self.lastTime;  //计算本次刷新和上次更新FPS的时间间隔
    
    //大于等于1秒时，来计算FPS
    
    if (delta >= 1) {
        
        self.lastTime = link.timestamp;
        
        float fps = self.count / delta; // 次数 除以 时间 = FPS （次/秒）
        
        self.count = 0;
        
        [self updateDisplayLabelText: fps];//刷新FPS值
        
    }
    
}

- (void)updateDisplayLabelText: (float) fps {
    
    //实现更新label上的FPS值
    
    CGFloat progress = fps / 60.0;
    
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    self.displayLabel.text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    
    self.displayLabel.textColor = color;
    [[[UIApplication sharedApplication].windows lastObject] bringSubviewToFront:self.displayLabel];
}

- (void)dealloc {
    
    //最后需要注销一下
    
    [_link invalidate];
    
}
@end
