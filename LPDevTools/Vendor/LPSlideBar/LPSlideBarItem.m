//
//  LPSlideBarItem.m
//  LPDevTools
//
//  Created by 李鹏 on 2017/9/5.
//  Copyright © 2017年 lpdev.com. All rights reserved.
//

#import "LPSlideBarItem.h"

#define DEFAULT_TITLE_FONTSIZE [UIFont systemFontOfSize:12]
#define DEFAULT_TITLE_SELECTED_FONTSIZE [UIFont systemFontOfSize:12]
#define DEFAULT_TITLE_COLOR [UIColor grayColor]
#define DEFAULT_TITLE_SELECTED_COLOR [UIColor grayColor]

#define HORIZONTAL_MARGIN 10

@interface LPSlideBarItem ()

@property (nonatomic, assign) UIFont *font;
@property (nonatomic, assign) UIFont *selectedFont;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *selectedColor;

@end

@implementation LPSlideBarItem

#pragma mark - Lifecircle
- (instancetype)init {
    if (self = [super init]) {
        _font = DEFAULT_TITLE_FONTSIZE;
        _selectedFont = DEFAULT_TITLE_SELECTED_FONTSIZE;
        _color = DEFAULT_TITLE_COLOR;
        _selectedColor = DEFAULT_TITLE_SELECTED_COLOR;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat titleX = (CGRectGetWidth(self.frame) - [self titleSize].width) * 0.5;
    CGFloat titleY = (CGRectGetHeight(self.frame) - [self titleSize].height) * 0.5;
    
    CGRect titleRect = CGRectMake(titleX, titleY, [self titleSize].width, [self titleSize].height);
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont], NSForegroundColorAttributeName : [self titleColor]};
    [_title drawInRect:titleRect withAttributes:attributes];

}

#pragma mark - Custom Accessors

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

#pragma mark - Public

- (void)setItemTitle:(NSString *)title {
    _title = title;
    [self setNeedsDisplay];
}

- (void)setItemTitleFont:(UIFont *)font; {
    _font = font;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTileFont:(UIFont *)font {
    _selectedFont = font;
    [self setNeedsDisplay];
}

- (void)setItemTitleColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTitleColor:(UIColor *)color {
    _selectedColor = color;
    [self setNeedsDisplay];
}

#pragma mark - Private

- (CGSize)titleSize {
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont]};
    CGSize size = [_title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (UIFont *)titleFont {
    UIFont *font;
    if (_selected) {
        font = _selectedFont;
    } else {
        font = _font;
    }
    return font;
}

- (UIColor *)titleColor {
    UIColor *color;
    if (_selected) {
        color = _selectedColor;
    } else {
        color = _color;
    }
    return color;
}

#pragma mark - Public Class Method

+ (CGFloat)widthForTitle:(NSString *)title {
    NSDictionary *attributes = @{NSFontAttributeName : DEFAULT_TITLE_FONTSIZE};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width);
    
    return size.width;
}

#pragma mark - Responder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideBarItemSelected:)]) {
        [self.delegate slideBarItemSelected:self];
    }
}

@end
