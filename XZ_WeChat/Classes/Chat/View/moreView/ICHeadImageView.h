//
//  ICHeadImageView.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/8.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICHeadImageView : UIView

@property (nonatomic, weak) UIImageView *imageView;

- (void)setColor:(UIColor *)color bording:(CGFloat)bording;

@end
