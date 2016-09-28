//
//  ICEmotionMenuButton.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/5.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICEmotionMenuButton.h"

@implementation ICEmotionMenuButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        self.titleLabel.font  = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}







@end
