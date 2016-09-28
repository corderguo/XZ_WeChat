//
//  ICTextField.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/28.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICTextField.h"

@implementation ICTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self becomeFirstResponder];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}








@end
