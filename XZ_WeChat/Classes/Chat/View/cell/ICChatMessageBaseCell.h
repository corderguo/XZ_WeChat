//
//  ICChatMessageBaseCell.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/12.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICMessageFrame.h"
#import "UIResponder+GXRouter.h"
#import "ICMessageConst.h"
#import "ICHeadImageView.h"

@class ICChatMessageBaseCell;
@protocol BaseCellDelegate <NSObject>

- (void)longPress:(UILongPressGestureRecognizer *)longRecognizer;

@optional
- (void)headImageClicked:(NSString *)eId;
- (void)reSendMessage:(ICChatMessageBaseCell *)baseCell;

@end

@interface ICChatMessageBaseCell : UITableViewCell

@property (nonatomic, weak) id<BaseCellDelegate> longPressDelegate;

// 消息模型
@property (nonatomic, strong) ICMessageFrame *modelFrame;
// 头像
@property (nonatomic, strong) ICHeadImageView *headImageView;
// 内容气泡视图
@property (nonatomic, strong) UIImageView *bubbleView;
// 菊花视图所在的view
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
// 重新发送
@property (nonatomic, strong) UIButton *retryButton;



@end
