//
//  ICChatBoxViewControllerDelegate.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/22.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <Foundation/Foundation.h>

@class ICMessage;
@class ICChatBoxViewController;
@class ICVideoView;

@protocol ICChatBoxViewControllerDelegate <NSObject>

// change chatBox height
- (void) chatBoxViewController:(ICChatBoxViewController *)chatboxViewController
        didChangeChatBoxHeight:(CGFloat)height;
/**
 *  send text message
 *
 *  @param chatboxViewController chatboxViewController
 *  @param messageStr            text
 */
- (void) chatBoxViewController:(ICChatBoxViewController *)chatboxViewController
               sendTextMessage:(NSString *)messageStr;
/**
 *  send image message
 *
 *  @param chatboxViewController ICChatBoxViewController
 *  @param image                 image
 *  @param imgPath               image path
 */
- (void) chatBoxViewController:(ICChatBoxViewController *)chatboxViewController
              sendImageMessage:(UIImage *)image
                     imagePath:(NSString *)imgPath;

/**
 *  send voice message
 *
 *  @param chatboxViewController ICChatBoxViewController
 *  @param voicePath             voice path
 */
- (void) chatBoxViewController:(ICChatBoxViewController *)chatboxViewController sendVoiceMessage:(NSString *)voicePath;

- (void) voiceDidStartRecording;
// voice太短
- (void) voiceRecordSoShort;

- (void) voiceWillDragout:(BOOL)inside;

- (void) voiceDidCancelRecording;


- (void) chatBoxViewController:(ICChatBoxViewController *)chatboxViewController
            didVideoViewAppeared:(ICVideoView *)videoView;


- (void) chatBoxViewController:(ICChatBoxViewController *)chatboxViewController sendVideoMessage:(NSString *)videoPath;

- (void) chatBoxViewController:(ICChatBoxViewController *)chatboxViewController sendFileMessage:(NSString *)fileName;



@end
