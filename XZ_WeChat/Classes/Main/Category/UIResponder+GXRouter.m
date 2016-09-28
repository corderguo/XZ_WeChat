//
//  UIResponder+GXRouter.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/17.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "UIResponder+GXRouter.h"

@implementation UIResponder (GXRouter)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
