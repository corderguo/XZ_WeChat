//
//  ICMessageConst.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/17.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <Foundation/Foundation.h>


#define MessageFont [UIFont systemFontOfSize:16.0]

/************Const*************/

extern CGFloat const HEIGHT_STATUSBAR;
extern CGFloat const HEIGHT_NAVBAR;
extern CGFloat const HEIGHT_CHATBOXVIEW;






/************Event*************/

extern NSString *const GXRouterEventVoiceTapEventName;
extern NSString *const GXRouterEventImageTapEventName;
extern NSString *const GXRouterEventTextUrlTapEventName;
extern NSString *const GXRouterEventMenuTapEventName;
extern NSString *const GXRouterEventVideoTapEventName;
extern NSString *const GXRouterEventShareTapEvent;

extern NSString *const GXRouterEventVideoRecordExit;
extern NSString *const GXRouterEventVideoRecordCancel;
extern NSString *const GXRouterEventVideoRecordFinish;
extern NSString *const GXRouterEventVideoRecordStart;
extern NSString *const GXRouterEventURLSkip;
extern NSString *const GXRouterEventScanFile;



/************Name*************/

extern NSString *const MessageKey;
extern NSString *const VoiceIcon;
extern NSString *const RedView;
// 消息类型
extern NSString *const TypeSystem;
extern NSString *const TypeText;
extern NSString *const TypeVoice;
extern NSString *const TypePic;
extern NSString *const TypeVideo;
extern NSString *const TypeFile;
extern NSString *const TypePicText;

/** 消息类型的KEY */
extern NSString *const MessageTypeKey;
extern NSString *const VideoPathKey;

extern NSString *const GXSelectEmotionKey;






/************Notification*************/

extern NSString *const GXEmotionDidSelectNotification;
extern NSString *const GXEmotionDidDeleteNotification;
extern NSString *const GXEmotionDidSendNotification;
//extern NSString *const NotificationReceiveUnreadMessage;
extern NSString *const NotificationDidCreatedConversation;
extern NSString *const NotificationFirstMessage;
extern NSString *const NotificationDidUpdateDeliver;
extern NSString *const NotificationPushDidReceived;
extern NSString *const NotificationDeliverChanged;
extern NSString *const NotificationBackMsgNotification;
extern NSString *const NotificationGPhotoDidChanged;
extern NSString *const NotificationReloadDataIMSource;
extern NSString *const NotificationUserHeadImgChangedNotification;
extern NSString *const NotificationKickUserNotification;
extern NSString *const NotificationShareExitNotification;
// 取消分享
extern NSString *const ICShareCancelNotification ;
// 确认分享
extern NSString *const ICShareConfirmNotification;
extern NSString *const ICShareStayInAppNotification;
extern NSString *const ICShareBackOtherAppNotification;


