//
//  XZEmotion.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import "XZEmotion.h"

@implementation XZEmotion

- (BOOL)isEqual:(XZEmotion *)emotion
{
    return [self.face_name isEqualToString:emotion.face_name] || [self.code isEqualToString:emotion.code];
}

@end
