//
//  ICVoiceHud.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/5/18.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICVoiceHud.h"

@interface ICVoiceHud ()
{
    NSArray *_images;
}

@end

@implementation ICVoiceHud


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.animationDuration    = 0.5;
        self.animationRepeatCount = -1;
        _images                   = @[
                                      [UIImage imageNamed:@"voice_1"],
                                      [UIImage imageNamed:@"voice_2"],
                                      [UIImage imageNamed:@"voice_3"],
                                      [UIImage imageNamed:@"voice_4"],
                                      [UIImage imageNamed:@"voice_5"],
                                      [UIImage imageNamed:@"voice_6"]
                                      ];
    }
    return self;
}


- (void)setProgress:(CGFloat)progress
{
    _progress         = MIN(MAX(progress, 0.f),1.f);
    [self updateImages];
}


- (void)updateImages
{
    if (_progress == 0) {
        self.animationImages = nil;
        [self stopAnimating];
        return;
    }
    if (_progress >= 0.8 ) {
        self.animationImages = @[_images[3],_images[4],_images[5],_images[4],_images[3]];
    } else {
        self.animationImages = @[_images[0],_images[1],_images[2],_images[1]];
    }
    [self startAnimating];
}




@end
