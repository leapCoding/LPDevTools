//
//  LPSlideBar.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/9/5.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPSlideBar.h"
#import "LPSlideBarItem.h"

#define DEVICE_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SLIDER_VIEW_HEIGHT 3

@interface LPSlideBar ()<LPSlideBarItemDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) UIView *sliderView;
@property (strong, nonatomic) UIButton *rightButton;

@property (strong, nonatomic) LPSlideBarItem *selectedItem;
@property (strong, nonatomic) LPSlideBarItemSelectedCallback callback;

@end

@implementation LPSlideBar

#pragma mark - Lifecircle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.sliderView];
    }
    return self;
}

#pragma - mark Custom Accessors

- (void)setItemsTitle:(NSArray *)itemsTitle {
    _itemsTitle = itemsTitle;
    [self setupItems];
}

- (void)setItemColor:(UIColor *)itemColor {
    for (LPSlideBarItem *item in _items) {
        [item setItemTitleColor:itemColor];
    }
}

- (void)setItemFont:(UIFont *)itemFont {
    for (LPSlideBarItem *item in _items) {
        [item setItemTitleFont:itemFont];
    }
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor {
    for (LPSlideBarItem *item in _items) {
        [item setItemSelectedTitleColor:itemSelectedColor];
    }
}

- (void)setItemSelectedFont:(UIFont *)itemSelectedFont {
    for (LPSlideBarItem *item in _items) {
        [item setItemSelectedTileFont:itemSelectedFont];
    }
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    self.sliderView.backgroundColor = _sliderColor;
}

- (void)setSelectedItem:(LPSlideBarItem *)selectedItem {
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
}

- (void)setScrollViewSpacing:(CGFloat)scrollViewSpacing {
    _scrollViewSpacing = scrollViewSpacing;
    _scrollView.frame = CGRectMake(_scrollViewSpacing, 0, (self.frame.size.width-2*_scrollViewSpacing), self.frame.size.height);
}

- (void)setShowRightButton:(BOOL)showRightButton {
    _showRightButton = showRightButton;
    if (_showRightButton) {
        [self addSubview:self.rightButton];
        self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height);
    }
}

#pragma - mark Private

- (void)setupItems {
    CGFloat itemX = 0;
    CGFloat itemW = _scrollView.frame.size.width / _itemsTitle.count;;
    if (itemW < 75) {
        itemW = 75;
    }
    
    for (NSString *title in _itemsTitle) {
        
        LPSlideBarItem *item = [[LPSlideBarItem alloc]init];
        item.delegate = self;
        // Init the current item's frame
        item.frame = CGRectMake(itemX, 0, itemW, CGRectGetHeight(_scrollView.frame));
        [item setItemTitle:title];
        [_items addObject:item];
        [_scrollView addSubview:item];
        
        // Caculate the origin.x of the next item
        itemX = CGRectGetMaxX(item.frame);
    }
    
    // Cculate the scrollView 's contentSize by all the items
    _scrollView.contentSize = CGSizeMake(itemX, CGRectGetHeight(_scrollView.frame));
    
    // Set the default selected item, the first item
    LPSlideBarItem *firstItem = [self.items firstObject];
    firstItem.selected = YES;
    _selectedItem = firstItem;
    
    // Set the frame of sliderView by the selected item
//    _sliderView.frame = CGRectMake((firstItem.frame.size.width - [LPSlideBarItem widthForTitle:firstItem.title]) / 2, self.frame.size.height - SLIDER_VIEW_HEIGHT, [LPSlideBarItem widthForTitle:firstItem.title], SLIDER_VIEW_HEIGHT);
    _sliderView.frame = CGRectMake((firstItem.frame.size.width - itemW) / 2, self.frame.size.height - SLIDER_VIEW_HEIGHT, itemW, SLIDER_VIEW_HEIGHT);
}

