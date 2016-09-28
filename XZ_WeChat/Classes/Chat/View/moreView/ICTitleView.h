//
//  ICTitleView.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/5/12.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICSearchBar;

@protocol ICTitleViewDelegate <NSObject>

- (void)cancelBtnClicked;

- (void)searchText:(NSString *)text;

@end

@interface ICTitleView : UIView

@property (nonatomic, weak) id<ICTitleViewDelegate>delegate;

@end
