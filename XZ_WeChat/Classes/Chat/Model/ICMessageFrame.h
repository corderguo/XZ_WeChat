//
//  ICMessageFrame.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/11.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <Foundation/Foundation.h>

@class ICMessageModel;

@interface ICMessageFrame : NSObject

//聊天信息的背景图
@property (nonatomic, assign, readonly) CGRect bubbleViewF;

//聊天信息label
@property (nonatomic, assign, readonly) CGRect chatLabelF;

//发送的菊花视图
@property (nonatomic, assign, readonly) CGRect activityF;

//重新发送按钮
@property (nonatomic, assign, readonly) CGRect retryButtonF;

// 头像
@property (nonatomic, assign, readonly) CGRect headImageViewF;

// topView   /***第一版***/
@property (nonatomic, assign, readonly) CGRect topViewF;

//计算总的高度
@property (nonatomic, assign) CGFloat cellHight;

/// 消息模型
@property (nonatomic, strong) ICMessageModel *model;

/// 图片
@property (nonatomic, assign, readonly) CGRect picViewF;

/// 语音图标
@property (nonatomic, assign) CGRect voiceIconF;

/// 语音时长数字
@property (nonatomic, assign) CGRect durationLabelF;

/// 语音未读红点
@property (nonatomic, assign) CGRect redViewF;


@end
