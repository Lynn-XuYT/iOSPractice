//
//  LDItemViewModel.m
//  LittleDemo
//
//  Created by lynn on 2019/2/19.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDItemViewModel.h"

@implementation LDItemViewModel

- (void)setItemModel:(LDItemModel *)itemModel
{
    _itemModel = itemModel;
    if ([NSThread currentThread].isMainThread) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self fillAttributes];
        });
    }
    else{
        [self fillAttributes];
    }
}

- (void)fillAttributes {
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_itemModel.userAvatarURL]];
    _userAvatarImage = [UIImage imageWithData:imageData];
    
    _usernameFont = [UIFont systemFontOfSize:20];
    _summaryFont = [UIFont systemFontOfSize:15];
    
    CGFloat padding = 5;
    
    CGFloat headerHeight = 50;
    _headerRect = CGRectMake(padding, padding, headerHeight, headerHeight);
    CGFloat usernameOrignX = CGRectGetMaxX(_headerRect) + padding;
    CGFloat usernameWidth = SCREEN_WIDTH - usernameOrignX - padding;
    CGFloat usernameHeight = [_itemModel.username boundingRectWithSize:CGSizeMake(usernameWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_usernameFont} context:nil].size.height;
    _usernameRect = CGRectMake(usernameOrignX, padding, usernameWidth, usernameHeight);
    CGFloat summeryHeight = [_itemModel.summery boundingRectWithSize:CGSizeMake(usernameWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_summaryFont} context:nil].size.height;
    _summeryRect = CGRectMake(usernameOrignX, CGRectGetMaxY(_usernameRect) + padding * 0.5, usernameWidth, summeryHeight);
    
    _viewHeight = CGRectGetMaxY(_headerRect) > CGRectGetMaxY(_summeryRect) ? CGRectGetMaxY(_headerRect) + padding : CGRectGetMaxY(_summeryRect) + padding;
}
@end
