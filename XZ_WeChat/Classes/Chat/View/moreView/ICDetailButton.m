//
//  ICDetailButton.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/21.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICDetailButton.h"

@implementation ICDetailButton


- (instancetype)init
{
    if (self = [super init]) {
        [self.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.layer.cornerRadius = self.imageView.width*0.5;
        self.imageView.layer.masksToBounds = YES;
    }
    return self;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat X = contentRect.origin.x;
    CGFloat Y = contentRect.origin.y;
    CGFloat W = contentRect.size.width;
    CGFloat H = contentRect.size.height;
    
    CGFloat x = X + (W - 50)/2;
    CGFloat y = Y + (H - 50)/2 + 50;
    CGFloat w = 50;
    CGFloat h = 20;
    return CGRectMake(x,y,w,h);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat X = contentRect.origin.x;
    CGFloat Y = contentRect.origin.y;
    CGFloat W = contentRect.size.width;
    CGFloat H = contentRect.size.height;
    
    CGFloat x = X + (W - 50)/2;
    CGFloat y = Y + (H - 50)/2;
    CGFloat w = 50;
    CGFloat h = 50;
    return CGRectMake(x, y, w, h);
}


@end
