//
//  ICBaseMessageCell.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/8.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICBaseMessageCell.h"

@interface ICBaseMessageCell ()

@property (nonatomic, weak) UIView *topLine;


@end

@implementation ICBaseMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self topLine];
        [self bottomLine];
        
        _topLineStyle = CellLineStyleNone;
        _bottomLineStyle = CellLineStyleDefault;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.topLine.y = 0;
    self.bottomLine.y = self.height - self.bottomLine.height;
    [self setBottomLineStyle:_bottomLineStyle];
    [self setTopLineStyle:_topLineStyle];
    
}

- (void)setTopLineStyle:(CellLineStyle)topLineStyle
{
    _topLineStyle = topLineStyle;
    if (topLineStyle == CellLineStyleDefault) {
        self.topLine.x = _leftFreeSpace;
        self.topLine.width = self.width - _leftFreeSpace;
        [self.topLine setHidden:NO];
    } else if (topLineStyle == CellLineStyleFill){
        self.topLine.x = 0;
        self.topLine.width = self.width;
        self.topLine.hidden = NO;
    } else if (topLineStyle == CellLineStyleNone){
        self.topLine.hidden = YES;
    }
}

- (void)setBottomLineStyle:(CellLineStyle)bottomLineStyle
{
    _bottomLineStyle = bottomLineStyle;
    if (bottomLineStyle == CellLineStyleDefault) {
        self.bottomLine.x = _leftFreeSpace;
        self.bottomLine.width = self.width - _leftFreeSpace - _rightFreeSpace;
        self.bottomLine.hidden = NO;
    } else if (bottomLineStyle == CellLineStyleFill) {
        self.bottomLine.x = 0;
        self.bottomLine.width = self.width;
        self.bottomLine.hidden = NO;
    } else if (bottomLineStyle == CellLineStyleNone) {
        self.bottomLine.hidden = YES;
    }
}


#pragma mark - getter and setter

- (UIView *)bottomLine
{
    if (nil == _bottomLine) {
        UIView *line = [[UIView alloc] init];
        line.height = 0.5f;
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.4;
        [self.contentView addSubview:line];
        _bottomLine = line;
    }
    return _bottomLine;
}

- (UIView *)topLine
{
    if (nil == _topLine) {
        UIView *line = [[UIView alloc] init];
        line.height = 0.5f;
        line.backgroundColor = [UIColor grayColor];
        line.alpha = 0.4;
        [self.contentView addSubview:line];
        _topLine = line;
    }
    return _topLine;
}


@end
