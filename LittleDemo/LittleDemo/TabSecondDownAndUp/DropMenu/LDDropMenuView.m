//
//  LDDropMenuView.m
//  LittleDemo
//
//  Created by Lynn on 2018/12/17.
//  Copyright © 2018年 Lynn. All rights reserved.
//

#import "LDDropMenuView.h"
#import "LDDropMenu.h"
#import "LDDropMenuItemModel.h"

#define CollectionPaddingLR 5
#define CollectionPaddingTB 10
#define CollectionItemH 80
#define CollectionItemHB 180
@interface LDDropMenuView()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) LDDropMenu *menu;

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionView *horizontalCollectionView;

@property (nonatomic, strong) NSArray *leftDataSource;
@property (nonatomic, strong) NSArray *rightDataSource;
@end

@implementation LDDropMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = CGRectGetHeight(frame);
        
        LDDropMenu *menu = [[LDDropMenu alloc] initWithFrame:CGRectMake(x, y, width, height) withDataSource:[self getItems]];
        [self addSubview:menu];
        self.menu = menu;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), SCREEN_HEIGHT)];
        bgView.backgroundColor = [UIColor colorWithRed:112/255.0 green:128/255.0 blue:144/255.0 alpha:0.3];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewOnTouch:)];
        [bgView addGestureRecognizer:gesture];
        bgView.alpha = 0;
        [self addSubview:bgView];
        self.bgView = bgView;
        
        UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgView.frame)/3.0, 0)];
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.bgView addSubview:leftTableView];
        self.leftTableView = leftTableView;
        
        UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame)/3.0, 0, CGRectGetWidth(bgView.frame) - CGRectGetWidth(bgView.frame)/3.0, 0)];
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.bgView addSubview:rightTableView];
        self.rightTableView = rightTableView;
        
        float itemCount = 4.0;
        
        UICollectionViewFlowLayout *layout = [self createCollectionLayout:CGSizeMake((SCREEN_WIDTH - CollectionPaddingLR *(itemCount + 1))/itemCount, CollectionItemH) scrollDirection:UICollectionViewScrollDirectionVertical];
        UICollectionView *collectionView = [self createCollectionView:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0) layout:layout];
        [self.bgView addSubview:collectionView];
        self.collectionView = collectionView;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        
        UICollectionViewFlowLayout *layoutHorizontal = [self createCollectionLayout:CGSizeMake((SCREEN_WIDTH - CollectionPaddingLR *(itemCount + 1))/itemCount, CollectionItemHB) scrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *horizontalCollectionView = [self createCollectionView:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0) layout:layoutHorizontal];
        
        horizontalCollectionView.showsHorizontalScrollIndicator = NO;
        [self.bgView addSubview:horizontalCollectionView];
        self.horizontalCollectionView = horizontalCollectionView;
        [self.horizontalCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellHorizontal"];
        
    }
    return self;
}

- (void)bgViewOnTouch:(UITapGestureRecognizer *)sender {
    
    CGPoint location = [sender locationInView:self.bgView];
    
    CGFloat height = [self getDropViewWithHeightType:self.selectedBtn.tag];
    if (location.y <= height) {
        return;
    }
    
    [self onBtnClick:self.selectedBtn];
}

- (void)onBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    UIButton *preSelectedBtn = self.selectedBtn;
    if (preSelectedBtn != btn) {
        btn.selected = YES;
        preSelectedBtn.selected = NO;
        self.selectedBtn = btn;
    }
    else{
        self.selectedBtn.selected = !self.selectedBtn.selected;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self changeFrames:CGRectMake(CGRectGetMinX(self.bgView.frame), 0, CGRectGetWidth(self.bgView.frame), 0) withType:(DropMenuItemType)preSelectedBtn.tag];
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        
        if (!self.selectedBtn.selected) {
            return;
        }
        CGFloat height = [self getDropViewWithHeightType:(DropMenuItemType)self.selectedBtn.tag];
        CGRect rect = CGRectMake(CGRectGetMinX(self.bgView.frame), 0, CGRectGetWidth(self.bgView.frame), height);
        [UIView animateWithDuration:0.3 animations:^{
            self.bgView.alpha = 1;
            [self changeFrames:rect withType:(DropMenuItemType)self.selectedBtn.tag];
        }];
    }];
    
    if ([self.delegate respondsToSelector:@selector(onDropMenuItemClicked:)]) {
        [self.delegate onDropMenuItemClicked:self.selectedBtn];
    }
}

//- (void)changeFrame:(CGRect)rect withType:(DropMenuItemType)type{
//    [UIView beginAnimations:@"FrameAni" context:nil];
//    [UIView setAnimationDuration:0.2];
//    [UIView setAnimationDelegate:self];
////    [UIView setAnimationWillStartSelector:@selector(startAni:)];
////    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
//    [UIView setAnimationRepeatCount:1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.bgView.frame = rect;
//    [UIView commitAnimations];
//}

