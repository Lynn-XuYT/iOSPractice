//
//  LDItemCell.h
//  LittleDemo
//
//  Created by lynn on 2019/2/19.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDItemViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDItemCell : UITableViewCell

@property (nonatomic, strong) LDItemViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