- (void)scrollToVisibleItem:(LPSlideBarItem *)item {
    NSInteger selectedItemIndex = [self.items indexOfObject:_selectedItem];
    NSInteger visibleItemIndex = [self.items indexOfObject:item];
    
    // If the selected item is same to the item to be visible, nothing to do
    if (selectedItemIndex == visibleItemIndex) {
        return;
    }
    
    CGPoint offset = _scrollView.contentOffset;
    
    // If the item to be visible is in the screen, nothing to do
    if (CGRectGetMinX(item.frame) >= offset.x && CGRectGetMaxX(item.frame) <= (offset.x + CGRectGetWidth(_scrollView.frame))) {
        return;
    }
    
    // Update the scrollView's contentOffset according to different situation
    if (selectedItemIndex < visibleItemIndex) {
        // The item to be visible is on the right of the selected item and the selected item is out of screeen by the left, also the opposite case, set the offset respectively
        if (CGRectGetMaxX(_selectedItem.frame) < offset.x) {
            offset.x = CGRectGetMinX(item.frame);
        } else {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
        }
    } else {
        // The item to be visible is on the left of the selected item and the selected item is out of screeen by the right, also the opposite case, set the offset respectively
        if (CGRectGetMinX(_selectedItem.frame) > (offset.x + CGRectGetWidth(_scrollView.frame))) {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
        } else {
            offset.x = CGRectGetMinX(item.frame);
        }
    }
    _scrollView.contentOffset = offset;
}

- (void)addAnimationWithSelectedItem:(LPSlideBarItem *)item {
    // Caculate the distance of translation
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selectedItem.frame);
    
    // Add the animation about translation
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.fromValue = @(_sliderView.layer.position.x);
    positionAnimation.toValue = @(_sliderView.layer.position.x + dx);
    
    // Add the animation about size
    CABasicAnimation *boundsAnimation = [CABasicAnimation animation];
    boundsAnimation.keyPath = @"bounds.size.width";
    boundsAnimation.fromValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    boundsAnimation.toValue = @([LPSlideBarItem widthForTitle:item.title]);
    
    // Combine all the animations to a group
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation];
    animationGroup.duration = 0.2;
    [_sliderView.layer addAnimation:animationGroup forKey:@"basic"];
    
    // Keep the state after animating
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dx, _sliderView.layer.position.y);
    CGRect rect = _sliderView.layer.bounds;
//    rect.size.width = [LPSlideBarItem widthForTitle:item.title];
    _sliderView.layer.bounds = rect;
}

#pragma mark - Public

- (void)slideBarItemSelectedCallback:(LPSlideBarItemSelectedCallback)callback {
    _callback = callback;
}

- (void)selectSlideBarItemAtIndex:(NSUInteger)index {
    LPSlideBarItem *item = [self.items objectAtIndex:index];
    if (item == _selectedItem) {
        return;
    }
    [_scrollView scrollRectToVisible:CGRectMake((item.frame.origin.x-DEVICE_WIDTH/2)+item.frame.size.width/2, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:NO];
    item.selected = YES;
    //    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item];
    self.selectedItem = item;
    _callback([self.items indexOfObject:item]);
    for (LPSlideBarItem *items  in self.items) {
        items.selected=NO;
    }
    item.selected=YES;
}

- (void)moveIndexWithProgress:(float)propress {
    if (propress < 0 || propress > _items.count) {
        return;
    }
    CGFloat itemW = _scrollView.frame.size.width / _itemsTitle.count;;
    if (itemW < 75) {
        itemW = 75;
    }

    CGRect rect = CGRectMake(propress * itemW, self.frame.size.height - SLIDER_VIEW_HEIGHT, CGRectGetWidth(self.sliderView.frame), CGRectGetHeight(self.sliderView.frame));
    self.sliderView.frame = rect;
    [_scrollView scrollRectToVisible:CGRectMake((rect.origin.x-DEVICE_WIDTH/2)+rect.size.width/2, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
}

#pragma mark - FDSlideBarItemDelegate

- (void)slideBarItemSelected:(LPSlideBarItem *)item {
    if (item == _selectedItem) {
        return;
    }
    [_scrollView scrollRectToVisible:CGRectMake((item.frame.origin.x-DEVICE_WIDTH/2)+item.frame.size.width/2, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) animated:YES];
    //    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item];
    self.selectedItem = item;
    if (_callback) {
        _callback([self.items indexOfObject:item]);
    }
    for (LPSlideBarItem *items  in self.items) {
        items.selected=NO;
    }
    item.selected=YES;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
        _sliderColor = [UIColor redColor];
        _sliderView.backgroundColor = _sliderColor;
    }
    return _sliderView;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(DEVICE_WIDTH - self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
        _rightButton.backgroundColor = [UIColor whiteColor];
        [_rightButton setTitle:@"+" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _rightButton;
}

@end
