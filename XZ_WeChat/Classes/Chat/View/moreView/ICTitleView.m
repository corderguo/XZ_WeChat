//
//  ICTitleView.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/5/12.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICTitleView.h"
#import "ICSearchBar.h"

@interface ICTitleView ()<UITextFieldDelegate>

@end

@implementation ICTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        ICSearchBar *searchBar = [ICSearchBar searchBar];
        searchBar.x            = 12;
        searchBar.y            = self.height - 12 - 25;
        searchBar.width        = self.width-12*2-40-15;
        searchBar.height       = 25;
        searchBar.delegate     = self;
        [self addSubview:searchBar];
        [searchBar becomeFirstResponder];
        
        UIButton *cancelBtn    = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:IColor(255, 107, 0) forState:UIControlStateNormal];
        cancelBtn.titleLabel.font  = [UIFont systemFontOfSize:16.0];
        cancelBtn.width            = 40;
        cancelBtn.height           = 25;
        cancelBtn.x                = searchBar.right + 15;
        cancelBtn.y                = searchBar.y;
        [self addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)cancel
{
    if ([_delegate respondsToSelector:@selector(cancelBtnClicked)]) {
        [_delegate cancelBtnClicked];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0) {
        if ([_delegate respondsToSelector:@selector(searchText:)]) {
            [_delegate searchText:textField.text];
        }
        [textField endEditing:YES];
    }
    return YES;
}

@end
