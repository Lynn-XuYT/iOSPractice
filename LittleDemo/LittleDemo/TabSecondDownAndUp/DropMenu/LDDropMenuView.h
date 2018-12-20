//
//  LDDropMenuView.h
//  LittleDemo
//
//  Created by Lynn on 2018/12/17.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDropMenuItemModel.h"

@protocol LDDropMenuViewDelegate<NSObject>
- (void)onDropMenuItemClicked:(UIButton *)button;
@end

@interface LDDropMenuView : UIView

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) id<LDDropMenuViewDelegate> delegate;
@end
