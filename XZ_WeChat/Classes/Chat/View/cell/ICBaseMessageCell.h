//
//  ICBaseMessageCell.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/8.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CellLineStyle) {
    CellLineStyleDefault,
    CellLineStyleFill,
    CellLineStyleNone
};

@interface ICBaseMessageCell : UITableViewCell
/** 边界线 */
@property (nonatomic, assign) CellLineStyle bottomLineStyle;
@property (nonatomic, assign) CellLineStyle topLineStyle;

@property (nonatomic, assign) CGFloat leftFreeSpace; // 低线的左边距

@property (nonatomic, assign) CGFloat rightFreeSpace;

@property (nonatomic, weak) UIView *bottomLine;


@end