- (void)changeFrames:(CGRect)rect withType:(DropMenuItemType)type{

    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), /*CGRectGetHeight(rect) + CGRectGetHeight(self.menu.frame)*/CGRectGetHeight(rect) > 0? SCREEN_HEIGHT : CGRectGetHeight(rect) + CGRectGetHeight(self.menu.frame));
    switch (type) {
        case DropMenuItem_1:
        {
            self.rightTableView.frame = CGRectMake(CGRectGetMinX(self.rightTableView.frame), CGRectGetMinY(self.rightTableView.frame), CGRectGetWidth(self.rightTableView.frame), CGRectGetHeight(rect));
            self.leftTableView.frame = CGRectMake(CGRectGetMinX(self.leftTableView.frame), CGRectGetMinY(self.leftTableView.frame), CGRectGetWidth(self.leftTableView.frame), CGRectGetHeight(rect));
        }
            break;
        case DropMenuItem_2:
        {
            self.collectionView.frame = rect;
        }
            break;
        case DropMenuItem_3:
        {
            self.horizontalCollectionView.frame = rect;
        }
            break;
        default:
            break;
    }
}

- (CGFloat)getDropViewWithHeightType:(DropMenuItemType)type {
    switch (type) {
        case DropMenuItem_1:
            return self.leftDataSource.count * 40;
            break;
        case DropMenuItem_2:
            return (ceilf(self.leftDataSource.count / 4.0) * CollectionItemH) + CollectionPaddingLR + CollectionPaddingTB * 2;
            break;
        case DropMenuItem_3:
            return CollectionItemHB + CollectionPaddingTB * 2;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.leftDataSource.count;
    }
    else if (tableView == self.rightTableView) {
        return self.rightDataSource.count;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commoncell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commoncell"];
    }
    if (tableView == self.leftTableView) {
        cell.textLabel.text = self.leftDataSource[indexPath.row];
    }
    else if (tableView == self.rightTableView) {
        cell.textLabel.text = self.rightDataSource[indexPath.row];
    }
    cell.backgroundColor = indexPath.row % 2 ? [UIColor purpleColor] : [UIColor orangeColor];
    cell.textLabel.textColor = indexPath.row % 2 ? [UIColor whiteColor] : [UIColor cyanColor];
//    NSMutableDictionary *dict = self.dataSource[indexPath.row];
//    [cell setData:[dict objectForKey:DescriptionString]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        return 40;
    }
    else if (tableView == self.rightTableView) {
        return 30;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView != self.leftTableView) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
//    NSMutableDictionary *dict = self.dataSource[indexPath.row];
//    Class cls = [dict objectForKey:ActionClass];
//    UIViewController * vc = [[cls alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    if (collectionView == self.collectionView) {
    }
    else if (collectionView == self.horizontalCollectionView) {
    }
    return self.leftDataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    if (collectionView == self.collectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    }
    else if (collectionView == self.horizontalCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellHorizontal" forIndexPath:indexPath];
    }
    
    cell.contentView.backgroundColor = indexPath.row%2 ? [UIColor redColor] : [UIColor blueColor];
    return cell;
}

- (UICollectionView *)createCollectionView:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout
{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.bounces = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    return collectionView;
}

- (UICollectionViewFlowLayout *)createCollectionLayout:(CGSize)itemSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    UICollectionViewFlowLayout *layoutHorizontal = [[UICollectionViewFlowLayout alloc] init];
    layoutHorizontal.itemSize = itemSize;//CGSizeMake((SCREEN_WIDTH - CollectionPaddingLR *(itemCount + 1))/itemCount, CollectionItemHB);
    layoutHorizontal.minimumLineSpacing = 5;
    layoutHorizontal.minimumInteritemSpacing = 0;
    layoutHorizontal.sectionInset = UIEdgeInsetsMake(CollectionPaddingTB, CollectionPaddingLR, CollectionPaddingTB,CollectionPaddingLR);
    layoutHorizontal.scrollDirection = scrollDirection;
    return layoutHorizontal;
}

- (NSArray *)getItems
{
    LDDropMenuItemModel *m1 = [[LDDropMenuItemModel alloc] initWithTitle:@"Drop1" type:(DropMenuItem_1) action:@selector(onBtnClick:) target:self];
    LDDropMenuItemModel *m2 = [[LDDropMenuItemModel alloc] initWithTitle:@"Drop2" type:(DropMenuItem_2) action:@selector(onBtnClick:) target:self];
    LDDropMenuItemModel *m3 = [[LDDropMenuItemModel alloc] initWithTitle:@"Drop3" type:(DropMenuItem_3) action:@selector(onBtnClick:) target:self];
    LDDropMenuItemModel *m4 = [[LDDropMenuItemModel alloc] initWithTitle:@"Drop4" type:(DropMenuItem_2) action:@selector(onBtnClick:) target:self];
    LDDropMenuItemModel *m5 = [[LDDropMenuItemModel alloc] initWithTitle:@"Drop5" type:(DropMenuItem_3) action:@selector(onBtnClick:) target:self];
    return @[m1, m2, m3, m4, m5];
}

- (NSArray *)leftDataSource {
    if (!_leftDataSource) {
        _leftDataSource = @[@"123",@"123",@"123",@"123",@"123",@"123",@"123"];
    }
    return _leftDataSource;
}

- (NSArray *)rightDataSource {
    if (!_rightDataSource) {
        _rightDataSource = @[@"123",@"123",@"123",@"123",@"123",@"123",@"123"];
    }
    return _rightDataSource;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
