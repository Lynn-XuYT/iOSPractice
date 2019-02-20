//
//  LDItemViewModel.h
//  LittleDemo
//
//  Created by lynn on 2019/2/19.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LDItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LDItemViewModel : NSObject

@property (nonatomic, strong, readonly) UIImage *userAvatarImage;
@property (nonatomic, strong, readonly) UIFont *usernameFont;
@property (nonatomic, strong, readonly) UIFont *summaryFont;
@property (nonatomic, assign, readonly) CGRect headerRect;
@property (nonatomic, assign, readonly) CGRect usernameRect;
@property (nonatomic, assign, readonly) CGRect summeryRect;
@property (nonatomic, assign, readonly) CGFloat viewHeight;
@property (nonatomic, strong) LDItemModel *itemModel;

@end

NS_ASSUME_NONNULL_END
