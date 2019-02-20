//
//  LDItemCell.m
//  LittleDemo
//
//  Created by lynn on 2019/2/19.
//  Copyright © 2019 Lynn. All rights reserved.
//

#import "LDItemCell.h"

@interface LDItemCell()

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *summaryLabel;

@end

@implementation LDItemCell


- (instancetype)init
{
    if (self = [super init]) {
        self.headView = [UIImageView new];
        self.nameLabel = [UILabel new];
        self.summaryLabel = [UITextField new];
        [self.contentView addSubview:self.headView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.summaryLabel];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headView = [UIImageView new];
        self.nameLabel = [UILabel new];
        self.summaryLabel = [UILabel new];
        self.summaryLabel.numberOfLines = 0;
        [self addSubview:self.headView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.summaryLabel];
    }
    return self;
}

- (void)setViewModel:(LDItemViewModel *)viewModel
{
    _viewModel = viewModel;
    self.nameLabel.font = viewModel.usernameFont;
    self.nameLabel.text = viewModel.itemModel.username;
    self.nameLabel.frame = viewModel.usernameRect;
    
    self.headView.image = viewModel.userAvatarImage;
    self.headView.frame = viewModel.headerRect;
    
    self.summaryLabel.font = viewModel.summaryFont;
    self.summaryLabel.text = viewModel.itemModel.summery;
    self.summaryLabel.frame = viewModel.summeryRect;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
