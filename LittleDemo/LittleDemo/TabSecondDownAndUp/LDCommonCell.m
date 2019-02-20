//
//  LDCommonCell.m
//  LittleDemo
//
//  Created by Lynn on 2018/3/8.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDCommonCell.h"

@interface LDCommonCell()
@property (nonatomic, strong) UILabel *despLabel;

@end
@implementation LDCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *despLabel = [UILabel new];
        despLabel.textColor = [UIColor blueColor];
        despLabel.font = [UIFont systemFontOfSize:22];
        despLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:despLabel];
        self.despLabel = despLabel;
    }
    return self;
}

- (void)setData:(NSString *)desp
{
    self.despLabel.text = desp;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.despLabel.frame = self.contentView.frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
