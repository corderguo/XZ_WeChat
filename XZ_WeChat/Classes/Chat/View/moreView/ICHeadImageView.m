//
//  ICHeadImageView.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/8.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICHeadImageView.h"

//static const CGFloat bordering = 4; // 边框

@interface ICHeadImageView ()

@property (nonatomic, assign) CGFloat bordering;

@end

@implementation ICHeadImageView

- (instancetype)init
{
    if (self = [super init]) {
        [self imageView];
        self.layer.masksToBounds  = YES;
        self.backgroundColor      = XZRGB(0xf0f0f0);
//        self.bordering            = 4;
        self.bordering            = 0;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}


- (void)layoutSubviews
{
    self.layer.cornerRadius = self.frame.size.width*0.5;
    self.imageView.width = self.frame.size.width - _bordering;
    self.imageView.height = self.frame.size.height - _bordering;
    self.imageView.layer.cornerRadius = self.imageView.width*0.5;

    self.imageView.centerX = self.width*0.5;
    self.imageView.centerY = self.height*0.5;
}

- (void)setColor:(UIColor *)color bording:(CGFloat)bord
{
    self.backgroundColor = color;
    self.bordering       = bord;
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.layer.masksToBounds = YES;
        [self addSubview:imageV];
        _imageView = imageV;
    }
    return _imageView;
}


@end
