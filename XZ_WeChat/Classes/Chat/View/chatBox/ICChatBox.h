//
//  ICChatBox.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/10.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICChatConst.h"


@class ICChatBox;
@protocol ICChatBoxDelegate <NSObject>
/**
 *  输入框状态(位置)改变
 *
 *  @param chatBox    chatBox
 *  @param fromStatus 起始状态
 *  @param toStatus   目的状态
 */
- (void)chatBox:(ICChatBox *)chatBox changeStatusForm:(ICChatBoxStatus)fromStatus to:(ICChatBoxStatus)toStatus;

/**
 *  发送消息
 *
 *  @param chatBox     chatBox
 *  @param textMessage 消息
 */
- (void)chatBox:(ICChatBox *)chatBox sendTextMessage:(NSString *)textMessage;

/**
 *  输入框高度改变
 *
 *  @param chatBox chatBox
 *  @param height  height
 */
- (void)chatBox:(ICChatBox *)chatBox changeChatBoxHeight:(CGFloat)height;

/**
 *  开始录音
 *
 *  @param chatBox chatBox
 */
- (void)chatBoxDidStartRecordingVoice:(ICChatBox *)chatBox;
- (void)chatBoxDidStopRecordingVoice:(ICChatBox *)chatBox;
- (void)chatBoxDidCancelRecordingVoice:(ICChatBox *)chatBox;
- (void)chatBoxDidDrag:(BOOL)inside;


@end


@interface ICChatBox : UIView
/** 保存状态 */
@property (nonatomic, assign) ICChatBoxStatus status;

@property (nonatomic, weak) id<ICChatBoxDelegate>delegate;

/** 输入框 */
@property (nonatomic, strong) UITextView *textView;


@end
